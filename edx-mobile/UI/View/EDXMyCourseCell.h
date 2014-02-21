//
//  EDXMyCourseCell.h
//  edx-mobile
//
//  Created by Guang Chen on 2/20/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDXCourseModel.h"
typedef enum {
    MyCourseCell,
    FindCourseCell
} CellType;
@interface EDXMyCourseCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *courseImageView;
@property (strong, nonatomic) IBOutlet UILabel *courseName;
@property (strong, nonatomic) IBOutlet UILabel *courseDate;
@property (strong, nonatomic) IBOutlet UILabel *courseLastUpdateDate;
@property (strong, nonatomic) IBOutlet UIButton *upsideButton;
@property (strong, nonatomic) IBOutlet UILabel *upsideButtonTitle;
- (IBAction)upsideButtonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *downsideButton;
@property (strong, nonatomic) IBOutlet UILabel *downsideButtonTItle;
- (IBAction)downSideAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *content;

@property (assign, nonatomic)CellType type;
- (void)setupCell:(EDXCourseModel *)model type:(CellType)type;
@end
