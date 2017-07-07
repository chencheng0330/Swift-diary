//
//  MerAroundGroupCell.m
//  美团
//
//  Created by 金亮齐 on 2017/7/4.
//  Copyright © 2017年 醉看红尘这场梦. All rights reserved.
//

#import "MerAroundGroupCell.h"

@interface MerAroundGroupCell(){
    UIImageView *_shopImgView;
    UILabel *_shopNameLabel;
    UILabel *_shopSubTitleLabel;
    UILabel *_nowPriceLabel;
    UILabel *_oldPriceLabel;
}

@end

@implementation MerAroundGroupCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initViews];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initViews{
    //图
    _shopImgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 80, 80)];
    _shopImgView.layer.masksToBounds = YES;
    _shopImgView.layer.cornerRadius = 5;
    [self addSubview:_shopImgView];
    //店名
    _shopNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 5, screen_width-100-10, 20)];
    [self addSubview:_shopNameLabel];
    //子标题
    _shopSubTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 25, screen_width-110, 50)];
    _shopSubTitleLabel.numberOfLines = 2;
    _shopSubTitleLabel.textColor = [UIColor lightGrayColor];
    _shopSubTitleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:_shopSubTitleLabel];
    //新价格
    _nowPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 70, 50, 20)];
    _nowPriceLabel.textColor = navigationBarColor;
    [self addSubview:_nowPriceLabel];
    //老价格
    _oldPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_nowPriceLabel.frame)+5, 70, 50, 20)];
    _oldPriceLabel.font = [UIFont systemFontOfSize:13];
    _oldPriceLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_oldPriceLabel];
}

-(void)setMerAroundM:(MerAroundGroupModel *)MerAroundM{
    _MerAroundM = MerAroundM;
    NSString *imgUrl = [MerAroundM.squareimgurl stringByReplacingOccurrencesOfString:@"w.h" withString:@"160.160"];
    [_shopImgView sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"bg_customReview_image_default"]];
    
    
    _shopNameLabel.text = MerAroundM.mname;
    _shopSubTitleLabel.text = [NSString stringWithFormat:@"[%@]%@",MerAroundM.range,MerAroundM.title];
    
    NSString *str = [NSString stringWithFormat:@"%@元",MerAroundM.price];
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(100, 20) withFont:17];
    _nowPriceLabel.text = str;
    _nowPriceLabel.frame = CGRectMake(100, 70, labelSize.width, labelSize.height);

    NSString *strOld = [NSString stringWithFormat:@"%@元",MerAroundM.value];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    //下划线
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:strOld attributes:attribtDic];
    _oldPriceLabel.attributedText = attribtStr;
    _oldPriceLabel.frame = CGRectMake(CGRectGetMaxX(_nowPriceLabel.frame)+5, 70, 100, 20);
}



@end
