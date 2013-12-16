//
//  EDXDataManager.h
//  edx-mobile
//
//  Created by cissy on 13-12-16.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SynthesizeSingleton.h"
#import "EDXNetworkDelegate.h"
#import "EDXUIViewDelegate.h"
@interface EDXDataManager : NSObject<EDXNetworkDelegate>
+(EDXDataManager *)sharedEDXDataManager;
-(NSString *) GetLoginAccess:(id<EDXUIViewDelegate>) owner;
-(NSString *) GetUserName;
-(NSArray *) GetMyCourseList:(id<EDXUIViewDelegate>) owner;
-(NSArray *) GetAllCourseList:(id<EDXUIViewDelegate>) owner;
@end
