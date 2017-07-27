//
//  UIViewController+Extension.h
//  全民TV
//
//  Created by 金亮齐 on 2017/7/27.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)
/** Gif加载状态 */
@property(nonatomic, weak) UIImageView *gifView;

/** 主界面使用的加载 */
@property (nonatomic, weak) UIImageView *loadImageView;

/**
 *  显示GIF加载动画
 *
 *  @param images gif图片数组, 不传的话默认是自带的
 *  @param view   显示在哪个view上, 如果不传默认就是self.view
 */
- (void)showGifLoding:(NSArray *)images inView:(UIView *)view;

/**
 *  取消GIF加载动画
 */
- (void)hideGufLoding;


/** 开始显示loading视图 */
-(void)showLoading:(NSString*)text;
/** 关闭loading视图 */
-(void)hideLoading;


/** 显示无内容视图(只写了一种) */
- (void)showNoContentView;

/** 隐藏无内容视图 */
- (void)hideNoContentView;
@end
