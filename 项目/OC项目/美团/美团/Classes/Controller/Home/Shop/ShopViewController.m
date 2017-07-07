//
//  ShopViewController.m
//  美团
//
//  Created by 金亮齐 on 2017/7/4.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import "ShopViewController.h"
#import "ShopInfoModel.h"
#import "ShopRecommendModel.h"
#import "HotQueueViewController.h"
#import "ShopImageCell.h"
#import "ShopPriceCell.h"
#import "ShopRecommendCell.h"

@interface ShopViewController ()
//<UITableViewDelegate,UITableViewDataSource>
{
    UILabel *_titleLabel;
    UIActivityIndicatorView *_activityView;
    
    //数据源
    ShopInfoModel *_shopInfoM;
    
    NSString *_recommendTitle;
    NSMutableArray *_shopRecommendArray;
}

@end

@implementation ShopViewController

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
    
    [self initData];
    [self setNav];
    [self initView];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self getShopData];
        [self getShopRecommendData];
    });
    // Do any additional setup after loading the view.
}
-(void)initData{
    _shopInfoM = [[ShopInfoModel alloc]init];
    _shopRecommendArray = [[NSMutableArray alloc]init];
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
    
    //收藏
    UIButton *collecBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    collecBtn.frame = CGRectMake(screen_width-44, 20, 44, 44);
    [collecBtn setImage:[UIImage imageNamed:@"icon_collect"] forState:UIControlStateNormal];
    [collecBtn setImage:[UIImage imageNamed:@"icon_collect_highlighted"] forState:UIControlStateHighlighted];
    [backView addSubview:collecBtn];
    
    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(screen_width-66, 30, 22, 22);
    [shareBtn setImage:[UIImage imageNamed:@"icon_merchant_share_normal"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"icon_merchant_share_highlighted"] forState:UIControlStateHighlighted];
    [shareBtn addTarget:self action:@selector(OnShareBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:shareBtn];
    
}
-(void)initView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64) style:UITableViewStyleGrouped];
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.hidden = YES;
    
    _activityView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(screen_width/2-15, screen_height/2-15, 30, 30)];
    _activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    _activityView.hidesWhenStopped = YES;
    [self.view addSubview:_activityView];
    [self.view bringSubviewToFront:_activityView];
}

#pragma makr - 点击事件
-(void)OnBackBtn:(UIButton *)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)OnShareBtn:(UIButton *)sender{
    
}

#pragma mark - 请求数据
-(void)getShopData{
    NSString *Str1 = @"http://api.meituan.com/group/v1/deal/list/id/";
    NSString *Str2 = @"?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=4NDQ%2BojQ%2BZGArOWQCEgWI19Pzus%3D&__skno=803C28CE-8BA8-4831-B2DE-7BCD484348D9&__skts=1435888257.411030&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&ci=1&client=iphone&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-03-09-14430&userid=10086&utm_campaign=AgroupBgroupC1080988208017226240_c0_e68cafa9e104898bb8bfcd78b64aef671D100Fab_i_group_5_3_poidetaildeallist__a__b___ab_chunceshishuju__a__a___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_gxtest__gd__leftflow___ab_waimaiwending__a__a___ab_gxh_82__nostrategy__leftflow___i_group_5_2_deallist_poitype__d__d___ab_b_food_57_purepoilist_extinfo__a__a___ab_pindaoshenyang__a__leftflow___ab_pindaoquxincelue0630__b__b1___ab_waimaizhanshi__b__b1___a20141120nanning__m1__leftflow___b1junglehomepagecatesort__b__leftflow___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGhomepage_guess_27774127&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",Str1,self.shopID,Str2];
    __weak __typeof(self) weakself = self;
    [_activityView startAnimating];
    [[NetworkSingleton sharedManager] getShopResult:nil url:urlStr successBlock:^(id responseBody) {
        NSLog(@"店铺详情请求成功");
        NSMutableArray *dataDic = [responseBody objectForKey:@"data"];
        _shopInfoM = [ShopInfoModel mj_objectWithKeyValues:dataDic[0]];
        
        weakself.tableView.hidden = NO;
        [_activityView stopAnimating];
        [weakself.tableView reloadData];
    } failureBlock:^(NSString *error) {
        NSLog(@"店铺详情请求失败：%@",error);
    }];
}
-(void)getShopRecommendData{
    NSString *Str1 = @"http://api.meituan.com/group/v1/deal/recommend/collaborative?__skck=40aaaf01c2fc4801b9c059efcd7aa146&__skcy=hWCwhGYpNTG7TjXWHOwPykgoKX0%3D&__skno=433ACF85-E134-4FEC-94B5-DA35D33AC753&__skts=1436343274.685593&__skua=bd6b6e8eadfad15571a15c3b9ef9199a&__vhost=api.mobile.meituan.com&cate=0&ci=1&cityId=1&client=iphone&did=";
    NSString *Str2 = @"&district=-1&fields=id%2Cslug%2Cimgurl%2Cprice%2Ctitle%2Cbrandname%2Crange%2Cvalue%2Cmlls%2Csolds&hasbuy=0&latlng=0.000000%2C0.000000&movieBundleVersion=100&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-08-15-36746&offset=0&scene=view-v4&userId=10086&userid=10086&utm_campaign=AgroupBgroupD100Fab_i550poi_ktv__d__j___ab_i_group_5_3_poidetaildeallist__a__b___ab_gxhceshi0202__b__a___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_6_searchkuang__a__leftflow___i_group_5_2_deallist_poitype__d__d___ab_i550poi_xxyl__b__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___ab_waimaiwending__a__a___ab_waimaizhanshi__b__b1___ab_i550poi_lr__d__leftflow___ab_i_group_5_5_onsite__b__b___ab_xinkeceshi__b__leftflowGhomepage_guess_27774127&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7";
    NSString *urlStr = [NSString stringWithFormat:@"%@%@%@",Str1,self.shopID,Str2];
    
    __weak __typeof(self) weakself = self;
    [[NetworkSingleton sharedManager] getShopRecommendResult:nil url:urlStr successBlock:^(id responseBody) {
        NSLog(@"店铺推荐请求成功");
        NSDictionary *dataDic = [responseBody objectForKey:@"data"];
        _recommendTitle = [dataDic objectForKey:@"title"];
        NSMutableArray *dealsArray = [dataDic objectForKey:@"deals"];
        for (int i = 0; i < dealsArray.count; i++) {
            ShopRecommendModel *shopRM = [ShopRecommendModel mj_objectWithKeyValues:dealsArray[i]];
            [_shopRecommendArray addObject:shopRM];
        }
        weakself.tableView.hidden = NO;
        [_activityView stopAnimating];
        [weakself.tableView reloadData];
    } failureBlock:^(NSString *error) {
        
    }];
    
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 3;
    }else if (section == 1){
        if (_shopRecommendArray.count == 0) {
            return 0;
        }else{
            return _shopRecommendArray.count + 1;
        }
    }else{
        return 1;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            return 190;
        }else if (indexPath.row == 1){
            return 65;
        }else{
            return 45;
        }
    }else{
        if (indexPath.row == 0) {
            return 30;
        }else{
            return 100;
        }
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            static NSString *cellIndentifier = @"shopImageCell";
            ShopImageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[ShopImageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            if (_shopInfoM.mname != nil) {
                NSString *imgUrl = [_shopInfoM.imgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"300.0"];
                [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
                cell.shopNameLabel.text = _shopInfoM.mname;
                cell.shopTitleLabel.text = _shopInfoM.title;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if (indexPath.row ==1 ){
            static NSString *cellIndentifier = @"shopPriceCell";
            ShopPriceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[ShopPriceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            if (_shopInfoM.mname != nil) {
                cell.priceLabel.text = [NSString stringWithFormat:@"%.2f元",[_shopInfoM.price doubleValue]];
                cell.oldPriceLabel.text = [NSString stringWithFormat:@"%.2f元",[_shopInfoM.value doubleValue]];
                
                NSDictionary *attribtDic = @{NSStrikethroughColorAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleNone]};
                NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f元",[_shopInfoM.value doubleValue]] attributes:attribtDic];
                cell.oldPriceLabel.attributedText = attribtStr;
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *cellIndentifier = @"shopSoldedCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
                
                UIButton *tuiBtn = [UIButton buttonWithType:UIButtonTypeCustom];
                tuiBtn.frame = CGRectMake(0, 5, 100, 30);
                tuiBtn.tag = 10;
                tuiBtn.font = [UIFont systemFontOfSize:13];
                [tuiBtn setImage:[UIImage imageNamed:@"icon_deal_anytime_refund"] forState:UIControlStateNormal];
                [tuiBtn setTitle:@"随时退" forState:UIControlStateNormal];
                [tuiBtn setTitleColor:RGB(126, 171, 63) forState:UIControlStateNormal];
                [cell.contentView addSubview:tuiBtn];
                
                //已销
                UILabel *solderLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(tuiBtn.frame)+10, 5, 100, 30)];
                solderLabel.textColor = [UIColor lightGrayColor];
                solderLabel.font = [UIFont systemFontOfSize:13];
                solderLabel.text = @"已销";
                solderLabel.tag = 11;
                [cell.contentView addSubview:solderLabel];
                
            }
            UIButton *tuiBtn =(UIButton *)[cell viewWithTag:10];
            [tuiBtn addTarget:self action:@selector(OnTuiBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            UILabel *soldedLabel = (UILabel *)[cell viewWithTag:11];
            if (_shopInfoM.mname !=nil) {
                soldedLabel.text = [NSString stringWithFormat:@"已售%@",_shopInfoM.solds];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            static NSString *cellIndentifier = @"shopRecCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            cell.textLabel.text = _recommendTitle;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            static NSString *cellIndentifier = @"shopRecInfoCell";
            ShopRecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
            if (cell == nil) {
                cell = [[ShopRecommendCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            }
            if (_shopRecommendArray.count !=0) {
                ShopRecommendModel *shopRM = _shopRecommendArray[indexPath.row-1];
                [cell setShopRecM:shopRM];
            }
            return cell;
        }
    }
    
    static NSString *cellIndentifier = @"shopCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        if (indexPath.row>0) {
            ShopRecommendModel *shopRM = _shopRecommendArray[indexPath.row-1];
            ShopViewController *shopVC = [[ShopViewController alloc] init];
            shopVC.shopID = [NSString stringWithFormat:@"%@",shopRM.id];
            [self.navigationController pushViewController:shopVC animated:YES];
            
        }
    }
}

-(void)OnTuiBtn:(UIButton *)sender{
    NSString *urlStr = @"http://i.meituan.com/commitment?ci=1&f=iphone&msid=48E2B810-805D-4821-9CDD-D5C9E01BC98A2015-07-08-13-30316&token=p19ukJltGhla4y5Jryb1jgCdKjsAAAAAsgAAADHFD3UYGxaY2FlFPQXQj2wCyCrhhn7VVB-KpG_U3-clHlvsLM8JRrnZK35y8UU3DQ&userid=10086&utm_campaign=AgroupBgroupD100Fab_waimaizhanshi__b__b1___ab_chunceshishuju__a__a___ab_gxhceshi__nostrategy__leftflow___ab_gxhceshi0202__b__a___ab_pindaochangsha__a__leftflow___ab_xinkeceshi__b__leftflow___ab_waimaiwending__a__a___ab_gxtest__gd__leftflow___ab_gxh_82__nostrategy__leftflow___ab_pindaoshenyang__a__leftflow___ab_b_food_57_purepoilist_extinfo__a__a___i_group_5_2_deallist_poitype__d__d___ab_i_group_5_3_poidetaildeallist__a__b___a20141120nanning__m1__leftflow___b1junglehomepagecatesort__b__leftflow___ab_pindaoquxincelue0630__b__b1___ab_i_group_5_5_onsite__b__b___ab_i_group_5_6_searchkuang__a__leftflowGhomepage_guess_27774127&utm_content=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&utm_medium=iphone&utm_source=AppStore&utm_term=5.7&uuid=4B8C0B46F5B0527D55EA292904FD7E12E48FB7BEA8DF50BFE7828AF7F20BB08D&version_name=5.7&lat=39.98348998997159&lng=116.3180011508709";
    HotQueueViewController *webVC = [[HotQueueViewController alloc] init];
    webVC.urlStr = urlStr;
    [self.navigationController pushViewController:webVC animated:YES];
}

@end
