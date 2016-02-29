//
//  HJHTTPManager.m
//  WYNewsProject
//
//  Created by admin on 16/2/26.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJHTTPManager.h"

@implementation HJHTTPManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static HJHTTPManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] initWithBaseURL:HJBaseURL sessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
        instance.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    });
    return instance;
}

@end
