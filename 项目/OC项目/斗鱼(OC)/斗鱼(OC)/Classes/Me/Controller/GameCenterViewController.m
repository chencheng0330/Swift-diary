//
//  GameCenterViewController.m
//  斗鱼(OC)
//
//  Created by 金亮齐 on 2017/6/2.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import "GameCenterViewController.h"

@interface GameCenterViewController ()

@end

@implementation GameCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"游戏中心";
    self.view.backgroundColor = [UIColor whiteColor];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


@end
