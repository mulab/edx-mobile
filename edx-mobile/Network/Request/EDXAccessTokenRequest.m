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
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithCapacity:5];
        [dictionary setValue:[EDXUtilities CharToNSString:data.client_id] forKey:@"client_id"];
        [dictionary setValue:[EDXUtilities CharToNSString:data.client_secret] forKey:@"client_secret"];
        [dictionary setValue:[EDXUtilities CharToNSString:data.grant_type] forKey:@"grant_type"];
        [dictionary setValue:[EDXUtilities CharToNSString:data.username] forKey:@"username"];
        [dictionary setValue:[EDXUtilities CharToNSString:data.password] forKey:@"password"];
        NSError *error = nil;
        NSData *body = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
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