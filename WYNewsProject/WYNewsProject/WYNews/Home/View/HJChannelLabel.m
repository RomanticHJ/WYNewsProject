//
//  HJChannelLabel.m
//  WYNewsProject
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJChannelLabel.h"
#define HJBigFont 18.f
#define HJNormalFont 14.f

@implementation HJChannelLabel

+ (instancetype)channelLabelWithTitle:(NSString *)title {
    HJChannelLabel *label = [[self alloc] init];
    // set title
    label.text = title;
    // set the biggest font
    label.font = [UIFont systemFontOfSize:HJBigFont];
    // calculate the size
    [label sizeToFit];
    // set the default font
    label.font = [UIFont systemFontOfSize:HJNormalFont];
    // open label userInteractionEnabled
    label.userInteractionEnabled = YES;
    label.textAlignment = NSTextAlignmentCenter;
    return label;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.clickchannel) {
        self.clickchannel();
    }
}

- (void)setScale:(CGFloat)scale {
    CGFloat percent = (CGFloat)(HJBigFont - HJNormalFont) / HJNormalFont;
    percent = percent * scale + 1;
    self.transform = CGAffineTransformMakeScale(percent, percent);
    self.textColor = [UIColor colorWithRed:percent * scale green:0 blue:0 alpha:YES];
}

@end
