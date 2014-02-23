//
//  EDXMyCourseCell.m
//  edx-mobile
//
//  Created by Guang Chen on 2/20/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXMyCourseCell.h"
#import "EDXMyCourseViewController.h"
#import <Objection/Objection.h>
@implementation EDXMyCourseCell
objection_requires_sel(@selector(networkManager))
@synthesize networkManager;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        networkManager = [[JSObjection defaultInjector] getObject:[EDXNetworkManager class]];

        //courseId
        self.courseIdLabel = [[UILabel alloc] initWithFrame:CGRectMake(36, 90, 135, 28)];
        [self.courseIdLabel setTextColor:[UIColor purpleColor]];
        [self.contentView addSubview:self.courseIdLabel];

        //courseImage
        self.courseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(253, 0, 555, 219)];
        [self.contentView addSubview:self.courseImageView];
        
        //courseName
        self.courseName = [[UILabel alloc]initWithFrame:CGRectMake(37, 121, 174, 28)];
        [self.courseName setTextColor:[UIColor purpleColor]];
        [self.contentView addSubview:self.courseName];
        
        //courseDate
        self.courseDate = [[UILabel alloc]initWithFrame:CGRectMake(39, 170, 100, 28)];
        [self.courseDate setTextColor:[UIColor whiteColor]];
        [self.courseDate setBackgroundColor:[UIColor purpleColor]];
        [self.contentView addSubview:self.courseDate];
        
        //upsideButton
        self.upsideButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.upsideButton setFrame:CGRectMake(807, 0, 133, 109)];
        [self.upsideButton setBackgroundColor:[UIColor colorWithRed:243/255.0 green:152/255.0 blue:1/255.0 alpha:1.0]];
        [self.upsideButton addTarget:self action:@selector(upsideButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.upsideButton];
        
        //upsideLabel
        self.upsideButtonTitle = [[UILabel alloc]initWithFrame:CGRectMake(825, 72, 113, 39)];
        [self.upsideButtonTitle setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.upsideButtonTitle];
        
        //downsideButton
        self.downsideButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.downsideButton setFrame:CGRectMake(807, 110, 113, 109)];
        [self.downsideButton setBackgroundColor:[UIColor colorWithRed:155/255.0 green:50/255.0 blue:133/255.0 alpha:1.0]];
        [self.downsideButton addTarget:self action:@selector(downSideAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.downsideButton];
        
        //downsideTitle
        self.downsideButtonTItle = [[UILabel alloc]initWithFrame:CGRectMake(825, 182, 113, 39)];
        [self.downsideButtonTItle setTextColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.downsideButtonTItle];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell:(EDXCourseModel *)model type:(CellType)type{
    [self.courseName setText:model.displayName];
    self.courseDate.text = model.start;
    self.courseLastUpdateDate.text = @"";
    self.courseId = model.courseId;
    self.type = type;
    [self.courseIdLabel setText:self.courseId];
    switch (type) {
        case FindCourseCell:{
            self.upsideButtonTitle.text = @"课程介绍";
            self.downsideButtonTItle.text = @"注册课程";
            NSURL *courseImageUrl = [NSURL URLWithString:model.courseImageUrl];
            UIImage *courseImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:courseImageUrl]];
            self.courseImageView.image = courseImage;
            break;
        }
        case MyCourseCell:{
            self.upsideButtonTitle.text = @"课程更新";
            self.downsideButtonTItle.text = @"查看课程";
            UIImage *courseImage = [UIImage imageWithContentsOfFile:model.courseImageUrl];
            self.courseImageView.image = courseImage;
            break;
        }
        default:
            break;
    }
}

- (IBAction)upsideButtonAction:(id)sender {
    NSLog(@"tap unside");
    switch (self.type){

        case MyCourseCell:
            break;
        case FindCourseCell:
            break;
    }
}
- (IBAction)downSideAction:(id)sender {
    NSLog(@"tab downside");
    switch (self.type){

        case MyCourseCell:
//            [self.networkManager GetCourseDetail:self.courseId owner:self.container];
            [(EDXMyCourseViewController *)self.container navigateToCourseDetail:self.courseId];
            break;
        case FindCourseCell:
            [self.networkManager EnrollCourse:self.courseId owner:self.container];
            break;
    }
}

@end
