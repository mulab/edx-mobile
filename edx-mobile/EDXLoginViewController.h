//
//  EDXLoginViewController.h
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDXLoginViewController : UIViewController
{
    __weak IBOutlet UITextField *userName;
    __weak IBOutlet UITextField *passWord;
}
- (IBAction)LoginAction:(id)sender;
@end
