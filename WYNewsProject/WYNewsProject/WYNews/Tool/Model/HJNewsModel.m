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
#import "HJNewsImageModel.h"

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

+ (NSDictionary *)modelContainerPropertyGenericClass {
    // value should be Class or Class name.
    return @{@"imgextra" : [HJNewsImageModel class],
             };
}

- (void)setDocid:(NSString *)docid {
    _docid = docid.copy;
    self.fullURL = [NSString stringWithFormat:@"article/%@/full.html",_docid];
}

@end
