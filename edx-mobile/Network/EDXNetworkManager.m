//
// Created by Guang Chen on 1/8/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXNetworkManager.h"
#import "AFHTTPRequestOperation.h"
@interface EDXNetworkManager()
- (void)startOperation:(AFHTTPRequestOperation *)operation ForOwner:(id <EDXNetworkDelegate>)owner;
@end
@implementation EDXNetworkManager {

}
objection_requires(@"factory")
@synthesize factory;
- (void)SignUpWith:(EDXSignUpData)info owner:(id <EDXNetworkDelegate>)owner {
    [owner before:kBusinessTagSignUp];
    NSURLRequest *request = [factory SignUpRequestWithData:info];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    op.responseSerializer.acceptableContentTypes= [NSSet setWithObjects:@"application/json", @"text/plain", nil];
    [self startOperation:op ForOwner:owner];
}

- (void)LoginWith:(EDXLoginData)data owner:(id <EDXNetworkDelegate>)owner {
    [owner before:kBusinessTagUserLogin];
    NSURLRequest *request = [factory AccessTokenRequestWithData:data];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [self startOperation:op ForOwner:owner];
}

- (void)startOperation:(AFHTTPRequestOperation *)operation ForOwner:(id <EDXNetworkDelegate>)owner {
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *op, id responseObject) {
        [owner success:responseObject business:kBusinessTagSignUp];
    }                                failure:^(AFHTTPRequestOperation *op, NSError *err) {
        [owner error:err];
    }];
    [[NSOperationQueue mainQueue] addOperation:operation];
}
@end