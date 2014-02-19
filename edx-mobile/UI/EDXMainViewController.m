//
//  EDXMainViewController.m
//  edx-mobile
//
//  Created by Guang Chen on 2/19/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXMainViewController.h"
#import "EDXMyCourseViewController.h"
#import "EDXFindCourseViewController.h"
#import "EDXSettingViewController.h"

@interface EDXMainViewController ()

@end

@implementation EDXMainViewController

- (id)init {
    self = [super init];
    if (self) {
        EDXMyCourseViewController *myCourseViewController = [[EDXMyCourseViewController alloc] init];
        EDXFindCourseViewController *findCourseViewController = [[EDXFindCourseViewController alloc] init];
        EDXSettingViewController *settingViewController = [[EDXSettingViewController alloc] init];
        NSArray *controllers = [NSArray arrayWithObjects:myCourseViewController,findCourseViewController,settingViewController, nil];
        self.viewControllers = controllers;
    }

    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
