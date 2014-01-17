//
// Created by Guang Chen on 1/16/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXNetworkRequest.h"

@implementation EDXNetworkRequest {

}
objection_requires_sel(@selector(helper))
@synthesize helper;
- (id)init {
    self = [super init];
    if (self) {
        helper = [[JSObjection defaultInjector] getObject:[EDXURLHelper class]];
        [self addValue:api_key forHTTPHeaderField:@"X-edx-api-key"];
    }
    return self;
}

- (void)setContentType {
    [self setValue:json_header forHTTPHeaderField:@"content-type"];
}

- (void)setMethod {
    [self setHTTPMethod:@"POST"];
}

- (void)setRequestURL {

}


@end