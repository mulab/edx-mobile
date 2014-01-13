//
// Created by Guang Chen on 1/11/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXNetworkRequestFactory.h"
#import <Objection/Objection.h>
@implementation EDXNetworkRequestFactory {

}
objection_register_singleton(EDXNetworkRequestFactory )
objection_requires(@"EDXURLHelper")
@synthesize helper;

- (NSMutableURLRequest *)SignUpRequest {
    NSMutableURLRequest *signUpRequest = [NSMutableURLRequest requestWithURL:[helper BuildUrlFor:kBusinessTagSignUp]];
    return signUpRequest;
}

- (NSURLRequest *)RequestFor:(kBusinessTag)tag {
    NSMutableURLRequest *request;
    switch(tag){
        case kBusinessTagSignUp:
            request=[self SignUpRequest];
            break;
        case kBusinessTagUserLogin:break;
        case kBusinessTagGetEnrollments:break;
        case kBusinessTagGetCourseVideoList:break;
    }
    [request addValue:api_key forHTTPHeaderField:@"X-edx-api-key"];
    return request;
};
@end