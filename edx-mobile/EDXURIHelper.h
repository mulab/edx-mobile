//
//  EDXURIHelper.h
//  edx-mobile
//
//  Created by cissy on 13-12-7.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDXURIHelper : NSObject
{}
+(NSString*) GetEnrollUrl;
+(NSString*) GetLoginUrl;
+(NSString*) GetCourseNavUrlWithCourseId:(NSString*)courseId;
+(NSString*) GetVideoListWithCourseId:(NSString*)courseId;
@end
