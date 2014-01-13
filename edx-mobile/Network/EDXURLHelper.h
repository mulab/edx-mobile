//
// Created by Guang Chen on 1/11/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXConstants.h"

@interface EDXURLHelper : NSObject{
    NSString *host;
}
@property (nonatomic, strong)NSString *host;
-(NSURL *)BuildUrlFor:(kBusinessTag)tag;
@end