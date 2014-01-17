//
// Created by Guang Chen on 1/16/14.
// Copyright (c) 2014 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXURLHelper.h"
#import "EDXUtilities.h"

@interface EDXNetworkRequest : NSMutableURLRequest{
    EDXURLHelper *helper;
}
@property (strong, nonatomic)EDXURLHelper *helper;
-(void)setContentType;
-(void)setMethod;
-(void)setRequestURL;
-(void)setAccessToken:(NSString *)token;
@end