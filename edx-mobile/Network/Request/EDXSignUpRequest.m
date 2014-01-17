//
// Created by Guang Chen on 1/16/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXSignUpRequest.h"
#import "EDXUtilities.h"
@implementation EDXSignUpRequest {

}
- (id)initWithSignUpData:(EDXSignUpData)data {
    self = [super init];
    if(self){
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:4];
        [dictionary setValue:[EDXUtilities CharToNSString:data.email] forKey:@"email"];
        [dictionary setValue:[EDXUtilities CharToNSString:data.username] forKey:@"username"];
        [dictionary setValue:[EDXUtilities CharToNSString:data.full_name] forKey:@"full_name"];
        [dictionary setValue:[EDXUtilities CharToNSString:data.password] forKey:@"password"];
        NSError *error = nil;
        NSData *body = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
        [self setHTTPBody:body];
    }
    return self;
}

- (void)setRequestURL {
    //[super setRequestURL];
    NSURL *url = [helper BuildUrlFor:kBusinessTagSignUp];
    [self setURL:url];
}


@end