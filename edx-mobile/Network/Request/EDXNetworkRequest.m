//
// Created by Guang Chen on 1/16/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXNetworkRequest.h"
#import "EDXConstants.h"

@implementation EDXNetworkRequest {

}
- (id)init {
    self = [super init];
    if (self) {
        [self setRequestURL];
        [self addValue:api_key forHTTPHeaderField:@"X-edx-api-key"];
        [self setContentType];
        [self setMethod];
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