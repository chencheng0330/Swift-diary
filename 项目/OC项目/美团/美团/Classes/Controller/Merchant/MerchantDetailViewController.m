//
//  MerchantDetailViewController.m
//  美团
//
//  Created by 金亮齐 on 2017/7/4.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import "MerchantDetailViewController.h"
#import "MerDetailModel.h"
#import "MerAroundGroupModel.h"
#import "ShopViewController.h"
#import "MerDetailImageCell.h"
#import "MerAroundGroupCell.h"

@interface MerchantDetailViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UILabel *_titleLabel;
    NSMutableArray *_dataSourceArray;
    NSMutableArray *_dealsArray;
}

@end

@implementation MerchantDetailViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getMerchantDetailData];
        [self getAroundGroupPurchaseData];
    });
    
    [self initData];
    [self setNav];
    [self initTableView];
    // Do any additional setup after loading the view.
}

-(void)initData{
    _dataSourceArray  = [[NSMutableArray alloc]init];
    _dealsArray = [[NSMutableArray alloc]init];
}

-(void)setNav{
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = RGB(250, 250, 250);
    [self.view addSubview:backView];
    
    //下划线
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 63.5, screen_width, 0.5)];
    lineView.backgroundColor = RGB(192, 192, 192);
    [backView addSubview:lineView];

    //返回
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 20, 44, 44);
    [backBtn setImage:[UIImage imageNamed:@"btn_backItem"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(OnBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:backBtn];

    //标题
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(screen_width/2-80, 30, 160, 30)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = @"商家详情";
    [backView addSubview:_titleLabel];
    
    //收藏
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collectBtn.frame = CGRectMake(screen_width-10-23, 30, 22, 22);
    [collectBtn setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"icon_collect_highlighted"] forState:UIControlStateHighlighted];
    [backView addSubview:collectBtn];
    
    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(screen_width-10-23-10-23, 30, 22, 22);
    [shareBtn setImage:[UIImage imageNamed:@"icon_merchant_share_normal"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"icon_merchant_share_highlighted"] forState:UIControlStateHighlighted];
    [shareBtn addTarget:self action:@selector(OnShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:shareBtn];
    
}

-(void)OnBackBtn:(UIButton*)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//响应事件
-(void)OnShareBtn:(UIButton *)sender{

}

-(void)initTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

#pragma makr - 请求数据
-(void)getMerchantDetailData{
    NSString *str1 = @"http://api.meituan.com/group/v1/poi/";
    NSString *str2 = @"?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=8s5pIPqAHXfwBBOWjWssJ6yhpP4%3D&__skno=3A22D2FC-4CE5-461F-8022-49617F529895&__skts=1437114388.938075&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-17-14-20300&userid=10086&utm_campaign=AgroupBgroupE72175652459578368_c0_eb21e98ced02c66e9539669c2efedfec0D100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__b__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    __weak __typeof(self) weakself = self;
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",str1,self.poiid,str2];
    
    [[NetworkSingleton sharedManager] getMerchantDetailResult:nil url:urlStr successBlock:^(id responseBody) {
        NSMutableArray *dataArray = [responseBody objectForKey:@"data"];
        if (dataArray.count > 0) {
            [_dataSourceArray removeAllObjects];
            MerDetailModel *MerDetailM = [MerDetailModel mj_objectWithKeyValues:dataArray[0]];
            [_dataSourceArray addObject:MerDetailM];
        }
        [weakself.tableView reloadData];
    } failureBlock:^(NSString *error) {
        
    }];
}


//MARK: - 获取附近团购
-(void)getAroundGroupPurchaseData{
    NSString *str1 = @"http://api.meituan.com/group/v1/recommend/nearstoredeals/poi/";
    NSString *str2 = @"?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=%2BKcL58MgLDsQfcX88AImaqHXAIw%3D&__skno=CF7C3655-49A4-43AF-AFB5-2AE1D7768521&__skts=1437114388.913142&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-17-14-20300&offset=0&userId=10086&userid=10086&utm_campaign=AgroupBgroupE72175652459578368_c0_eb21e98ced02c66e9539669c2efedfec0D100Fa20141120nanning__m1__leftflow___ab_pindaochangsha__a__leftflow___ab_gxtest__gd__leftflow___ab_gxhceshi__nostrategy__leftflow___ab_i550poi_ktv__d__j___ab_chunceshishuju__a__a___ab_gxh_82__nostrategy__leftflow___ab_i_group_5_3_poidetaildeallist__a__b___b1junglehomepagecatesort__b__leftflow___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i550poi_xxyl__b__leftflow___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__b__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGmerchant&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",str1,self.poiid,str2];
    __weak __typeof(self) weakself = self;
    [[NetworkSingleton sharedManager] getAroundGroupPurchaseResult:nil url:urlStr successBlock:^(id responseBody) {
        NSLog(@"附近团购数据请求成功");
        NSDictionary *dataDic = [responseBody objectForKey:@"data"];
        NSMutableArray *dealsArray = [dataDic objectForKey:@"deals"];
        [_dealsArray removeAllObjects];
        for (int i = 0; i<dealsArray.count; i++ ) {
            MerAroundGroupModel *AroundM = [MerAroundGroupModel mj_objectWithKeyValues:dealsArray[i]];
            [_dealsArray addObject:AroundM];
        }
        [weakself.tableView reloadData];
    } failureBlock:^(NSString *error) {
        NSLog(@"附近团购请求失败:%@",error);
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource{
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_dealsArray.count>0) {
        return 3;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return _dealsArray.count+1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.1;
    }
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 160;
    }else if (indexPath.section == 1){
        return 54;
    }else if (indexPath.section == 2){
        if (indexPath.row > 0) {
            return 100;
        }
        return 40;
    }else{
        return 40;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        static NSString *cellIndentifier = @"detailCell0";
        MerDetailImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[MerDetailImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        if (_dataSourceArray.count>0) {
            MerDetailModel *MerDM = _dataSourceArray[0];
            cell.BigImgUrl = [MerDM.frontImg stringByReplacingOccurrencesOfString:@"w.h" withString:@"300.200"];
            cell.shopName = MerDM.name;
            cell.avgPrice = MerDM.avgPrice;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.section == 1){
        static NSString *cellIndentifier = @"detailCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            
            //位置坐标
            UIImageView * locationImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 18, 20, 20)];
            [locationImageView setImage:[UIImage imageNamed:@"icon_merchant_location"]];
            [cell addSubview:locationImageView];
            //位置信息
            UILabel *locationLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 4, screen_width-40-90, 50)];
            locationLabel.tag = 200;
            locationLabel.font = [UIFont systemFontOfSize:15];
            locationLabel.textColor = [UIColor grayColor];
            locationLabel.numberOfLines = 2;
            [cell addSubview:locationLabel];
            
            UIImageView *telImageView = [[UIImageView alloc]initWithFrame:CGRectMake(screen_width-35, 15, 19, 25)];
            [telImageView setImage:[UIImage imageNamed:@"icon_deal_phone"]];
            [cell addSubview:telImageView];
            
            if (_dataSourceArray.count > 0) {
                MerDetailModel *MerDM = _dataSourceArray[0];
                UILabel *locationLabel = (UILabel *)[cell viewWithTag:200];
                locationLabel.text = MerDM.addr;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.section == 2){
            static NSString *cellIndentifier = @"detailCell20";
             UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            if (_dealsArray.count > 0) {
                cell.textLabel.text = @"附近团购";
                cell.textLabel.textColor = [UIColor grayColor];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }else{
            static NSString *cellIndentifier = @"detailCell21";
            MerAroundGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[MerAroundGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            MerAroundGroupModel *jzAroundM = _dealsArray[indexPath.row-1];
            [cell setJzMerAroundM:jzAroundM];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else{
        static NSString *cellIndentifier = @"detailCell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        if (indexPath.row>0) {
            MerAroundGroupModel *AroundM = _dealsArray[indexPath.row-1];
            NSString *shopID = [AroundM.id stringValue];
            ShopViewController *shopVC = [[ShopViewController alloc]init];
            shopVC.shopID = shopID;
            [self.navigationController pushViewController:shopVC animated:YES];
        }
    }
}
@end
