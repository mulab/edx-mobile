//
// Created by Guang Chen on 1/17/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXEnrollCourseRequest.h"


@implementation EDXEnrollCourseRequest {

}
- (id)initWithCourseId:(NSString *)course Token:(NSString *)token {
    self = [super init];
    if(self){
        NSString *url = [[self URL] absoluteString];
        [self setURL:[NSURL URLWithString:[NSString stringWithFormat:url,course]]];
        [self setAccessToken:token];
    }
    return self;
}

- (void)setRequestURL {
    [super setRequestURL];
    NSURL *url = [helper BuildUrlFor:kBusinessTagGetEnrollments];
    [self setURL:url];
}


@end