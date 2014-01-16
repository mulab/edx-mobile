//
// Created by Guang Chen on 1/8/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXNetworkManager.h"
#import "AFHTTPRequestOperation.h"

@implementation EDXNetworkManager {

}
objection_requires(@"EDXNetworkRequestFactory")
@synthesize factory;
- (void)SignUpWith:(EDXSignUpData)info owner:(id <EDXNetworkDelegate>)owner {
    [owner before:kBusinessTagSignUp];
    NSMutableURLRequest *request = [factory SignUpRequestWithData:info];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        [owner success:responseObject business:kBusinessTagSignUp];
    } failure:^(AFHTTPRequestOperation *operation,NSError *err){
        [owner error:err];
    }];
}


@end