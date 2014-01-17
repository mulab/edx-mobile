//
//  EDXLoginViewController.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXLoginViewController.h"
#import "EDXMainViewController.h"
#import <Objection/Objection.h>
@interface EDXLoginViewController ()

@end

@implementation EDXLoginViewController
objection_requires_sel(@selector(dataManager), @selector(factory));
@synthesize userName;
@synthesize password;
@synthesize dataManager,factory;
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
    factory = [[JSObjection defaultInjector] getObject:[EDXNetworkRequestFactory class]];
    [userName setText:[dataManager GetUserName]];
    if (![[dataManager GetLoginAccess:self] isEqualToString:@""]) {
        [self NavigateToDashBoard];
    }
    EDXSignUpData data = {"user@user.com","username","password","user_full"};
    NSString *url = [[[factory SignUpRequestWithData:data] URL] absoluteString];
    //[userName setText:[[[factory SignUpRequestWithData:data] URL] absoluteString]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any reso      urces that can be recreated.
}

- (IBAction)LoginAction:(id)sender {
    NSString* postData = [NSString stringWithFormat:loginPost,userName.text,password.text];

}

- (IBAction)GetEnrollmentAction:(id)sender {
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
            EDXMainViewController* mainVC = [[EDXMainViewController alloc]init];
            UINavigationController* vc =[[UINavigationController alloc]initWithRootViewController:mainVC];
            [self.view.window setRootViewController:vc];
        } else {
            //if not success
            message = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Login Failed" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
            [message show];
        }
    }else if (tag== kBusinessTagEnrollCourse){
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
