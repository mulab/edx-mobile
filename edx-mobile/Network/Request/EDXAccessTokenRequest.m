//
// Created by Guang Chen on 1/17/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXAccessTokenRequest.h"


@implementation EDXAccessTokenRequest {

}
- (id)initWithLoginData:(EDXLoginData)data {
    self = [super init];
    if(self){
        NSString *string = [NSString stringWithFormat:@"client_id=%s&client_secret=%s&grant_type=%s&username=%s&password=%s"
                ,data.client_id,data.client_secret,data.grant_type,data.username,data.password];
        NSData *body = [string dataUsingEncoding:NSUTF8StringEncoding];
        [self setHTTPBody:body];
    }
    return self;
}

- (void)setContentType {
    [super setContentType];
    [self setValue:form_header forHTTPHeaderField:@"content-type"];
}

- (void)setRequestURL {
    [super setRequestURL];
    NSURL *url = [helper BuildUrlFor:kBusinessTagUserLogin];
    [self setURL:url];
}


@end