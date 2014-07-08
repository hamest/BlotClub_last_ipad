                                                                                                             //
//  ViewController.m
//  Connector
//
//  Created by Wayne Helman on 12-03-09.
//  Copyright (c) 2012 A51 Intgerated. All rights reserved.
//

#import "ViewController.h"
#import "LBAsycImageView.h"
#import "GameViewController.h"
#import "AppDelegate.h"
#import "Common.h"

@interface ViewController () {
    NSURL *avatarUrl;
    NSString *userNameStr;
    NSString *levelStr;
    NSString *edgeStr;
    float proggesWidth;
    NSString* creditsVal;
    BOOL isProff;
    GetChipView *viewGetChip;
    CustomAlertView *alertGoBack;
    CustomAlertView *alertReconection;
    CustomAlertView *alertNotProff;
    CustomAlertView *alertNotEnoughCredts;
    CustomAlertView *alertRestart;

    Translate * currentLunguage;

    IBOutlet UILabel *labelCashGame;
    IBOutlet UILabel *labelProfClub;
    IBOutlet UIButton *buttonLogOut;
    IBOutlet UILabel *labelGetChips;
    IBOutlet UILabel *labelLavelText;
    UIView *lunguageView;

}

- (void) RoomEventHandler:(NSNotification*)notification;
- (IBAction)getChipsButtonAction:(id)sender;
- (IBAction)chooseLunguageButtonAction:(id)sender;

@end

@implementation ViewController


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];

    gameManager = [GameManager sharedManager:productionBool];
    gameManager.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RoomEventHandler:) name:kNotification_Room object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conectionLost:) name:@"ConectionLostNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showChipButtons:) name:@"ShowChipButtonsNotifocation" object:nil];

    

    alertGoBack = [[CustomAlertView alloc] initWithdelegate:self];
    alertReconection = [[CustomAlertView alloc] initWithdelegate:self];
    alertNotEnoughCredts = [[CustomAlertView alloc] initWithdelegate:self];
    alertNotProff = [[CustomAlertView alloc] initWithdelegate:self];
    alertRestart = [[CustomAlertView alloc] initWithdelegate:self];

    viewGetChip = [[GetChipView alloc]init];
    viewGetChip.delegate = self;
    [self.view addSubview:viewGetChip];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you want to say hello?" message:@"More info..." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Say Hellotettrtertrt",@"Say Hellotettrtertrt",nil];
//    [alert show];
    
    float languageX = 0;
    float languageHeight = 0;
    float elementHieght = 0;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        languageX = 226;
        languageHeight = 68;
        elementHieght = 23;
        
    } else {
        languageX = 693;
        languageHeight = 90;
        elementHieght = 29;
    }
    lunguageView = [[UIView alloc]initWithFrame:CGRectMake(languageX, 0, 100, languageHeight)];
    lunguageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:lunguageView];
    lunguageView.hidden = YES;
    
    UIButton *enButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [enButton addTarget:self action:@selector(lunguageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    enButton.frame = CGRectMake(0, 0, 100, elementHieght);
    [enButton setBackgroundColor:[UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f]];
    [enButton setTitle:@"English" forState:UIControlStateNormal];
    [enButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    enButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    enButton.tag = ENGLSIH_LANGUAGE;
    [lunguageView addSubview:enButton];
    
    UIButton *ruButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ruButton addTarget:self action:@selector(lunguageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    ruButton.frame = CGRectMake(0, enButton.frame.origin.y + enButton.frame.size.height, 100, elementHieght);
    [ruButton setBackgroundColor:[UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f]];
    [ruButton setTitle:@"Русский" forState:UIControlStateNormal];
    [ruButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ruButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    ruButton.tag = RUSSIAN_LANGUAGE;
    [lunguageView addSubview:ruButton];
    
    UIButton *amButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [amButton addTarget:self action:@selector(lunguageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    amButton.frame = CGRectMake(0, ruButton.frame.origin.y + ruButton.frame.size.height, 100, elementHieght);
    [amButton setBackgroundColor:[UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f]];
    [amButton setTitle:@"Հայերեն" forState:UIControlStateNormal];
    [amButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    amButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    amButton.tag = ARMENIAN_LANGUAGE;
    [lunguageView addSubview:amButton];
   

}

#pragma mark - CustomAlertView delegate

- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
        }
        if (buttonIndex == 1) {
            BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
            [[GameManager sharedManager:productionBool] backClub:[Globals sharedGlobals].tablecredits];
        }
    } else if (alertView.tag == 2) {
        if (buttonIndex == 0) {
        }
        if (buttonIndex == 1) {
            BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
            gameManager = nil;
            gameManager = [GameManager sharedManager:productionBool];
            gameManager.delegate = self;
            [gameManager connect];
        }
    }
}


#pragma mark - GameManager Event Handlers

- (void) didConnect:(SFSEvent *)evt {
	NSArray *keys = [evt.params allKeys];
	
	for (NSString *key in keys) {
		NSLog(@"%@: %@", key, [evt.params objectForKey:key]);
	}
    
	if ([[evt.params objectForKey:@"success"] boolValue])
	{
        loginBtn.enabled = YES;
        BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
        NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"UserName"];
        if (name) {
            [[GameManager sharedManager:productionBool] loginWithUserName:name];

        }
	}
	else
	{
     //   NSLog(@"%@", [NSString stringWithFormat:@"Connection error: %@.", [evt.params objectForKey:@"error"]]);
	}
}

- (void)didConnectLost:(SFSEvent *)evt {
    [self conectionLost:nil];
}


-(void)conectionLost:(NSNotification *)notification {
    
    alertReconection.tag = 2;
    [alertReconection showWithMessage:[Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].Reconnect otherButtonTitle:@"OK"];
    
   // NSLog(@"You have been disconnected from Demo");
    loginBtn.enabled = NO;
    logoutBtn.enabled = NO;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    debugLog.layer.cornerRadius = 8;
    debugLog.layer.borderWidth = 1.0f;
    debugLog.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    debugLog.clipsToBounds = YES;
    if ([Globals sharedGlobals].me) {
        [self updateMyself:[Globals sharedGlobals].me];
    }
    int lung = [[NSUserDefaults standardUserDefaults] integerForKey:@"Language"];
    currentLunguage = [Translate sharedManagerLunguage:lung];
    [self setLunguage];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - Example Logic

/**
 * Write information to our UITextView log
 */
- (void)trace:(NSString *) msg
{
    debugLog.text = [NSString stringWithFormat:@"%@\n\n%@", msg, debugLog.text];
}

/**
 * Log in to the zone configured in the config.xml
 */

- (IBAction)login:(id)sender {
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] loginWithUserName:nil];
    loginBtn.enabled = NO;
}

/**
 * Log out of the zone
 */
- (IBAction)logout:(id)sender {
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] logout];
    [self dismissViewControllerAnimated:NO completion:nil];
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate fbLogout];

}

- (IBAction)disconnect:(id)sender {
    disconnectBtn.enabled = YES;
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] disconnect];
}

- (IBAction)getChipsButtonAction:(id)sender {
    viewGetChip.hidden = NO;
    [MKStoreManager sharedManager];

    if ([MKStoreManager sharedManager].purchasableObjects && [MKStoreManager sharedManager].purchasableObjects.count == 0) {
        viewGetChip.transparent.hidden = NO;
         [viewGetChip.indicator startAnimating];

    } else {
        viewGetChip.transparent.hidden = YES;
    }

}

-(void)showChipButtons:(NSNotification *)notification {
    [viewGetChip.indicator stopAnimating];
    viewGetChip.transparent.hidden = YES;

}

- (void)buyChipsWithTag:(int)tag {
    [MKStoreManager sharedManager].delegate = self;
    [[MKStoreManager sharedManager] buyFilmByValue:[NSString stringWithFormat:@"bc_cp_%d",tag]];
}

- (void)productPurchased:(SKPaymentTransaction*)paymentTransaction {
   // NSLog(@"productPurchased");
    viewGetChip.hidden = YES;
    
}
- (void)failed:(NSString *)urlStr {
   // NSLog(@"failed");
    if (urlStr) {
        NSMutableArray *array = (NSMutableArray *)[[NSUserDefaults standardUserDefaults] objectForKey:@"PaymentUrlArray"];
        if (array == nil) {
            array = [[NSMutableArray alloc]init];
        } else {
            array = [[NSMutableArray alloc]initWithArray:array];
        }
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:urlStr forKey:@"urlStr"];
        [dic setObject:[NSNumber numberWithInt:0] forKey:@"count"];
        [array addObject:dic];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"PaymentUrlArray"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
       // NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"PaymentUrlArray"]);
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"BlotClub"
                                                          message:@"Payment failed"
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];

    }
    viewGetChip.hidden = YES;
    
}



#pragma mark - Event Handlers


- (void)onConnectionRetry:(SFSEvent *)evt
{
    [self trace:@"Connection error. Re-attempting SFS2X connection..."];
    loginBtn.enabled = NO;
}


- (void)didLogin:(SFSEvent *)evt {
    SFSObject *data = [evt.params objectForKey:@"data"];
    SFSObject *custom = [data getSFSObject:@"custom"];
    
    avatarUrl = [[NSURL alloc]initWithString:[custom getUtfString:@"fsavatar"]];
    
    LBAsyncImageView *coverImage = [[LBAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, avatarView.frame.size.width, avatarView.frame.size.height)];
    [coverImage loadImageFromURL:avatarUrl];
    coverImage.layer.borderWidth = 1;
    coverImage.layer.borderColor = [UIColor whiteColor].CGColor;
    [avatarView addSubview:coverImage];
    
    userNameStr = [custom getUtfString:@"user_login"];
    userName.text = userNameStr;
    
    [self updateMyself:custom];
}

- (void)updateMyself:(SFSObject *)me {
    levelStr = [NSString stringWithFormat:@"%d",[[me getUtfString:@"fslevel"] integerValue]];
    level.text = levelStr;
    
    NSInteger maxVal = [[me getUtfString:@"fsedge"] integerValue];
    NSInteger minVal = [[me getUtfString:@"fslowedge"] integerValue];
    NSInteger currentVal = [[me getUtfString:@"fspoints"]integerValue];
    edgeStr = [NSString stringWithFormat:@"%d/%d",currentVal,maxVal];
    
    if (maxVal >10000) {
        edgeStr = [NSString stringWithFormat:@"%0.1fk/%0.1fk",(float)currentVal/1000,(float)maxVal/1000];
    }
    currentAndMaxEdge.text = edgeStr;
    
    proggesWidth = (currentVal - minVal)*(viewProgress.frame.size.width)/(maxVal - minVal);
    UIView *currentProggesView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, proggesWidth - 2, viewProgress.frame.size.height -2)];
    currentProggesView.backgroundColor = [UIColor colorWithRed:(221/255.0) green:(184/255.0) blue:(31/255.0) alpha:1];
    [viewProgress addSubview:currentProggesView];
    
    creditsVal = [NSString stringWithFormat:@"%d",[[me getUtfString:@"fscredits"] integerValue]];;
    credits.text = creditsVal;
}

- (void)didLoginError:(SFSEvent *)evt
{
   // NSLog(@"didLoginError");
  //  loginBtn.enabled = YES;
}

- (void)didLogout:(SFSEvent *)evt
{
   // NSLog(@"didLogout");
   // loginBtn.enabled = YES;
   // logoutBtn.enabled = NO;
}

- (IBAction)tabelsButtonAction:(id)sender {
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] chooseClub:200];
    isProff = NO;
}

- (IBAction)profClubButtonAction:(id)sender {
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] chooseClub:500];
    isProff = YES;
}

#pragma mark - Game Manager Event


- (void) RoomEventHandler:(NSNotification*)notification {
    NSString *eventName = [notification object];
    
    if ([eventName isEqualToString:@"JOIN"]) {
        GameViewController *gameViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"GameViewController"];
        gameViewController.isProff = isProff;
        gameViewController.userNameStr = userNameStr;
        gameViewController.avatarUrl = avatarUrl;
        gameViewController.proggesWidth = proggesWidth;
        gameViewController.edgeStr = edgeStr;
        gameViewController.levelStr = levelStr;
        gameViewController.creditsVal = creditsVal;
        [self.navigationController pushViewController:gameViewController animated:YES];
    }
}

/*-(void)onUserEnterRoom:(SFSEvent *)evt {
     NSLog(@"onUserEnterRoom evt.params: %@", evt.params);
    SFSRoom *room = (SFSRoom *)[evt.params objectForKey:@"room"];
    NSArray *playerList = room.playerList;
    
    // drow users
    
    
    
}*/

- (void)askToJoinLastRoom {
    alertGoBack.tag = 1;
    [alertGoBack showWithMessage:[Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].REJOIN_GAME otherButtonTitle:@"OK"];
}

- (void)showMassage:(int)massageTag {
    switch (massageTag) {
        case MSGTAG_NOT_PROF: {
            [alertNotProff showWithMessage:[Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].MSG_PROF_CLUB_DENY otherButtonTitle:nil];
        }
            break;
        case MSGTAG_NOT_ENOUGH_CREDITS: {
            [alertNotEnoughCredts showWithMessage:[Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].MSG_NOT_ENOUGH_CREDITS otherButtonTitle:nil];
        }
            break;
        case MSGTAG_RESTARTING: {
            [alertRestart showWithMessage:[Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].MSG_RESTARTING otherButtonTitle:nil];
        }
            break;
            
        default:
            break;
    }
}

- (void)lunguageButtonAction:(id)sender {
    UIButton *lunguage = (UIButton *)sender;
    [currentLunguage setLunguage:lunguage.tag];
    [[NSUserDefaults standardUserDefaults] setInteger:lunguage.tag forKey:@"Language"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self setLunguage];
    lunguageView.hidden = YES;
    
}

- (IBAction)chooseLunguageButtonAction:(id)sender {
    lunguageView.hidden = NO;
}

- (void)setLunguage {
    labelCashGame.text = currentLunguage.LB_ARCADE;
    labelProfClub.text = currentLunguage.LB_PROF;
    labelLavelText.text = currentLunguage.LEVEL;
    labelGetChips.text  = currentLunguage.GET_CHIPS;
    
    [buttonLogOut setTitle:currentLunguage.EXIT forState:UIControlStateNormal];
    //[self showMassage:MSGTAG_NOT_PROF];
}


@end
