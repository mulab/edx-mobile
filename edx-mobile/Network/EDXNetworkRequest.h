//
//  EDXNetworkRequest.h
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "EDXNetworkDelegate.h"
@interface EDXNetworkRequest : NSObject
@property (nonatomic,retain)id<EDXNetworkDelegate> owner;//who delegate the request
@property (nonatomic,retain)NSString* url;//request url
@property (assign)NSStringEncoding enc;//response encodeing
@property (assign)kRequestStatus requestStatus;
@property (assign)kBusinessTag businessTag;
@property (nonatomic,readonly,getter = result)id result;
-(void)cancel;
-(void)postJson: (NSString*)json delegate:(id)delegate;//post json method
-(void)getWithDelegate:(id)delegate;//get method
@end