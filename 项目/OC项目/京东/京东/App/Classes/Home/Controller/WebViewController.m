
//
//  WebViewController.m
//  京东
//
//  Created by 金亮齐 on 2017/6/21.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property(nonatomic,strong) UIWebView *webview;

@end


@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self WebView];
    self.view.backgroundColor=Color(240, 243, 245);
    
    [self setupNavigationItem];
}

-(void)WebView{
    _webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://github.com/qijinliang"]];
    
    [self.view addSubview:_webview];
    
    [_webview loadRequest:request];
}

- (void)setupNavigationItem {
    
    self.navigationItem.title = @"醉看红尘这场梦";

    self.navigationController.navigationBar.titleTextAttributes  = @ {
    NSForegroundColorAttributeName: [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]
    };
}
@end
