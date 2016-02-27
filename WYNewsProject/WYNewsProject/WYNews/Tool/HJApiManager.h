//
//  HJApiManager.h
//  WYNewsProject
//
//  Created by admin on 16/2/27.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJApiManager : NSObject

+ (instancetype)sharedApi;
/**
 *  请求头条的广告数据
 *
 *  @param url     请求的路径
 *  @param success 成功回调
 *  @param error   失败回调
 */
- (void)requestHeadLineDataWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errorInfo))error;

@end
