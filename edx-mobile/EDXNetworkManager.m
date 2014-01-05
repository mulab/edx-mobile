//
//  EDXNetworkManager.m
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXNetworkManager.h"

@implementation EDXNetworkManager
SYNTHESIZE_SINGLETON_FOR_CLASS(EDXNetworkManager);
- (id) init
{
    self = [super init];
    if (self){
        queue=[[NSMutableDictionary alloc]init];
    }
    return self;
}

- (void)getBusinessReq:(kBusinessTag)tag owner:(id<EDXNetworkDelegate>)owner{
    NSLog(@"%s",__func__);
}

- (void)postBusinessReq:(NSString *)json tag:(kBusinessTag)tag owner:(id<EDXNetworkDelegate>)owner{
    NSLog(@"%s",__func__);
}

- (void)cancel:(kBusinessTag)tag{
    NSLog(@"%s",__func__);
}

- (void) dealloc{
    [queue release];
    [super dealloc];
}

#pragma mark ASIHTTPRequest delegate

- (void)requestFinished:(ASIHTTPRequest *)request{
}

- (void)requestStarted:(ASIHTTPRequest *)request{
    NSLog(@"%s",__func__);
    NSLog(@"%@",[request description]);
}

- (void)requestFailed:(ASIHTTPRequest *)request{
}
@end
