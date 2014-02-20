//
//  EDXMyCourseCell.m
//  edx-mobile
//
//  Created by Guang Chen on 2/20/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXMyCourseCell.h"
#import "EDXCourseModel.h"

@implementation EDXMyCourseCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupCell:(EDXCourseModel *)model{
    [self.courseName setText:model.displayName];
    self.courseDate.text = model.start;
    self.courseLastUpdateDate.text = @"";
    NSURL *courseImageUrl = [NSURL URLWithString:model.courseImageUrl];
    UIImage *courseImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:courseImageUrl]];
    self.courseImageView.image = courseImage;
}

- (IBAction)showLastUpdate:(id)sender {
}

- (IBAction)showCourseDetail:(id)sender {
}
@end
