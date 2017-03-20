//
//  Constan.h
//  日日煮
//
//  Created by 金亮齐 on 2017/3/20.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#ifndef Constan_h
#define Constan_h

#import "RequestPaths.h"
#import "AppDelegate+Extension.h"
#import "UIView+MBProgressHUD.h"
#import "NSString+Extension.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "AFNetworkReachabilityManager.h"


/** 屏幕宽度 */
#define kScreenW [UIScreen mainScreen].bounds.size.width

/** 屏幕高度 */
#define kScreenH [UIScreen mainScreen].bounds.size.height

/** 三原色的设置 */
#define kRGBColor(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

/** Documents文件夹的路径 */
#define kDocPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

/** appdelegate的实例对象 */
#define kAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/** 把self转化为 __weak __block的方式, 方便的在block中使用而不导致内存循环应用问题 */

/** 在宏中使用 \ 可以换行 */
#define WK(weakSelf) \
__weak __typeof(&*self)weakSelf = self;\

/** Bundle路径 */
#define kMyBundlePath [[NSBundle mainBundle]pathForResource:@"MyBundle" ofType:@"bundle"]

#endif /* Constan_h */
