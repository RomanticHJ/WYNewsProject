//
//  HJHeadLineModel.m
//  WYNewsProject
//
//  Created by admin on 16/2/27.
//  Copyright © 2016年 admin. All rights reserved.
//


#import "HJHeadLineModel.h"
#import "HJApiManager.h"

@implementation HJHeadLineModel

+ (instancetype)handLineWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

// 防止调用 setValuesForKeysWithDictionary（KVC） 方法，造成程序崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

+ (void)headLineDatasWithURL:(NSString *)url success:(void (^)(NSArray *))success {
    [[HJApiManager sharedApi] requestHeadLineDataWithURL:url success:^(NSDictionary *responseObject) {
        // 取出字典中第一个key
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSArray *dataArr = responseObject[key];
        // 可变数组存放模型数据
        NSMutableArray *dataM = [NSMutableArray array];
        [dataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [dataM addObject:[HJHeadLineModel handLineWithDict:obj]];
        }];
        success(dataM.copy);
    } error:^(NSError *errorInfo) {
        success(nil);
    }];
}

@end
