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
 *  request headline data of advertisement
 *
 *  @param url     request path
 *  @param success success call back
 *  @param error   fail call back 
 */
- (void)requestHeadLineDataWithURL:(NSString *)url success:(void(^)(id responseObject))success error:(void(^)(NSError *errorInfo))error;

@end
