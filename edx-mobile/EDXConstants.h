//
//  EDXConstants.h
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const api_key;
extern char * const client_id;
extern char * const client_secret;
extern char * const grant_type;
extern NSString * const host_string;
extern NSString * const out_register_url;
extern NSString * const json_header;
extern NSString * const form_header;
extern NSString * const loginUrl;
extern NSString * const loginPost;
enum kBusinessTag{
    kBusinessTagSignUp,
    kBusinessTagUserLogin,
    kBusinessTagEnrollCourse,
    kBusinessTagUnEnrollCourse,
    kBusinessTagGetCourses,
    kBusinessTagGetEnrolls,
    kBusinessTagGetCourseNavigation,
    kBusinessTagGetCourseVideoList
};
typedef enum kBusinessTag kBusinessTag;
@interface EDXConstants : NSObject

@end
