//
//  NetworkTool.swift
//  今日头条
//
//  Created by 金亮齐 on 2017/9/27.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol NetworkToolProtocol {
    
    /// 解析视频的真实链接
    static func parseVideoRealURL(video_id: String, completionHandler:@escaping (_ realVideo: RealVideo)->())
    /// 获取首页不同分类的新闻内容(和视频内容使用一个接口)
    static func loadHomeCategoryNewsFeed(category: String, completionHandler:@escaping (_ nowTime: TimeInterval,_ newsTopics: [WeiTouTiao])->())

    /// -------------------------- 视 频 video --------------------------
    /// 获取视频顶部标题内容
    static func loadVideoTitlesData(completionHandler:@escaping (_ videoTitles: [TopicTitle], _ videoTopicVCs: [VideoTopicController])->())
    
    // --------------------------------- 我的 mine  ---------------------------------
    /// 我的界面 cell 数据
    static func loadMineCellData(completionHandler: @escaping (_ sectionsArray: [AnyObject])->())
    /// 我的关注
    static func loadMyFollow(completionHandler: @escaping (_ concerns: [MyConcern])->())
    /// 关注详情
    static func loadOneFollowDetail(userId: Int, completionHandler: @escaping (_ follewDetail: FollowDetail)->())
}

class NetworkTool: NetworkToolProtocol {
    
    // 获取今日头条的视频真实链接可参考下面的博客
    // http://blog.csdn.net/dianliang01/article/details/73163086
    /// 解析视频的真实链接
    class func parseVideoRealURL(video_id: String, completionHandler:@escaping (_ realVideo: RealVideo)->()) {
        let r = arc4random() // 随机数
        let url: NSString = "/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)" as NSString
        let data: NSData = url.data(using: String.Encoding.utf8.rawValue)! as NSData
        var crc32 = data.getCRC32() // 使用 crc32 校验
        if crc32 < 0 { // crc32 的值可能为负数
            crc32 += 0x100000000
        }
        // 拼接
        let realURL = "http://i.snssdk.com/video/urls/v/1/toutiao/mp4/\(video_id)?r=\(r)&s=\(crc32)"
        Alamofire.request(realURL).responseJSON { (response) in
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                let dict = json["data"].dictionaryObject
                let video = RealVideo(dict: dict! as [String : AnyObject])
                completionHandler(video)
            }
        }
    }
    
    /// 获取首页不同分类的新闻内容(和视频内容使用一个接口)
    class func loadHomeCategoryNewsFeed(category: String, completionHandler:@escaping (_ nowTime: TimeInterval,_ newsTopics: [WeiTouTiao])->()) {
        let url = BASE_URL + "api/news/feed/v58/?"
        let params = ["device_id": device_id,
                      "category": category,
                      "iid": IID,
                      "device_platform": "iphone",
                      "version_code": versionCode]
        
        let nowTime = NSDate().timeIntervalSince1970
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            print(url)
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard let dataJSONs = json["data"].array else {
                    return
                }
                var topics = [WeiTouTiao]()
                for data in dataJSONs {
                    if let content = data["content"].string {
                        let contentData: NSData = content.data(using: String.Encoding.utf8)! as NSData
                        do {
                            let dict = try JSONSerialization.jsonObject(with: contentData as Data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            let topic = WeiTouTiao(dict: dict as! [String : AnyObject])
                            topics.append(topic)
                            print(dict)
                        } catch {
                            
                        }
                    }
                }
                completionHandler(nowTime, topics)
            }
        }
    }
    
    /// -------------------------- 视 频 video --------------------------
    
    /// 获取视频顶部标题内容
    class func loadVideoTitlesData(completionHandler:@escaping (_ videoTitles: [TopicTitle], _ videoTopicVCs: [VideoTopicController])->()) {
        let url = BASE_URL + "video_api/get_category/v1/?"
        let params = ["device_id": device_id,
                      "iid": IID]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            print(url)
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                if let data = json["data"].arrayObject {
                    var titles = [TopicTitle]()
                    var videoTopicVCs = [VideoTopicController]()
                    // 添加推荐标题
                    let recommendDict = ["category": "video", "name": "推荐"]
                    let recommend = TopicTitle(dict: recommendDict as [String : AnyObject])
                    titles.append(recommend)
                    // 添加控制器
                    let firstVC = VideoTopicController()
                    firstVC.videoTitle = recommend
                    videoTopicVCs.append(firstVC)
                    for dict in data {
                        let title = TopicTitle(dict: dict as! [String: AnyObject])
                        let videoTopicVC = VideoTopicController()
                        videoTopicVC.videoTitle = title
                        videoTopicVCs.append(videoTopicVC)
                        titles.append(title)
                    }
                    completionHandler(titles, videoTopicVCs)
                }
            }
        }
    }
    
    // --------------------------------- 我的 mine  ---------------------------------
    /// 我的界面 cell 数据
    class func loadMineCellData(completionHandler: @escaping (_ sectionsArray: [AnyObject])->()) {
        let url = BASE_URL + "user/tab/tabs/?"
        let params = ["iid": IID]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            print(url)
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    return
                }
                if let data = json["data"].dictionary {
                    if let sections = data["sections"]?.arrayObject {
                        var sectionArray = [AnyObject]()
                        for section in sections {
                            var rows = [MineCellModel]()
                            for row in section as! [AnyObject] {
                                let mineCell = MineCellModel(dict: row as! [String : AnyObject])
                                rows.append(mineCell)
                            }
                            sectionArray.append(rows as AnyObject)
                        }
                        completionHandler(sectionArray)
                    }
                }
            }
        }
    }
    
    /// 我的关注
    class func loadMyFollow(completionHandler: @escaping (_ concerns: [MyConcern])->()) {
        let url = BASE_URL + "concern/v2/follow/my_follow/?"
        let params = ["device_id": device_id]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            print(url)
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    return
                }
                if let datas = json["data"].arrayObject {
                    var concerns = [MyConcern]()
                    for data in datas {
                        let myConcern = MyConcern(dict: data as! [String: AnyObject])
                        concerns.append(myConcern)
                    }
                    
                    completionHandler(concerns)
                }
            }
        }
    }
    
    /// 关注详情
    class func loadOneFollowDetail(userId: Int, completionHandler: @escaping (_ follewDetail: FollowDetail)->()) {
        let url = BASE_URL + "user/profile/homepage/v3/?"
        let params = ["user_id": userId] as [String : Any]
        Alamofire.request(url, parameters: params).responseJSON { (response) in
            print(url)
            guard response.result.isSuccess else {
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                guard json["message"].string == "success" else {
                    return
                }
                let followDetail = FollowDetail(dict: json["data"].dictionaryObject! as [String : AnyObject])
                completionHandler(followDetail)
            }
        }
    }
}

