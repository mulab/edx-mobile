//
//  EDXFindCourseViewController.m
//  edx-mobile
//
//  Created by Guang Chen on 2/19/14.
//  Copyright (c) 2014 mulab. All rights reserved.
//

#import <Objection/JSObjection.h>
#import "EDXNetworkDelegate.h"
#import "EDXFindCourseViewController.h"
#import "EDXDataManager.h"
#import "EDXMyCourseViewController.h"

@interface EDXFindCourseViewController ()

@end

@implementation EDXFindCourseViewController
@synthesize courseList,dataManager,networkManager,courseTable;

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
        UIImage *barItemImage = [UIImage imageNamed:@"tab_bar_item_find_course.png"];
        UITabBarItem *barItem = [[UITabBarItem alloc] initWithTitle:@"发现" image:barItemImage tag:1];
        self.tabBarItem = barItem;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.courseTable.delegate=self;
    self.courseTable.dataSource=self;
    [self.networkManager GetCoursesFor:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.courseList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *courseCell = @"courseCell";
    EDXMyCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:courseCell];
    if(cell == nil){
        cell = [[EDXMyCourseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:courseCell];
    }
    EDXCourseModel *model = (EDXCourseModel *) [self.courseList objectAtIndex:(NSUInteger) indexPath.row];
    [cell setupCell:model type:FindCourseCell];
    cell.container = self;
    UIView *separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 219, 920, 11)];
    [separatorLineView setBackgroundColor:[UIColor lightGrayColor]];
    [cell.contentView addSubview:separatorLineView];
    return cell;
}

#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 230.0f;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}
#pragma mark EDXNetworkDelegate
- (void)before:(kBusinessTag)tag {

}

- (void)success:(id)result business:(kBusinessTag)tag {
    switch (tag){
        case kBusinessTagGetCourses:
            self.courseList = [self.dataManager parseCourseList:[result objectForKey:@"courses"]];
            [courseTable reloadData];
            break;
        case kBusinessTagEnrollCourse:
            [[EDXMyCourseViewController getInstance] refreshView];
        default:
            break;
    }
}

- (void)error:(NSError *)err business:(kBusinessTag)tag {

}

@end
