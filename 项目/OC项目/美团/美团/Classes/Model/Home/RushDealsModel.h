//
//  RushDealsModel.h
//  美团
//
//  Created by 金亮齐 on 2017/7/10.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RushDealsModel : NSObject

@property(nonatomic, strong) NSNumber *dt;
@property(nonatomic, strong) NSString *brandname;
@property(nonatomic, strong) NSString *cate;
@property(nonatomic, strong) NSString *range;
@property(nonatomic, strong) NSString *mealcount;

@property(nonatomic, strong) NSNumber *status;
@property(nonatomic, strong) NSString *mtitle;
@property(nonatomic, strong) NSString *mdcLogoUrl;
@property(nonatomic, strong) NSString *smstitle;
@property(nonatomic, strong) NSMutableArray *campaigns;

@property(nonatomic, strong) NSString *squareimgurl;
@property(nonatomic, strong) NSNumber *ctype;
@property(nonatomic, strong) NSString *mlls;
@property(nonatomic, strong) NSString *subcate;
@property(nonatomic, strong) NSNumber *id;

@property(nonatomic, strong) NSMutableArray *attrJson;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSNumber *price;
@property(nonatomic, strong) NSNumber *festcanuse;
@property(nonatomic, strong) NSNumber *value;

@property(nonatomic, strong) NSString *coupontitle;
@property(nonatomic, strong) NSNumber *rating;
@property(nonatomic, strong) NSString *cateDesc;
@property(nonatomic, strong) NSNumber *nobooking;

@property(nonatomic, strong) NSNumber *campaignprice;
@property(nonatomic, strong) NSString *imgurl;

@end
