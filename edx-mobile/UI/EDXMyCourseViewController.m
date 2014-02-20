//
//  EDXMyCourseViewController.m
//  edx-mobile
//
//  Created by Guang Chen on 2/19/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import <Objection/Objection.h>
#import "EDXMyCourseViewController.h"
#import "EDXMyCourseCell.h"
#import "EDXNetworkManager.h"
#import "EDXDataManager.h"
#import "EDXCourseModel.h"

@interface EDXMyCourseViewController ()

@end

@implementation EDXMyCourseViewController
objection_requires_sel(@selector(dataManager), @selector(networkManager));
@synthesize dataManager,networkManager,myCourseList,myCourseTable;
- (id)init {
    self = [super init];
    if (self) {
        networkManager = [[JSObjection defaultInjector] getObject:[EDXNetworkManager class]];
        dataManager = [[JSObjection defaultInjector] getObject:[EDXDataManager class]];
    }

    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        UIImage *barItemImage = [UIImage imageNamed:@"tab_bar_item_my_course.png"];
        UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"我的课程" image:barItemImage tag:0];
        self.tabBarItem = barItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [networkManager GetEnrollCourseFor:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark EDXNetworkDelegate
- (void)before:(kBusinessTag)tag {
    switch (tag){
        case kBusinessTagGetEnrolls:
            break;
        default:
            break;
    }
}

- (void)success:(id)result business:(kBusinessTag)tag {
    switch (tag){
        case kBusinessTagGetEnrolls:
            [dataManager saveMyCourseList:result];
            myCourseList = [dataManager getMyCourseList];
            [myCourseTable reloadData];
            break;
        default:
            break;
    }
}

- (void)error:(NSError *)err business:(kBusinessTag)tag {

}


#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myCourseList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *myCourseCell = @"myCourseCell";
    EDXMyCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:myCourseCell];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EDXMyCourseCell" owner:self options:nil];
        for (id item in nib){
            if([item isKindOfClass:[EDXMyCourseCell class]]){
                cell = [(EDXMyCourseCell *)item initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myCourseCell];
            }
        }
    }
    EDXCourseModel *model = (EDXCourseModel *) [self.myCourseList objectAtIndex:(NSUInteger) indexPath.row];
    [cell setupCell:model];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 184.0f;
}


@end
