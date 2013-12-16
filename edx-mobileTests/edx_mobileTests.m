//
//  edx_mobileTests.m
//  edx-mobileTests
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "edx_mobileTests.h"
#import "EDXDataManager.h"
#import "EDXViewController.h"
@implementation edx_mobileTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testEDXDataManager{
    EDXViewController * vc = [[[EDXViewController alloc] init] autorelease];
    STAssertNotNil([[EDXDataManager sharedEDXDataManager] GetUserName], @"should get username");
    STAssertNotNil([[EDXDataManager sharedEDXDataManager] GetLoginAccess], @"should get access");
    STAssertNotNil([[EDXDataManager sharedEDXDataManager] GetMyCourseList:vc], @"should get my course list");
    STAssertNotNil([[EDXDataManager sharedEDXDataManager] GetAllCourseList:vc], @"should get all course list");
}

@end
