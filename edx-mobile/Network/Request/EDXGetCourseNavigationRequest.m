//
// Created by Guang Chen on 1/17/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXGetCourseNavigationRequest.h"

@interface EDXGetCourseNavigationRequest(){
    NSString *_course;
}
@end
@implementation EDXGetCourseNavigationRequest {

}
- (id)initWithCourseId:(NSString *)course Token:(NSString *)token {
    self = [super init];
    if(self){
        [self setAccessToken:token];
        _course = course;
    }
    return self;
}

- (void)setRequestURL {
    [super setRequestURL];
    NSURL *url = [helper BuildUrlFor:kBusinessTagGetCourseNavigation];
    [self setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",[url absoluteString],_course]]];
}

- (void)setMethod {
    [super setMethod];
    [self setHTTPMethod:@"GET"];
}


@end