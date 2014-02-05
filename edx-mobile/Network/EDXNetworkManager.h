//
// Created by Guang Chen on 1/8/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXNetworkDelegate.h"
#import "EDXNetworkRequestFactory.h"
#import "EDXSignUpRequest.h"

@interface EDXNetworkManager : NSObject{
    EDXNetworkRequestFactory *factory;
}
- (void)SignUpWith:(EDXSignUpData)info owner:(id<EDXNetworkDelegate>)owner;
@property (nonatomic, strong)EDXNetworkRequestFactory *factory;

- (void)LoginWith:(EDXLoginData)data owner:(id <EDXNetworkDelegate>)owner;
@end