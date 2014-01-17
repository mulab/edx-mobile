//
// Created by Guang Chen on 1/17/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXGetCourseNavigationRequest.h"

@interface EDXGetCourseElementRequest : EDXGetCourseNavigationRequest
-(id) initWithCourseId:(NSString *)course ElementType:(NSString *)type Token:(NSString *)token;
@end