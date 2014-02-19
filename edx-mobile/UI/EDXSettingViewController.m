//
//  EDXSettingViewController.m
//  edx-mobile
//
//  Created by Guang Chen on 2/19/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import "EDXSettingViewController.h"

@interface EDXSettingViewController ()

@end

@implementation EDXSettingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *barItemImage = [UIImage imageNamed:@"tab_bar_item_setting.png"];
        UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"设置" image:barItemImage tag:2];
        self.tabBarItem = barItem;
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
