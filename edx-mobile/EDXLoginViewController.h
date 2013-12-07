//
//  EDXLoginViewController.h
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDXNetworkDelegate.h"
@interface EDXLoginViewController : UIViewController<EDXNetworkDelegate>
{
}
@property (retain, nonatomic) IBOutlet UITextField *userName;
@property (retain, nonatomic) IBOutlet UITextField *password;
- (IBAction)LoginAction:(id)sender;
- (IBAction)GetEnrollMentAction:(id)sender;
@end
