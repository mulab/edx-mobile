//
//  EDXURIHelper.h
//  edx-mobile
//
//  Created by cissy on 13-12-7.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXNetworkDelegate.h"

@interface EDXURIHelper : NSObject
{}
+(NSString*) GetEnrollUrl;
+(NSString*) GetLoginUrl;
+(NSString*) GetCourseNavUrlWithCourseId:(NSString*)courseId;
+(NSString*) GetVideoListWithCourseId:(NSString*)courseId;

+ (NSString *)GetUrlForBusiness:(kBusinessTag)tag;

+ (NSString *)GetUrlForBusiness:(kBusinessTag)tag Course:(NSString *)course;
@end
