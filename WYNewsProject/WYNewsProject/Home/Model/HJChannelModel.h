//
//  HJChannelModel.h
//  WYNewsProject
//
//  Created by admin on 16/2/29.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJChannelModel : NSObject

@property (nonatomic, copy) NSString *tname;
@property (nonatomic, copy) NSString *tid;

/**
 *  back channel data
 *
 *  @return channel data
 */
+ (NSArray *)channelDta;

@end
