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

// avoid program transfer setValuesForKeysWithDictionary（KVC） method，result in breakdown
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
}

+ (void)headLineDatasWithURL:(NSString *)url success:(void (^)(NSArray *))success {
    [[HJApiManager sharedApi] requestHeadLineDataWithURL:url success:^(NSDictionary *responseObject) {
        // take out first key in dictionary
        NSString *key = responseObject.keyEnumerator.nextObject;
        NSArray *dataArr = responseObject[key];
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
