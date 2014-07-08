//
//  LoginViewController.m
//  Connector
//
//  Created by Hamest Tadevosyan on 3/3/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "LoginViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"

@interface LoginViewController () {
    
    IBOutlet UIButton *aqazonButton;
    IBOutlet UIButton *patahakan;
    IBOutlet UIButton *gevorgButton;
    NSString *userName;
    CustomAlertView *alertReconection;
}
- (IBAction)GevorgButtonAction:(id)sender;
- (IBAction)patahakanButtonAction:(id)sender;
- (IBAction)AqazonButtonAction:(id)sender;
- (IBAction)productionButtonAction:(id)sender;
- (IBAction)demoButtonAction:(id)sender;
- (IBAction)fbButtonAction:(id)sender;

@end

@implementation LoginViewController

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
	// Do any additional setup after loading the view.
   // gameManager = [GameManager sharedManager];
    //gameManager.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginUser:) name:@"LoginUserNotification" object:nil];

    alertReconection = [[CustomAlertView alloc] initWithdelegate:self];
    [self productionButtonAction:nil];
}

- (void) didConnect:(SFSEvent *)evt {
	NSArray *keys = [evt.params allKeys];
	
	for (NSString *key in keys) {
		//NSLog(@"%@: %@", key, [evt.params objectForKey:key]);
	}
    
	if ([[evt.params objectForKey:@"success"] boolValue])
	{
       // NSLog(@"You are now connected to SFS2X");
        gevorgButton.enabled = YES;
        patahakan.enabled = YES;
        aqazonButton.enabled = YES;
	}
	else
	{
       // NSLog(@"%@", [NSString stringWithFormat:@"Connection error: %@.", [evt.params objectForKey:@"error"]]);
	}
}

- (void)didConnectLost:(SFSEvent *)evt {
    [self conectionLost:nil];
}


-(void)conectionLost:(NSNotification *)notification {
    
    alertReconection.tag = 1;
    [alertReconection showWithMessage:[Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].Reconnect otherButtonTitle:@"OK"];
   // NSLog(@"You have been disconnected from Demo");
}
- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
            //   NSLog(@"close Allert");
        }
        if (buttonIndex == 1) {
          //  BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
            gameManager = nil;
            gameManager = [GameManager sharedManager:productionBool];
            gameManager.delegate = self;
            [gameManager connect];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)GevorgButtonAction:(id)sender {

//    [self loginWithUserName:@"bd70847d0b639450e9e1856ee3aea3a7"];
//    ViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewController"];
//    [self presentViewController:viewController animated:NO completion:nil];
    userName = @"bd70847d0b639450e9e1856ee3aea3a7";
    [self loginWithUserName:userName];
}

- (IBAction)patahakanButtonAction:(id)sender {
    userName = nil;
    [self loginWithUserName:@""];

}

- (IBAction)AqazonButtonAction:(id)sender {
    userName = @"887d12cb08616faa2838e26355d4b588";
    [self loginWithUserName:userName];

}

- (IBAction)productionButtonAction:(id)sender {

    productionBool = YES;
    [GameManager sharedManager:productionBool];
    [GameManager sharedManager:productionBool].delegate = self;
}

- (IBAction)demoButtonAction:(id)sender {
    productionBool = NO;

    [GameManager sharedManager:productionBool];
    [GameManager sharedManager:productionBool].delegate = self;
}

- (void)LoginUser:(NSNotification *)notification{
    NSString *user_id = (NSString *)notification.object;
    [self loginWithUserName:user_id];
}

- (void)loginWithUserName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"UserName"];
    [[NSUserDefaults standardUserDefaults] setBool:productionBool forKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] loginWithUserName:name];
    UINavigationController *navController  = [self.storyboard instantiateViewControllerWithIdentifier:@"NavController"];
    [self presentViewController:navController animated:NO completion:nil];
}

- (IBAction)fbButtonAction:(id)sender {
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate fbLogin];
}

@end
