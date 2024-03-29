//
//  EDXLoginViewController.h
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDXNetworkDelegate.h"
#import "EDXViewController.h"
#import "EDXDataManager.h"
#import "EDXNetworkManager.h"
#import "EDXNetworkRequestFactory.h"
@class EDXDataManager,EDXNetworkRequestFactory;
@interface EDXLoginViewController : EDXViewController<EDXNetworkDelegate>
{
    EDXDataManager *dataManager;
}
@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (nonatomic, strong) EDXDataManager *dataManager;
@property (nonatomic, strong) EDXNetworkRequestFactory *factory;

- (IBAction)LoginAction:(id)sender;
- (IBAction)GetEnrollmentAction:(id)sender;
- (void) LoginWith:(NSString *)username password:(NSString *)password;
- (void) LoginWith:(NSString *)access;
- (void) NavigateToDashBoard;
@end
