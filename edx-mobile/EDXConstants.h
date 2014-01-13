//
//  EDXConstants.h
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const api_key;
extern NSString * const loginUrl;
extern NSString * const loginPost;
enum kBusinessTag{
    kBusinessTagSignUp,
    kBusinessTagUserLogin,
    kBusinessTagGetEnrollments,
    kBusinessTagGetCourseVideoList
};
typedef enum kBusinessTag kBusinessTag;
@interface EDXConstants : NSObject

@end
