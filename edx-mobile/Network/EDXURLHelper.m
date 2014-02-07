//
// Created by Guang Chen on 1/11/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXURLHelper.h"

static NSString *Sign_UP = @"/edx-api/signup/v1/register";
static NSString *Login = @"/edx-api/auth/v1/oauth2/access_token";
static NSString *Enroll_Course = @"/edx-api/enrollments/v1/";
static NSString *Get_Enrolls = @"/edx-api/enrollments/v1/";
static NSString *Get_Courses = @"/edx-api/courseware/v1";
@implementation EDXURLHelper {

}
objection_register_singleton(EDXURLHelper );
@synthesize host;

- (id)init {
    self = [super init];
    if (self) {
        self.host = @"http://lab.mu:3000%@";
    }

    return self;
}

- (NSURL *)BuildUrlFor:(kBusinessTag)tag {
    switch (tag){
        case kBusinessTagSignUp:
            return [NSURL URLWithString:[NSString stringWithFormat:host, Sign_UP]];
        case kBusinessTagUserLogin:
            return [NSURL URLWithString:[NSString stringWithFormat:host, Login]];
        case kBusinessTagEnrollCourse:
            return [NSURL URLWithString:[NSString stringWithFormat:host, Enroll_Course]];
        case kBusinessTagGetCourseVideoList:break;
        case kBusinessTagGetEnrolls:
            return [NSURL URLWithString:[NSString stringWithFormat:host, Get_Enrolls]];
        case kBusinessTagGetCourseNavigation:
            return [NSURL URLWithString:[NSString stringWithFormat:host, Get_Enrolls]];
        case kBusinessTagGetCourses:
            return [NSURL URLWithString:[NSString stringWithFormat:host, Get_Courses]];
    }
    return nil;
}


@end