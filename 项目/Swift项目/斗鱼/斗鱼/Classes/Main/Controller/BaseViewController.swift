//
//  BaseViewController.swift
//  斗鱼
//
//  Created by 金亮齐 on 2017/8/18.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    // MARK: 定义属性
    var contentView : UIView?
    
    // MARK: 懒加载属性
    fileprivate lazy var animImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image: UIImage(named: "loading-1"))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named : "loading-1")!, UIImage(named : "loading-2")!,UIImage(named : "loading-3")!,UIImage(named : "loading-4")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
        }()
    
    // MARK: 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpMainView()
    }
}
// MARK: - 设置UI
extension BaseViewController {
    func setUpMainView() {
        // 1.隐藏内容的View
        contentView?.isHidden = true
        
        // 2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        
        // 3.给animImageView执行动画
        animImageView.startAnimating()
        
        // 4.设置view的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    func loadDataFinished() {
        // 1.停止动画
        animImageView.stopAnimating()
        
        // 2.隐藏animImageView
        animImageView.isHidden = true
        
        // 3.显示内容的View
        contentView?.isHidden = false
    }
}
