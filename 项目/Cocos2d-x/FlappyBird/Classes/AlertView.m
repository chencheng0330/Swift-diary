//
//  AlertView.m
//  FlappyBird
//
//  FlappyBird
//
//  Created by 金亮齐 on 2017/7/25.
//
//

#import "AlertView.h"

@interface AlertView () <UIAlertViewDelegate>

@property (nonatomic, copy) ButtonClick okButtonClick;
@property (nonatomic, copy) ButtonClick cancelButtonClick;

@end

@implementation AlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle oklClick:(ButtonClick)okClick cancelClick:(ButtonClick)cancelClick
{
    if (self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:okButtonTitle otherButtonTitles:cancelButtonTitle, nil]) {
        self.okButtonClick = okClick;
        self.cancelButtonClick = cancelClick;
    }
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        if (self.okButtonClick) {
            self.okButtonClick();
        }
    } else if (buttonIndex == 1) {
        if (self.cancelButtonClick) {
            self.cancelButtonClick();
        }
    }
}


@end
