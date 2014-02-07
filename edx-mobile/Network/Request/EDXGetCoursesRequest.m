//
// Created by Guang Chen on 2/7/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXGetCoursesRequest.h"


@implementation EDXGetCoursesRequest {

}
- (void)setMethod {
    [self setHTTPMethod:@"GET"];
}

- (void)setRequestURL {
    NSURL *url = [helper BuildUrlFor:kBusinessTagGetCourses];
    [self setURL:url];
}

@end