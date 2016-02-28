//
//  HJNewsModel.m
//  WYNewsProject
//
//  Created by admin on 16/2/28.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "HJNewsModel.h"
#import <YYModel.h>
#import "HJApiManager.h"

@implementation HJNewsModel

+ (void)newsDatasWithURL:(NSString *)url success:(void (^)(NSArray *))success {
    NSAssert(success != nil, @"回调不能为空");
    [[HJApiManager sharedApi] requestNewsDataWithURL:url success:^(NSDictionary * responseObject) {
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSArray *data = responseObject[key];
        NSArray *tmp = [NSArray yy_modelArrayWithClass:self json:data];
        success(tmp);
    } error:^(NSError *errorInfo) {
        success(nil);
    }];
}

@end
