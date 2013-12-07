//
//  EDXMainViewController.h
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDXNetworkDelegate.h"
#import "EDXGetCourseContent.h"
@interface EDXMainViewController : UIViewController<EDXNetworkDelegate,EDXGetCourseContent>
{
    NSInteger buttonTag;
    NSInteger videoTag;
}
- (IBAction)showVideoAction:(id)sender;
@property (retain, nonatomic) IBOutlet UILabel *courseName;
@property (retain, nonatomic) IBOutlet UILabel *videoName;
@property (retain, nonatomic) IBOutlet UIButton *showCouseButton;
@property (retain, nonatomic) IBOutlet UIButton *showVideoButton;
@property (retain)NSMutableArray *courseURI;
@property (retain)NSMutableArray *videoURI;
- (IBAction)enterCourseAction:(id)sender;
@end
