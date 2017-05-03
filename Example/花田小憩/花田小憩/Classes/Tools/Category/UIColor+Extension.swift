//
//  UIColor+Extension.swift
//  花田小憩
//
//  Created by 金亮齐 on 2016/12/21.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//

import UIKit

extension UIColor
{
    /**
     根据RGB生成颜色
     
     - parameter r: red
     - parameter g: green
     - parameter b: blue
     
     - returns: 颜色
     */
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)
    }
    
    /**
     根据RGB生成颜色
     
     - parameter r: red
     - parameter g: green
     - parameter b: blue
     - parameter alpha: 透明度
     
     - returns: 颜色
     */
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    /**
     生成灰色
     
     - parameter gray: 灰色
     
     - returns: 颜色
     */
    convenience init(gray: CGFloat) {
        self.init(red: gray/255.0, green: gray/255.0, blue: gray/255.0, alpha: 1)
    }
}
