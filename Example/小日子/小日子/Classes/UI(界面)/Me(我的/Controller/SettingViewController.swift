//
//  SettingViewController.swift
//  小日子
//
//  Created by 金亮齐 on 2017/2/21.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    
    private lazy var images: NSMutableArray! = {
        var array = NSMutableArray(array: ["score", "recommendfriend", "about",  "feedback","score", "remove"])
        return array
    }()
    
    private lazy var titles: NSMutableArray! = {
        var array = NSMutableArray(array: ["去GitHub点赞", "推荐给朋友", "关于我们", "去博客评论","关注我的微博,和作者交流", "清理缓存"])
        return array
    }()
    
    private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /** 设置tableView */
        setTableView()
        
        navigationItem.title = "设置"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func setTableView(){
        tableView = UITableView(frame: view.bounds, style: .Plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.colorWith(247, green: 247, blue: 247, alpha: 1)
        tableView.rowHeight = 50
        tableView.separatorStyle = .None
        tableView.registerNib(UINib(nibName: "SettingCell", bundle: nil ),forCellReuseIdentifier: "settingCell")
        view.addSubview(tableView)
    }
    deinit{
        print("设置控制器被销毁了", terminator: "")

    }
}

extension SettingViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let  cell = SettingCell.settingCellWithTableView(tableView)
        cell.imageImageView.image = UIImage(named: (images[indexPath.row] as? String)!)
        cell.titleLabel.text = titles[indexPath.row] as? String
        
        if indexPath.row == SettingCellType.Clean.hashValue{
            cell.bottomView.hidden = true
            cell.sizeLabel.hidden = false
            cell.sizeLabel.text = String().stringByAppendingFormat("%.2f M", FileTool.folderSize(theme.cachesPath))
        }else {
            cell.bottomView.hidden = false
            cell.sizeLabel.hidden = true
        }
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == SettingCellType.About.hashValue {
            let aboutVC = AboutWeViewController()
            navigationController!.pushViewController(aboutVC, animated: true)

        } else if indexPath.row == SettingCellType.Recommend.hashValue {
            let share = ShareView.shareViewFromXib()
            share.shareVC = self
            let shareModel = ShareModel(shareTitle: "Swift开源项目:小日子", shareURL: theme.JianShuURL, image: UIImage(named: "author"), shareDetail: "Swift开源项目小日子,OC程序员学习Swift良心作品")
            share.shareModel = shareModel
            view.addSubview(share)
            share.showShareView(CGRectMake(0, AppHeight - theme.ShareViewHeight - NavigationH, AppWidth, theme.ShareViewHeight))
            
        } else if indexPath.row == SettingCellType.Clean.hashValue {
            weak var tmpSelf = self
            FileTool.cleanFolder(theme.cachesPath, complete: { () -> () in
                tmpSelf!.tableView.reloadData()
            })

        } else if indexPath.row == SettingCellType.GitHub.hashValue {
            theme.appShare.openURL(NSURL(string: theme.GitHubURL)!)

        } else if indexPath.row == SettingCellType.Blog.hashValue {
            theme.appShare.openURL(NSURL(string: theme.JianShuURL)!)
            
        } else if indexPath.row == SettingCellType.Sina.hashValue {
            theme.appShare.openURL(NSURL(string: theme.sinaURL)!)
            
        }
    }
}
