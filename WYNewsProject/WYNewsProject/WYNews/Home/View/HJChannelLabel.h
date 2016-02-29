//
//  HJChannelLabel.h
//  WYNewsProject
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJChannelLabel : UILabel

@property (nonatomic, copy) void(^clickchannel)();

+ (instancetype)channelLabelWithTitle:(NSString *)title;

@end
