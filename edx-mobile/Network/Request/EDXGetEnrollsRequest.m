//
// Created by Guang Chen on 1/17/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXGetEnrollsRequest.h"


@implementation EDXGetEnrollsRequest {

}
- (id)initWithToken:(NSString *)token {
    self = [super init];
    if(self){
        [self setAccessToken:token];
    }
    return self;
}

- (void)setMethod {
    [super setMethod];
    [self setHTTPMethod:@"GET"];
}

- (void)setRequestURL {
    [super setRequestURL];
    NSURL *url = [helper BuildUrlFor:kBusinessTagGetEnrolls];
    [self setURL:url];
}


@end