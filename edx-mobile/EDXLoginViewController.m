//
//  EDXLoginViewController.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXLoginViewController.h"
#import "EDXNetwork.h"
#import "EDXConstants.h"
#import "EDXMainViewController.h"
@interface EDXLoginViewController ()

@end

@implementation EDXLoginViewController
@synthesize userName;
@synthesize password;
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
    // Dispose of any reso      urces that can be recreated.
}

- (IBAction)LoginAction:(id)sender {
    NSString* postData = [NSString stringWithFormat:loginPost,userName.text,password.text];
    [[EDXNetwork sharedEDXNetwork]postBusinessReq:postData tag:kBusinessTagUserLogin owner:self];
}

- (IBAction)GetEnrollMentAction:(id)sender {
    [[EDXNetwork sharedEDXNetwork]getBusinessReq:kBusinessTagGetEnrollments owner:self];
}
- (void)dealloc {
    [userName release];
    [password release];
    [super dealloc];
}

#pragma mark NetworkModule delegate 
-(void) beginPost:(kBusinessTag)tag{
}
-(void) endPost:(id)result business:(kBusinessTag)tag{
    UIAlertView *message = nil;
    if(tag==kBusinessTagUserLogin){
        NSDictionary *respond = result;
        if ([respond objectForKey:@"access_token"]) {
            //if success
            NSLog(@"access_token:%@",[respond objectForKey:@"access_token"]);
            EDXMainViewController* mainVC = [[[EDXMainViewController alloc]init]autorelease];
            UINavigationController* vc =[[[UINavigationController alloc]initWithRootViewController:mainVC]autorelease];
            [self.view.window setRootViewController:vc];
        } else {
            //if not success
            message = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Login Failed" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [message show];
            [message release];
        }
    }else if (tag==kBusinessTagGetEnrollments){
        NSDictionary *response = result;
        if([response objectForKey:@"enrollments"]){
            NSArray *enrolls =  [response objectForKey:@"enrollments"];
            NSLog(@"enrolls:%@",[enrolls[0] objectForKey:@"display_name"]);
        }
    }
}
-(void) errorPost:(NSError *)err{
    NSLog(@"err:%@",[err localizedDescription]);
    NSLog(@"reason:%@",[err localizedFailureReason]);
    NSLog(@"suggestion:%@",[err localizedRecoverySuggestion]);
}
@end
