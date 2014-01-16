//
// Created by Guang Chen on 1/16/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXSignUpRequest.h"
#import <Objection/Objection.h>

@implementation EDXSignUpRequest {

}
objection_requires(@"helper")
@synthesize helper;
- (id)initWithSignUpData:(EDXSignUpData)data {
    self = [super init];
    if(self){
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:4];
        [dictionary setValue:data.email forKey:@"email"];
        [dictionary setValue:data.username forKey:@"username"];
        [dictionary setValue:data.full_name forKey:@"full_name"];
        [dictionary setValue:data.password forKey:@"password"];
        NSError *error = nil;
        NSData *body = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        [self setHTTPBody:body];
    }
    return self;
}

- (void)setRequestURL {
    [super setRequestURL];
    [self setURL:[helper BuildUrlFor:kBusinessTagSignUp]];
}


@end