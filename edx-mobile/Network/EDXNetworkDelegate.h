//
// Created by Guang Chen on 1/8/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXConstants.h"

@protocol EDXNetworkDelegate <NSObject>
@optional
- (void)before:(kBusinessTag)tag;
- (void)success:(id)result business:(kBusinessTag)tag;
- (void)error:(NSError *)err;
@end