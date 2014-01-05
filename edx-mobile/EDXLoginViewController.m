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
#import "EDXNetworkManager.h"
@interface EDXLoginViewController ()

@end

@implementation EDXLoginViewController
objection_requires(@"dataManager");
@synthesize userName;
@synthesize password;
@synthesize dataManager;
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
    [userName setText:[dataManager GetUserName]];
    if ([[dataManager GetLoginAccess:self] isEqualToString:@""] == NO) {
        [self NavigateToDashBoard];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any reso      urces that can be recreated.
}

- (IBAction)LoginAction:(id)sender {
    NSString* postData = [NSString stringWithFormat:loginPost,userName.text,password.text];
    [[EDXNetworkManager sharedEDXNetworkManager]postBusinessReq:postData tag:kBusinessTagUserLogin owner:self];
}

- (IBAction)GetEnrollmentAction:(id)sender {
    [[EDXNetworkManager sharedEDXNetworkManager]getBusinessReq:kBusinessTagGetEnrollments owner:self];
}
- (void)dealloc {
    [userName release];
    [password release];
    [super dealloc];
}

- (void) LoginWith:(NSString *)username password:(NSString *)password{
    NSLog(@"login with user name:%@ password:%@ ",username,password);
}

- (void) LoginWith:(NSString *)access{
    NSLog(@"login with access token:%@",access);
}

- (void) NavigateToDashBoard{
    NSLog(@"navigate to dashboard");
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
