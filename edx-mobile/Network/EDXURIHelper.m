//
//  EDXURIHelper.m
//  edx-mobile
//
//  Created by cissy on 13-12-7.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXURIHelper.h"
#import "EDXNetworkDelegate.h"

static NSString *HOST = @"http://lab.mu:3000%@";
static NSString *GET_ENROLL = @"/edx-api/enrollments/v1";
static NSString *GET_VIDEO = @"/edx-api/courseware/v1/%@?type=video";
static NSString *GET_ACCESS =@"/edx-api/auth/v1/oauth2/access_token";
@implementation EDXURIHelper
+(NSString*) GetEnrollUrl{
    return [NSString stringWithFormat:HOST,GET_ENROLL];
};
+(NSString*) GetLoginUrl{
    return [NSString stringWithFormat:HOST,GET_ACCESS];
}
+(NSString*) GetCourseNavUrlWithCourseId:(NSString*)courseId{
    return @"";
}
+(NSString*) GetVideoListWithCourseId:(NSString*)courseId{
    return [NSString stringWithFormat:HOST,[NSString stringWithFormat:GET_VIDEO,courseId]];
}

+ (NSString *)GetUrlForBusiness:(kBusinessTag)tag {
    switch (tag){
        case kBusinessTagGetEnrollments:
            return [self GetEnrollUrl];
        case kBusinessTagUserLogin:
            return [self GetLoginUrl];
    }
    return nil;
}

+ (NSString *)GetUrlForBusiness:(kBusinessTag)tag Course:(NSString *)course {
    switch (tag){
        case kBusinessTagGetCourseVideoList:
            return [self GetVideoListWithCourseId:course];
    }
    return nil;
}
@end
