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
#import "EDXViewController.h"
@interface EDXMainViewController : EDXViewController<EDXNetworkDelegate,EDXGetCourseContent>
{
    NSInteger buttonTag;
    NSInteger videoTag;
}
- (IBAction)showVideoAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *courseName;
@property (strong, nonatomic) IBOutlet UILabel *videoName;
@property (strong, nonatomic) IBOutlet UIButton *showCouseButton;
@property (strong, nonatomic) IBOutlet UIButton *showVideoButton;
@property (strong)NSMutableArray *courseURI;
@property (strong)NSMutableArray *videoURI;
- (IBAction)enterCourseAction:(id)sender;
@end
