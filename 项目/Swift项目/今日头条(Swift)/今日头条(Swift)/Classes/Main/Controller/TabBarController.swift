//
//  TabBarController.swift
//  今日头条(Swift)
//
//  Created by 金亮齐 on 2017/5/18.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addChildViewControllers()
        // Do any additional setup after loading the view.
    }

    override class func initialize() {
        let tabBar = UITabBar.appearance()
        tabBar.tintColor = Color(111, g: 111, b: 111, a: 1.0)
    }
    

    //MARK: - 添加子控制器
    private func addChildViewControllers() {
        addChildViewController(HomeViewController(), title: "首页", imageName: "home_tabbar_22x22_", selectedImageName: "home_tabbar_press_22x22_")
        addChildViewController(VideoViewController(), title: "视频", imageName: "video_tabbar_22x22_", selectedImageName: "video_tabbar_press_22x22_")
        addChildViewController(NewCareViewController(), title: "关注", imageName: "newcare_tabbar_22x22_", selectedImageName: "newcare_tabbar_press_22x22_")
        addChildViewController(MineViewController(), title: "我的", imageName: "mine_tabbar_22x22_", selectedImageName: "mine_tabbar_press_22x22_")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addChildViewController(childController: UIViewController, title: String, imageName: String, selectedImageName: String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: selectedImageName)
        childController.title = title
        let nav = NavigationController(rootViewController: childController)
        addChildViewController(nav)
    }
}
