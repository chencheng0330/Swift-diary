//
//  MerchantCell.m
//  美团
//
//  Created by 金亮齐 on 2017/7/3.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import "MerchantCell.h"

@interface MerchantCell(){

    UIImageView *_merchantImage;
    UILabel *_merchantNameLabel;//店名
    
    UILabel *_cateNameLabel;//店名
    
    UILabel *_evaluateLabel;//评价个数
}

@end

@implementation MerchantCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //图
        _merchantImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 90, 72)];
        _merchantImage.layer.masksToBounds = YES;
        _merchantImage.layer.cornerRadius = 4;
        [self.contentView addSubview:_merchantImage];
        
        //店名
        _merchantNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 5, screen_width-110-10, 30)];
        _merchantNameLabel.font = [UIFont systemFontOfSize:15];
        _merchantNameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self.contentView addSubview:_merchantNameLabel];
        
        //cateName
        _cateNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, screen_width-110-10, 30)];
        _cateNameLabel.font = [UIFont systemFontOfSize:13];
        _cateNameLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_cateNameLabel];
        
        //星星
        for (int i = 0; i < 5; i++) {
            UIImageView *starImg = [[UIImageView alloc] initWithFrame:CGRectMake(110+i*14, 43, 12, 12)];
            starImg.tag = 30+i;
            [starImg setImage:[UIImage imageNamed:@"icon_feedCell_star_empty"]];
            [self.contentView addSubview:starImg];
        }
        
        //评价个数
        _evaluateLabel = [[UILabel alloc] initWithFrame:CGRectMake(110+5*14, 40, 80, 20)];
        _evaluateLabel.font = [UIFont systemFontOfSize:13];
        _evaluateLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_evaluateLabel];
        
        
        //下划线
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 91.5, screen_width, 0.5)];
        lineView.backgroundColor = RGB(192, 192, 192);
        [self.contentView addSubview:lineView];
        
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setMerM:(MerchantModel *)MerM{
    _MerM = MerM;
    
    NSString *imgUrl = [MerM.frontImg stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.0"];
    [_merchantImage sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    _merchantNameLabel.text = MerM.name;
    _cateNameLabel.text = [NSString stringWithFormat:@"%@  %@",MerM.cateName,MerM.areaName];
    
    _evaluateLabel.text = [NSString stringWithFormat:@"%@评价",MerM.markNumbers];

    double scoreD = [MerM.avgScore doubleValue];
    int scoreI = ceil(scoreD);
    
    for (int i = 0; i < 5; i++) {
        UIImageView *imageview = (UIImageView *)[self.contentView viewWithTag:30+i];
        [imageview setImage:[UIImage imageNamed:@"icon_feedCell_star_empty"]];
    }
    
    for (int i = 0; i < scoreI; i++) {
        UIImageView *imageview = (UIImageView *)[self.contentView viewWithTag:30+i];
        [imageview setImage:[UIImage imageNamed:@"icon_feedCell_star_full"]];
    }
    
}




@end
