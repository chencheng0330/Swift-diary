//
//  Common.swift
//  全民
//
//  Created by 金亮齐 on 2017/9/5.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit
/// 归档路径
let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
let SELECTED_CHANNELS: String = "selectedChannels.archive" // 选择频道列表
let UNSELECTED_CHANNELS: String = "unselectedChannels.archive" // 未选择频道列表
let PAGE_TITLES: String = "pagetitles.archive" // 保存的pagetitles
let HOME_CHILDVCS: String = "childvcs" // 首页contentView中的子控制器
let DEFAULT_CHILDVCS: String = "default" // 首页初始化的子控制器
let ALL_GMES: String = "GameVC.archive"


///服务器请求的地址
let QUANMIN_TV_JSON = "http://www.quanmin.tv/json/"
let HOME_OTHER_JSON = "http://www.quanmin.tv/json/categories/"
let LIST_JSON       =  "/list.json?"
let List_iphone_json = "/list-iphone.json?"




/// notification
let NotifyUpdateCategory = NSNotification.Name(rawValue:"notifyUpdateCategory")
let KSelectedChannel: String = "selectedChannel"
/// 常用属性
let kItemMargin : CGFloat = 10
let kHeaderViewH : CGFloat = 50
let kNormalItemW = (kScreenW - 3 * kItemMargin) / 2
let kNormalItemH = kNormalItemW * 3 / 4
let NormalCellID = "NormalCellID"
let SearchCellID = "SearchCellID"
let HeaderViewID = "HeaderViewID"

let kStatusBarH: CGFloat = 20
let kNavigationBarH: CGFloat = 44
let kTabBarH: CGFloat = 49
let kScreenW = UIScreen.main.bounds.width
let kScreenH = UIScreen.main.bounds.height
/// 初始化common
let common = Common()

class Common: NSObject {
    // MARK: -  创建一个barButtonItem
    class func itemWithImage(_ image:UIImage,highlightImage:UIImage,target:UIViewController,action:Selector) -> UIBarButtonItem{
        let button = UIButton.init()
        button.setBackgroundImage(image, for: UIControlState())
        button.setBackgroundImage(highlightImage, for: .highlighted)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem.init(customView: button)
    }
    
    // MARK: -解档归档(保存的是GameModel数组)
    // 归档
    func archiveData(channel: [ColumnModel], appendPath: String) {
        let filePath = path.appendingPathComponent(appendPath)
        NSKeyedArchiver.archiveRootObject(channel, toFile: filePath)
    }
    
    //反归档
    func unarchiveData(appendPath: String) -> ([ColumnModel]?) {
        let filePath = path.appendingPathComponent(appendPath)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [ColumnModel]
    }
    
    // MARK: -解档归档(保存的是String数组)
    // 归档
    func archiveWithStringArray(channel: [String], appendPath: String) {
        let filePath = path.appendingPathComponent(appendPath)
        NSKeyedArchiver.archiveRootObject(channel, toFile: filePath)
    }
    
    //反归档
    func unarchiveToStringArray(appendPath: String) -> ([String]?) {
        let filePath = path.appendingPathComponent(appendPath)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [String]
    }
    
    ///
    func archive(array: [AnyObject], appendPath: String) {
        let filePath = path.appendingPathComponent(appendPath)
        NSKeyedArchiver.archiveRootObject(array, toFile: filePath)
    }
    
    func unarchive(appendPath: String) -> ([AnyObject]?) {
        let filePath = path.appendingPathComponent(appendPath)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! ([AnyObject]?)
    }
}

