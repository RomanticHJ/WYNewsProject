//
//  HJApiManager.m
//  WYNewsProject
//
//  Created by admin on 16/2/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJApiManager.h"
#import "HJHTTPManager.h"

@implementation HJApiManager
+ (instancetype)sharedApi {
    static dispatch_once_t onceToken;
    static id instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)requestHeadLineDataWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errorInfo))error {
    NSAssert(success != nil || error != nil, @"回调不能为空");
    [[HJHTTPManager sharedManager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorInfo) {
        error(errorInfo);
    }];
}

- (void)requestNewsDataWithURL:(NSString *)url success:(void (^)(id))success error:(void (^)(NSError *))error {
    NSAssert(success != nil || error != nil, @"回调不能为空");
    [[HJHTTPManager sharedManager] GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull errorInfo) {
        error(errorInfo);
    }];
}

@end
