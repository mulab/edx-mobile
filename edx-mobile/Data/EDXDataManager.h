//
//  EDXDataManager.h
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDXNetworkDelegate.h"
#import "EDXUIViewDelegate.h"
//#import <Objection/Objection.h>
@interface EDXDataManager : NSObject
-(NSString *) GetUserName;
-(void)saveAccessToken:(NSString *)token;
- (NSString *)getAccessToken;
@end
