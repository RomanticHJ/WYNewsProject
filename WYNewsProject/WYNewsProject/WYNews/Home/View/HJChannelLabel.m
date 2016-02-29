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
    return label;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if (self.clickchannel) {
        self.clickchannel();
    }
}

@end
