//
//  QJLStage15RowView.m
//  Game
//
//  Created by 金亮齐 on 16/8/12.
//  Copyright © 2016年 醉看红尘这场梦. All rights reserved.
//


#import "QJLStage15RowView.h"
#import "UIColor+QJLColor.h"

#define kHasLandChance 4
#define kHasDuckChance 3

#define kRandomBoolWithChance(n) (arc4random_uniform(n) == (n - 1))
#define kDuckImage [UIImage imageNamed:[NSString stringWithFormat:@"18_duck0%d-iphone4", arc4random_uniform(2) + 1]]

@interface QJLStage15RowView ()
{
    int _randomWood;
    
    BOOL _rightHasLand;
    BOOL _leftHasLand;
    
    BOOL _middleHasDuck;
    BOOL _leftHasDuck;
    BOOL _rightHasDuck;

    BOOL _middleHasStone;
    BOOL _leftHasStone;
    BOOL _rightHasStone;
    
    BOOL _leftHasCrocodile;
    BOOL _rightHasCrocodile;
}

@property (weak, nonatomic) IBOutlet UIImageView *waveIV;

@property (weak, nonatomic) IBOutlet UIImageView *leftLandIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightLandIV;
@property (weak, nonatomic) IBOutlet UIImageView *leftStoneIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightStoneIV;
@property (weak, nonatomic) IBOutlet UIImageView *middleStoneIV;
@property (weak, nonatomic) IBOutlet UIImageView *leftDuckIV;
@property (weak, nonatomic) IBOutlet UIImageView *middleDuckIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightDuckIV;
@property (weak, nonatomic) IBOutlet UIImageView *leftCrocodileIV;
@property (weak, nonatomic) IBOutlet UIImageView *rightCrocodileIV;
@property (weak, nonatomic) IBOutlet UIImageView *flagIV;
@property (weak, nonatomic) IBOutlet UIImageView *arrowIV;

@end

@implementation QJLStage15RowView

- (void)awakeFromNib {
    self.leftWoodIV.animationImages = @[[UIImage imageNamed:@"18_Rwood_down-iphone4"]];
    self.leftWoodIV.animationDuration = 0.2;
    self.leftWoodIV.animationRepeatCount = 1;
    self.middleWoodIV.animationImages = @[[UIImage imageNamed:@"18_Ywood_down-iphone4"]];
    self.middleWoodIV.animationDuration = 0.2;
    self.middleWoodIV.animationRepeatCount = 1;
    self.rightWoodIV.animationImages = @[[UIImage imageNamed:@"18_Bwood_down-iphone4"]];
    self.rightWoodIV.animationDuration = 0.2;
    self.rightWoodIV.animationRepeatCount = 1;
}

- (void)setMiddleDuckAndStoneStatus {
    _middleHasDuck = arc4random_uniform(2);
    if (_middleHasDuck) {
        // 中间有鸭子
        _middleDuckIV.hidden = NO;
        self.middleDuckIV.image = kDuckImage;
    } else {
        // 中间没有鸭子
        _middleHasStone = kRandomBoolWithChance(kHasDuckChance);
        if (_middleHasStone) {
            _middleStoneIV.hidden = NO;
        }
    }
}

- (void)setRightDuckAndStoneStatus {
    _rightHasDuck = arc4random_uniform(2);
    if (_rightHasDuck) {
        _rightDuckIV.hidden = NO;
        self.rightDuckIV.image = kDuckImage;
    } else {
        _rightHasStone = kRandomBoolWithChance(kHasDuckChance);
        if (_rightHasStone) {
            _rightStoneIV.hidden = NO;
        }
    }
}

- (void)setLeftDuckAndStoneStatus {
    _leftHasDuck = arc4random_uniform(2);
    if (_leftHasDuck) {
        _leftDuckIV.hidden = NO;
        self.leftDuckIV.image = kDuckImage;
    } else {
        _leftHasStone = kRandomBoolWithChance(kHasDuckChance);
        if (_leftHasStone) {
            _leftStoneIV.hidden = NO;
        }
    }
}

- (void)showRowWithIsShowWave:(BOOL)showWave showFinish:(BOOL)finsih isFrist:(BOOL)isFrist {
    if (!isFrist) {
        _randomWood = arc4random_uniform(3);

        if (_randomWood == 0) {
            self.leftWoodIV.hidden = NO;
        } else if (_randomWood == 1) {
            self.middleWoodIV.hidden = NO;
        } else {
            self.rightWoodIV.hidden = NO;
        }
        
        if (!self.leftWoodIV.hidden) {
            _rightHasLand = kRandomBoolWithChance(kHasLandChance);
            if (_rightHasLand) {
                _rightLandIV.hidden = NO;
                
                // 显示左边木块 右边有陆地
                [self setMiddleDuckAndStoneStatus];
                
            } else {
                // 显示左边木块 没有陆地
                _rightHasCrocodile = kRandomBoolWithChance(kHasDuckChance);
                if (_rightHasCrocodile) {
                    self.rightCrocodileIV.hidden = NO;
                    
                    _middleHasStone = kRandomBoolWithChance(kHasDuckChance);
                    if (_middleHasStone) {
                        _middleStoneIV.hidden = NO;
                    }
                    
                } else {
                    // 没有鳄鱼
                    [self setMiddleDuckAndStoneStatus];
                    [self setRightDuckAndStoneStatus];
                }
            }
            
        } else if (!self.middleWoodIV.hidden) {
            _rightHasLand = kRandomBoolWithChance(kHasLandChance);
            if (_rightHasLand) {
                _rightLandIV.hidden = NO;
                // 中间木块 右边有陆地
                [self setLeftDuckAndStoneStatus];
            } else {
                _leftHasLand = kRandomBoolWithChance(kHasLandChance);
                if (_leftHasLand) {
                    // 中间木块 左边有陆地
                    _leftLandIV.hidden = NO;
                    [self setRightDuckAndStoneStatus];
                } else {
                    // 中间有木块 左右都没有陆地
                    [self setLeftDuckAndStoneStatus];
                    [self setRightDuckAndStoneStatus];
                }
            }
        } else {
            _leftHasLand = kRandomBoolWithChance(kHasLandChance);
            if (_leftHasLand) {
                _leftLandIV.hidden = NO;
                // 右边有木块 左边有陆地
                [self setMiddleDuckAndStoneStatus];
            } else {
                // 右边有木块 左边没有陆地
                _leftHasCrocodile = kRandomBoolWithChance(kHasDuckChance);
                if (_leftHasCrocodile) {
                    self.leftCrocodileIV.hidden = NO;
                    
                    _middleHasStone = kRandomBoolWithChance(kHasDuckChance);
                    if (_middleHasStone) {
                        _middleStoneIV.hidden = NO;
                    }
                } else {                    
                    // 没有鳄鱼
                    [self setMiddleDuckAndStoneStatus];
                    [self setLeftDuckAndStoneStatus];
                }
            }
        }
        
        if (finsih) {
            self.flagIV.hidden = NO;
            if (_randomWood == 0) {
                self.flagIV.transform = CGAffineTransformMakeTranslation(-(249 - 59), 0);
            } else if (_randomWood == 1) {
                self.flagIV.transform = CGAffineTransformMakeTranslation(-(249 - 146), 0);
            } 
        }
        self.arrowIV.hidden = YES;
    } else {
        self.middleWoodIV.hidden = NO;
        self.arrowIV.hidden = NO;
    }
    
    self.waveIV.hidden = !showWave;
}

- (void)startWoodAnimation {
    if (!self.leftWoodIV.hidden) {
        [self.leftWoodIV startAnimating];
    } else if (!self.middleWoodIV.hidden) {
        [self.middleWoodIV startAnimating];
    } else {
        [self.rightWoodIV startAnimating];
    }
}

@end
