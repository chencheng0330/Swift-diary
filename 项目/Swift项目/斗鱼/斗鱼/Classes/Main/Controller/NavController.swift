//
//  NavController.swift
//  斗鱼
//
//  Created by 金亮齐 on 2017/8/16.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l < r
    case (nil, _?):
        return true
    default:
        return false
    }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
    switch (lhs, rhs) {
    case let (l?, r?):
        return l > r
    default:
        return rhs < lhs
    }
}

class NavController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 0.设置导航栏的颜色
        setUpNavAppearance ()
        
        // 1.创建Pan手势
        let target = navigationController?.interactivePopGestureRecognizer?.delegate
        let pan = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        pan.delegate = self
        self.view.addGestureRecognizer(pan)
        
        // 2.禁止系统的局部返回手势
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 拦截Push操作
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        // 这里判断是否进入push视图
        if (self.childViewControllers.count > 0) {
            let backBtn = UIButton(image: #imageLiteral(resourceName: "back"), highlightedImage: #imageLiteral(resourceName: "backBarButtonItem"), title: "返回",target: self, action: #selector(NavController.backClick))
            
            // 设置按钮内容左对齐
            backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left;
            // 内边距
            backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
            
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            // 隐藏要push的控制器的tabbar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc fileprivate func backClick() {
        popViewController(animated: true)
    }
}

extension NavController : UIGestureRecognizerDelegate{
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        ///判断是否是根控制器
        if self.childViewControllers.count == 1
        {
            return false
        }
        return true
    }
}


extension NavController  {
    fileprivate func setUpNavAppearance () {
        let navBar = UINavigationBar.appearance()
        if(Double(UIDevice.current.systemVersion)) > 8.0 {
            navBar.isTranslucent = true
        } else {
            self.navigationBar.isTranslucent  = true
        }
        
        navBar.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1.00)
        navBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white,NSFontAttributeName:UIFont.boldSystemFont(ofSize: 18)]
    }
}

extension NavController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is LiveViewController {
            navigationController.navigationBar.barTintColor = UIColor.white
        }else {
            navigationController.navigationBar.barTintColor = UIColor.orange
        }
    }
}

