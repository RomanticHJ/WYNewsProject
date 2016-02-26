//
//  HJHTTPManager.h
//  WYNewsProject
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface HJHTTPManager : AFHTTPSessionManager

+ (instancetype)sharedManager;

@end
