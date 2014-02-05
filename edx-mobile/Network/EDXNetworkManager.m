//
// Created by Guang Chen on 1/8/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXNetworkManager.h"
#import "AFHTTPRequestOperation.h"

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
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject){
        [owner success:responseObject business:kBusinessTagSignUp];
    } failure:^(AFHTTPRequestOperation *operation,NSError *err){
        [owner error:err];
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}


- (void)LoginWith:(EDXLoginData)data owner:(id <EDXNetworkDelegate>)owner {
    [owner before:kBusinessTagUserLogin];
    NSURLRequest *request = [factory AccessTokenRequestWithData:data];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation,id responseObject){
        [owner success:responseObject business:kBusinessTagSignUp];
    } failure:^(AFHTTPRequestOperation *operation,NSError *error){
        [owner error:error];
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}
@end