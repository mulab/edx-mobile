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
@interface EDXLoginViewController : EDXViewController<EDXNetworkDelegate>
{
    EDXDataManager *dataManager;
}
@property (retain, nonatomic) IBOutlet UITextField *userName;
@property (retain, nonatomic) IBOutlet UITextField *password;
@property (nonatomic, strong) EDXDataManager *dataManager;
@property (nonatomic, strong) EDXNetworkManager *networkManager;
- (IBAction)LoginAction:(id)sender;
- (IBAction)GetEnrollmentAction:(id)sender;
- (void) LoginWith:(NSString *)username password:(NSString *)password;
- (void) LoginWith:(NSString *)access;
- (void) NavigateToDashBoard;
@end
