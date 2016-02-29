//
//  HJHTTPManager.h
//  WYNewsProject
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#define HJBaseURL [NSURL URLWithString:@"http://c.m.163.com/nc/"]
@interface HJHTTPManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
