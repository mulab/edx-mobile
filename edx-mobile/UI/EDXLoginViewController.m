//
//  EDXLoginViewController.m
//  edx-mobile
//
//  Created by cissy on 13-11-12.
//  Copyright (c) 2013年 mulab. All rights reserved.
//

#import "EDXLoginViewController.h"
#import <Objection/Objection.h>
#import "EDXConstants.h"
@interface EDXLoginViewController ()

@end

@implementation EDXLoginViewController
objection_requires_sel(@selector(dataManager), @selector(networkManager));
@synthesize userName;
@synthesize password;
@synthesize dataManager,networkManager;

- (BOOL)prefersStatusBarHidden {
    return YES;
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
    networkManager = [[JSObjection defaultInjector] getObject:[EDXNetworkManager class]];
    dataManager = [[JSObjection defaultInjector] getObject:[EDXDataManager class]];
    [userName setText:[dataManager GetUserName]];
    NSLog(@"token:%@",[dataManager getAccessToken]);
//    EDXSignUpData data = {"user@user.com","username","password","user_full"};
//    NSString *url = [[[networkManager SignUpRequestWithData:data] URL] absoluteString];
    //[userName setText:[[[factory SignUpRequestWithData:data] URL] absoluteString]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)signUpAction:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:out_register_url]];
}

- (IBAction)LoginAction:(id)sender {
    EDXLoginData data = {
            client_id,
            client_secret,
            grant_type,
            [userName.text cStringUsingEncoding:NSUTF8StringEncoding],
            [password.text cStringUsingEncoding:NSUTF8StringEncoding]
    };
    [networkManager LoginWith:data owner:self];
}

- (void) LoginWith:(NSString *)access{
    NSLog(@"login with access token:%@",access);
}

- (void) NavigateToDashBoard{
    NSLog(@"navigate to dashboard");
}

#pragma mark EDXNetworkDelegate
- (void)before:(kBusinessTag)tag {

}

- (void)success:(id)result business:(kBusinessTag)tag {
    NSLog(@"result:%@",result);
    if(tag==kBusinessTagUserLogin){
        [dataManager saveAccessToken:[result objectForKey:@"access_token"]];
        NSLog(@"token:%@",[dataManager getAccessToken]);
        [networkManager setAccess_token:[result objectForKey:@"access_token"]];
    }
}

- (void)error:(NSError *)err business:(kBusinessTag)tag {

}

-(void) beginPost:(kBusinessTag)tag{
}
-(void) endPost:(id)result business:(kBusinessTag)tag{
    UIAlertView *message = nil;
    if(tag==kBusinessTagUserLogin){
        NSDictionary *respond = result;
        if ([respond objectForKey:@"access_token"]) {
            //if success
            NSLog(@"access_token:%@",[respond objectForKey:@"access_token"]);
//            EDXMainViewController* mainVC = [[EDXMainViewController alloc]init];
//            UINavigationController* vc =[[UINavigationController alloc]initWithRootViewController:mainVC];
//            [self.view.window setRootViewController:vc];
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
