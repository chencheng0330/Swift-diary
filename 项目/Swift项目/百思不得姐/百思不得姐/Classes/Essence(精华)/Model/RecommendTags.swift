//
//  RecommendTags.swift
//  百思不得姐
//
//  Created by 金亮齐 on 2017/11/13.
//  Copyright © 2017年 金亮齐. All rights reserved.
//

import UIKit

class RecommendTags: NSObject {
    var image_list: String = ""
    var theme_name: String = ""
    var sub_number: Int = 0
    
    
    init(dict: [String: Any]) {
        super.init()
//        setValuesForKeys(dict)
        image_list = dict["image_list"] as! String
        theme_name = dict["theme_name"] as! String
        sub_number = Int(dict["sub_number"] as! String)!
    }
    
}
