//
//  EDXDataManager.m
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXDataManager.h"
NSString *token_key = @"token";
@implementation EDXDataManager{}
objection_register_singleton(EDXDataManager)

-(NSString *) GetUserName{
    NSLog(@"call %s",__func__);
    return @"user@user.com";
}

- (void)saveAccessToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:token_key];
}

-(NSString *)getAccessToken{
    return [[NSUserDefaults standardUserDefaults] stringForKey:token_key];
}


@end
