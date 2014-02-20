//
//  EDXMyCourseCell.h
//  edx-mobile
//
//  Created by Guang Chen on 2/20/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EDXCourseModel;

@interface EDXMyCourseCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *courseImageView;
@property (strong, nonatomic) IBOutlet UILabel *courseName;
@property (strong, nonatomic) IBOutlet UILabel *courseDate;
@property (strong, nonatomic) IBOutlet UILabel *courseLastUpdateDate;

- (void)setupCell:(EDXCourseModel *)model;

- (IBAction)showLastUpdate:(id)sender;
- (IBAction)showCourseDetail:(id)sender;

@end
