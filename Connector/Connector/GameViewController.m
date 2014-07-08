//
//  GameViewController.m
//  Connector
//
//  Created by Hamest Tadevosyan on 1/31/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "GameViewController.h"
#import "User.h"
#import "Utils.h"
#import "LastRukDialogView.h"
#import "ScoreView.h"
#import "LBAsycImageView.h"
#import "NewGameOfferView.h"
#import "LastBazarView.h"
#import "CurrentPointsView.h"
#import "LastScoreSquereView.h"
#import "CustomAlertView.h"
#import <AudioToolbox/AudioToolbox.h>
#import "Common.h"


@interface GameViewController () {
    NSMutableArray *arrayUsers;
    NSMutableArray *arrayCards;
    NSMutableArray *arrayCartsOnTable;
    NSMutableArray *arrayCartsOnTableBuffer;
    
    
    IBOutlet UIImageView *background;
    IBOutlet UIButton *readyButton;
    IBOutlet UIButton *buttonContra;
    
    IBOutlet UIView *viewBazar;
    IBOutlet UILabel *labelTiv;
    
    IBOutlet UIButton *buttonKontra;
    
    
    IBOutlet UIView *viewRecontra;
    IBOutlet UIButton *buttonRecontra;
    IBOutlet UILabel *labelRecontra;
    IBOutlet UIImageView *recontraMastImageView;

    IBOutlet UIButton *volumeButton;
    
    IBOutlet UIView *turnPipView;
    
    IBOutlet UILabel *userName;
    IBOutlet UIView *avatarView;
    IBOutlet UILabel *level;
    IBOutlet UILabel *currentAndMaxEdge;
    IBOutlet UIView *viewProgress;
    IBOutlet UILabel *credits;
    
    
    GetChipView *viewGetChip;
    
    IBOutlet UIView *viewExtraComplete;
    
    IBOutlet UILabel *labelExtraComplete;
    
    LastBazarView *lastbazar;
    CurrentPointsView *currentpoints;
    LastScoreSquereView *lastScoreSquere;
    CustomAlertView *lostView;
    LastRukDialogView *lastRukDialog;
    ScoreView *scoreView;
    
    User *user1;
    User *user2;
    User *user3;
    User *user4;
    
    BOOL kontra_active;
    UIButton *selected_mast;
    int take_card_seat;
    int lastMast;
    int lastTiv;
    UIImageView *glow;
    BOOL selfclick;
    IBOutlet UILabel *labelGetChips;
    IBOutlet UILabel *labelLavelText;
    Translate * currentLunguage;
    IBOutlet UIButton *buttonNO;
    IBOutlet UIButton *buttonYes;
    IBOutlet UIButton *buttonXod;
    IBOutlet UIButton *buttonPass;
    IBOutlet UILabel *labelTurn;
    IBOutlet UIButton *buttonExit;
    IBOutlet UILabel *labelRate;
    int rateValue;
    UIView *lunguageView;
}

- (IBAction)volumeButtonAction:(id)sender;

- (void) showBazarTip:(int)lacto Lacti:(int)lacti Params:(SFSObject*)params;
- (void) BazarWindowRecontra:(BOOL)recontra LastMast:(int)lm LastType:(int)lt;
- (void) BazarWindow:(BOOL)value LastTiv:(int)lastTiv;
- (Card*) getCardWithPosition:(int)pos;
- (void) rebuildCards;
- (void) addCardToList:(Card*)card;
- (IBAction)lastRukButtonAction:(id)sender;
- (IBAction)scoreButtonAction:(id)sender;
- (IBAction)readyButtonAction:(id)sender;
- (IBAction)exitButtonAction:(id)sender;
- (IBAction)downButtonAction:(id)sender;
- (IBAction)upButtonAction:(id)sender;
- (IBAction)mastButtonAction:(id)sender;
- (IBAction)xodButtonAction:(id)sender;
- (IBAction)passButtonAction:(id)sender;
- (IBAction)kontraButtonAction:(id)sender;
- (IBAction)rekontraButtonAction:(id)sender;
- (IBAction)showExtraCompleteButtonAction:(id)sender;
- (IBAction)dontShowExtraCompleteButtonAction:(id)sender;
- (IBAction)getChipsButtonAction:(id)sender;
//- (IBAction)closeGetChipViewButtonAction:(id)sender;
//- (IBAction)buyChipsButtonAction:(id)sender;
- (void)lunguageButtonAction:(id)sender;
- (IBAction)chooseLunguageButtonAction:(id)sender;


@end

@implementation GameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    
    return self;
}

- (void) awakeFromNib {
    [super awakeFromNib];

    kontra_active = NO;
    selected_mast = nil;
    take_card_seat = -1;
    
    arrayCards = [[NSMutableArray alloc] init];
    arrayCartsOnTable = [[NSMutableArray alloc] init];
    arrayCartsOnTableBuffer = [[NSMutableArray alloc] init];
    arrayUsers = [[NSMutableArray alloc] init];
    
    lastbazar = [[LastBazarView alloc]init];
    lastbazar.hidden = YES;
   // [lastbazar setMast:1 tiv:60 contra:YES recontra:YES];

    [self.view addSubview:lastbazar];
    
    currentpoints = [[CurrentPointsView alloc]init];
    currentpoints.hidden = YES;
   // [currentpoints setScore1:1860 setScore2:5567 team1:@"A/R" team2:@"H/T"];
    [self.view addSubview:currentpoints];
    
    lastScoreSquere = [[LastScoreSquereView alloc]init];
    lastScoreSquere.hidden = YES;
   // [lastScoreSquere setScore1:160 setScore2:5678 team1:@"A/R" team2:@"H/T"];
    [self.view addSubview:lastScoreSquere];
    
    lastRukDialog = [[LastRukDialogView alloc] init];
    [self.view addSubview:lastRukDialog];
    
    scoreView = [[ScoreView alloc] init];
    [self.view addSubview:scoreView];
    
    lostView = [[CustomAlertView alloc] initWithdelegate:self];
    

    glow = [[UIImageView alloc] init];
    [self.view addSubview:glow];
    glow.alpha = 0;
    
    for (int i = 0; i < 4; i++) {
        int userLength = 100;
        int distance = 50;
        
        switch (i) {
            case 0: {
                user1 = [[User alloc] initWithFrame:CGRectMake(1024/2 - userLength/2, 768 - userLength - distance + 10, userLength, userLength) andTag:i];
                [arrayUsers addObject:user1];
                [self.view addSubview:user1];
            }
                break;
            case 1: {
                user2 = [[User alloc] initWithFrame:CGRectMake(distance, 768/2 - userLength/2, userLength, userLength) andTag:i];
                [arrayUsers addObject:user2];
                [self.view addSubview:user2];
            }
                break;
            case 2: {
                user3 = [[User alloc] initWithFrame:CGRectMake(1024/2 - userLength/2, distance + 50, userLength, userLength) andTag:i];
                [arrayUsers addObject:user3];
                [self.view addSubview:user3];
            }
                break;
            case 3: {
                user4 = [[User alloc] initWithFrame:CGRectMake(1024 - userLength - distance, 768/2 - userLength/2, userLength, userLength) andTag:i];
                [arrayUsers addObject:user4];
                [self.view addSubview:user4];
            }
                break;
                
            default:
                break;
        }
    }
    viewTable.layer.masksToBounds = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [GameManager sharedManager:productionBool].delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(shaerCardsNotificatin:) name:kNotification_SHARE_CARDS object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitButtonAction:) name:@"GoBackNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showChipButtons:) name:@"ShowChipButtonsNotifocation" object:nil];

    viewGetChip = [[GetChipView alloc]init];
    viewGetChip.delegate = self;
    [self.view addSubview:viewGetChip];
    
    lunguageView = [[UIView alloc]initWithFrame:CGRectMake(693, 0, 100, 90)];
    lunguageView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:lunguageView];
    lunguageView.hidden = YES;
    
    UIButton *enButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [enButton addTarget:self action:@selector(lunguageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    enButton.frame = CGRectMake(0, 0, 100, 30);
    [enButton setBackgroundColor:[UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f]];
    [enButton setTitle:@"English" forState:UIControlStateNormal];
    [enButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    enButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    enButton.tag = ENGLSIH_LANGUAGE;
    [lunguageView addSubview:enButton];
    
    UIButton *ruButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [ruButton addTarget:self action:@selector(lunguageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    ruButton.frame = CGRectMake(0, 29, 100, 30);
    [ruButton setBackgroundColor:[UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f]];
    [ruButton setTitle:@"Русский" forState:UIControlStateNormal];
    [ruButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    ruButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    ruButton.tag = RUSSIAN_LANGUAGE;
    [lunguageView addSubview:ruButton];
    
    UIButton *amButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [amButton addTarget:self action:@selector(lunguageButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    amButton.frame = CGRectMake(0, 58, 100, 30);
    [amButton setBackgroundColor:[UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f]];
    [amButton setTitle:@"Հայերեն" forState:UIControlStateNormal];
    [amButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    amButton.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    amButton.tag = ARMENIAN_LANGUAGE;
    [lunguageView addSubview:amButton];
  
    int lung =[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"];
    currentLunguage = [Translate sharedManagerLunguage:[Translate sharedManagerLunguage:lung]];

    BOOL vol = [[NSUserDefaults standardUserDefaults] boolForKey:@"volume"];
    if (!vol) {
        [volumeButton setBackgroundImage:[UIImage imageNamed:@"Sound_off.png"] forState:UIControlStateNormal];
    } else {
        [volumeButton setBackgroundImage:[UIImage imageNamed:@"Sound_on.png"] forState:UIControlStateNormal];
        
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isProff) {
        background.image = [UIImage imageNamed:@"proffBg.png"];
        rateValue = 500;
        for (UIView *subview in viewTable.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                subview.hidden = NO;
                CGAffineTransform transformNaxsh = CGAffineTransformMakeRotation(0);
                
                switch (subview.tag) {
                    case 101: {
                        transformNaxsh = CGAffineTransformMakeRotation(M_PI/2);
                    }
                        break;
                    case 102: {
                        transformNaxsh = CGAffineTransformMakeRotation(M_PI);
                    }
                        break;
                        
                    case 103: {
                        transformNaxsh = CGAffineTransformMakeRotation(-M_PI/2);
                    }
                        break;
                        
                        

                    default:
                        break;
                }
                subview.transform = transformNaxsh;
                
            }
        }
    } else {
        background.image = [UIImage imageNamed:@"cashBg.png"];
        rateValue = 200;
    }
    
    labelRate.text = [NSString stringWithFormat:@"%@: %d",currentLunguage.RATE,rateValue];
    
    LBAsyncImageView *coverImage = [[LBAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, avatarView.frame.size.width, avatarView.frame.size.height)];
    [coverImage loadImageFromURL:self.avatarUrl];
    coverImage.layer.borderWidth = 1;
    coverImage.layer.borderColor = [UIColor whiteColor].CGColor;
    [avatarView addSubview:coverImage];
    
    userName.text = self.userNameStr;
    
    level.text = self.levelStr;
    currentAndMaxEdge.text = self.edgeStr;
    
    UIView *currentProggesView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, self.proggesWidth - 2, viewProgress.frame.size.height -2)];
    currentProggesView.backgroundColor = [UIColor colorWithRed:(221/255.0) green:(184/255.0) blue:(31/255.0) alpha:1];
    [viewProgress addSubview:currentProggesView];
    credits.text = self.creditsVal;
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [self updateUsers:[[GameManager sharedManager:productionBool] getGamePlayers]];
   // [self showExtraTip:nil];
   
   // [self glow:4];
    [self setLunguage];


}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [user1 showToolTipWithState:ToolTipState_MastAndTipe Title:nil andCards:NO];
//    card = [[Card alloc] initWithFrame:CGRectMake(512 - 106/2, 50, 106, 143)];
//    [card setMast:-1 Type:8];
//    [self.view addSubview:card];
//    
//    [card moveTo:CGPointMake(100, 700) Angle:M_PI inTime:1.0];
    
//    [self didShareCards:nil];

}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [GameManager sharedManager:productionBool].delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)readyButtonAction:(id)sender {
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] ready];
    readyButton.hidden = YES;
   // NSLog(@" readyButtonAction :Hidde readyButton");

}

- (IBAction)exitButtonAction:(id)sender {
    if ([Utils exitWithAlert]) {
        lostView.tag = 1;
        [lostView showWithMessage:[Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].EXIT_GAME_RATING otherButtonTitle:@"OK"];
        

    } else {
        BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
        [[GameManager sharedManager:productionBool] Leave];
        [Globals sharedGlobals].game_score = nil;

        [self.navigationController popViewControllerAnimated:YES];
    }
   
}

- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        if (buttonIndex == 0) {
          //  NSLog(@"close Allert");
        }
        if (buttonIndex == 1) {
            BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
            [[GameManager sharedManager:productionBool] Leave];
            [Globals sharedGlobals].game_score = nil;
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
//     else if (alertView.tag == 2) {
//        if (buttonIndex == 0) {
//            NSLog(@"close Allert");
//        }
//        if (buttonIndex == 1) {
//            NSLog(@"connect");
//            BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
//            [[GameManager sharedManager:productionBool] connect];
//        }
//
//    }
    
}


- (IBAction)downButtonAction:(id)sender {
    if ([labelTiv.text integerValue] - 1 > lastTiv) {
        labelTiv.text = [NSString stringWithFormat:@"%d", [labelTiv.text integerValue] - 1];
    }
}

- (IBAction)upButtonAction:(id)sender {
    labelTiv.text = [NSString stringWithFormat:@"%d", [labelTiv.text integerValue] + 1];
}

- (IBAction)mastButtonAction:(id)sender {
    UIButton *button = (UIButton*)sender;
    selected_mast.enabled = YES;
    selected_mast = button;
    selected_mast.enabled = NO;
    [self sound:@"bazar"];
}



- (IBAction)xodButtonAction:(id)sender {
    [self sound:@"bazar"];

    if (selected_mast) {
        viewBazar.hidden = YES;
        BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
        [[GameManager sharedManager:productionBool] sayRequestAct:@"XOD" Tiv:[labelTiv.text integerValue] Mast:selected_mast.tag];
       // selected_mast = -1;
    }
}

- (IBAction)passButtonAction:(id)sender {
    [self sound:@"bazar"];

    viewBazar.hidden = YES;
    viewRecontra.hidden = YES;
    
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] sayRequestAct:@"PASS" Tiv:0 Mast:0];
    //selected_mast = -1;
}

- (IBAction)kontraButtonAction:(id)sender {
    [self sound:@"bazar"];

    viewRecontra.hidden = YES;
    viewBazar.hidden = YES;

    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] sayRequestAct:@"CONTRA" Tiv:0 Mast:0];
}

- (IBAction)rekontraButtonAction:(id)sender {
    viewRecontra.hidden = YES;
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] sayRequestAct:@"RECONTRA" Tiv:lastTiv Mast:lastMast];

}

- (void)didResetBoard {
    
    @synchronized (self) {
        for (User *user in arrayUsers) {
            BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
            if (user.sfsUser != [[GameManager sharedManager:productionBool] mySelf]) {
                user.sfsUser = nil;
            }
        }
    }
}

- (void)updateUsers:(NSArray *)playersList {
   // readyButton.hidden = NO;

    @synchronized (self) {
      //  NSLog(@"%@",playersList);
//        if ([playersList count] == 4) {
//            // cngoc
//            NSLog(@" updateUsers  :Show readyButton");
//            readyButton.hidden = NO;
//        } else {
//            readyButton.hidden = YES;
//             NSLog(@" updateUsers :Hidde readyButton");
//        }
        
        for (int index = 0; index < [playersList count]; index++) {
            SFSUser *sfsUser = [playersList objectAtIndex:index];
            SFSUserVariable *seat = [sfsUser getVariable:@"seat"];
            int value = [seat getIntValue];
            
       //     NSLog(@"SEAT value :%d", value);
            int userSeat = [Utils transformSeat:value];
       //     NSLog(@"userSeat   :%d",userSeat );
            User *user = [arrayUsers objectAtIndex:userSeat - 1];
            [user setSfsUser:sfsUser];
        }
}

    

 
//    @try {
//        SFSUser *mySelf = [[GameManager sharedManager] mySelf];
//        SFSUserVariable * uv = [mySelf getVariable:@"seat"];
//        
//        if (uv != nil) {
//            [Globals sharedGlobals].mySeat = [uv getIntValue];
//        }
//        for (int index = 0; index < [playersList count]; index++) {
//            SFSUser *u = [playersList objectAtIndex:index];
//            if (u.name != mySelf.name) {
//                uv = [u getVariable:@"seat"];
//                if (uv != nil) {
//                    int trSeat = [Utils transformSeat:[uv getIntValue]];
//                    User *user = [arrayUsers objectAtIndex:trSeat-1];
//                    user.sfsUser = u;
//                }
//                else {
//                }
//                
//            }
//        }
//    }  @catch (NSException *exception) {
//        NSLog(@"exception.description: %@", exception.description);
//    }
}

- (void)updateReadyState:(NSArray *)readyPlayersList {
    
   // NSLog(@"readyPlayersList count : %d",[readyPlayersList count]);

    if ([readyPlayersList count] == 0) {
        // cngoc
        if (readyButton.hidden) {
            [self sound:@"ready_bell"];
            readyButton.hidden = NO;
        }
       
      //  NSLog(@" updateReadyState  :Show readyButton");

    }
    for (int i = 0; i < [readyPlayersList count]; i++) {
        int seat = [[readyPlayersList objectAtIndex:i] integerValue];
        seat = [Utils transformSeat:seat];
        User *user = [arrayUsers objectAtIndex:seat - 1];
        
        [user showToolTipWithState:ToolTipState_Speak Title:currentLunguage.READY step:0 andCards:nil];
    }
    
    if ([readyPlayersList containsObject:[NSNumber numberWithInt:[Globals sharedGlobals].mySeat]]) {
        readyButton.hidden = YES;
    } else {
        if (readyButton.hidden) {
            [self sound:@"ready_bell"];
            readyButton.hidden = NO;
        }
    }
}

- (void)sound:(NSString *)soundName {
    BOOL vol = [[NSUserDefaults standardUserDefaults] boolForKey:@"volume"];
    if (vol) {
        SystemSoundID mySound;
        
        NSString *soundPath = [[NSBundle mainBundle]
                               pathForResource:soundName ofType:@"mp3"];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &mySound);
        AudioServicesPlaySystemSound(mySound);

    }
}

- (void)didConnectLost:(SFSEvent *)evt {
    [Globals sharedGlobals].game_score = nil;
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ConectionLostNotification" object:nil];
//    CustomAlertView *alert = [[CustomAlertView alloc] initWithTitle:@"Connection lost" message:@"click \"OK\" to reconnect" delegate:self otherButtonTitles:@"OK",nil];
//    alert.tag = 2;
//    [alert show];
//    
//    NSLog(@"You have been disconnected from Demo");
}

- (void)didShareCards:(SFSObject *)obj {
  //  NSLog(@"didShareCards");
    
    labelTiv.text = @"7";
    int count = [obj getInt:@"cnt"];
    
    for (Card *card in arrayCards) {
        [card removeFromSuperview];
    }
    
    [arrayCards removeAllObjects];
    
    for (int i = 0; i < 8; i++) {
        Card *card = [[Card alloc] initWithFrame:CGRectMake(350 - 53, -200, 106, 143)];
        [card setBack:YES];
        [viewTable addSubview:card];
        [arrayCards addObject:card];
        
        card.delegate = self;
    }
    for (int i = 1; i <= count; i++) {
        int mast = [obj getInt:[NSString stringWithFormat:@"cm%d", i]];
        int type = [obj getInt:[NSString stringWithFormat:@"ct%d", i]];
     //   NSString *card_str = [Utils getCardMastAndType:mast Type:type];

        Card *card = [arrayCards objectAtIndex:i - 1];
        card.card_state = CardState_Center;
        [card setMast:mast Type:type];
        card.position = i;
        
        int distance = 50;
        int position_x = rand()%distance;
        int position_y = rand()%(distance/2);
        
        position_x = 350 - distance/2 + position_x;
        position_y = 250 - (distance/2)/2 + position_y;
        
        int angle = rand()%10;
        float radius = angle*(M_PI/180);
        
        float delay = i * 0.1;
        
        if (i >= 4) {
            delay +=0.25;
        }
        
        [card moveTo:CGPointMake(position_x, position_y) Angle:radius inTime:0.7 Delay:delay];
    }
    @try
    {
        if ([obj containsKey:@"tot1"])
        {
            [lastScoreSquere setScore1:[obj getInt:@"tot1"] setScore2:[obj getInt:@"tot2"] team1:[obj getUtfString:@"abbr1"] team2:[obj getUtfString:@"abbr2"]];
            lastScoreSquere.hidden = NO;
            
        } else {
            lastScoreSquere.hidden = YES;
        }
    } @catch(NSException *e){
    }
}

- (void)showUnUsedCards:(SFSObject *)obj {
    for (Card *card in arrayCards) {
        [card removeFromSuperview];
    }
    
    [arrayCards removeAllObjects];
    int count = [obj getInt:@"cnt"];
    int j = 0;
    for (int i = 0; i < count; i++) {
        BOOL used = [obj getBool:[NSString stringWithFormat:@"cu%d", i+1]];
        if (!used) {
            Card *card = [[Card alloc] initWithFrame:CGRectMake(350 - 53,548, 106, 143)];
            [viewTable addSubview:card];
            [arrayCards addObject:card];
            card.delegate = self;
            int mast = [obj getInt:[NSString stringWithFormat:@"cm%d", i+1]];
            int type = [obj getInt:[NSString stringWithFormat:@"ct%d", i+1]];
            [card setMast:mast Type:type];
            card.position = j;
           
            j++;
        }
        
    }
     [self rebuildCards];
}

- (void)didPlayerMoved:(SFSObject *)obj {
   // NSLog(@"didPlayerMoved");
    
    SFSObject *obj_card = [obj getSFSObject:@"card"]; // the card object beeng thrown
    int seat = [Utils transformSeat:[obj getInt:@"wt"]]; // who is throwing the card
    int type = [obj_card getInt:@"t"]; // the value of card being thrown
    int mast = [obj_card getInt:@"m"]; // the suit of card being thrown
    int position = [obj getInt:@"pos"]; // server known card position in player hands
    
      //  User *user = [arrayUsers objectAtIndex:seat - 1];
    
   // [user showToolTipWithState:ToolTipState_MastAndTipe Title:nil andCards:nil];
    Card *card = nil;
    BOOL rebuild = NO;
    
    if (seat == [Utils transformSeat:[Globals sharedGlobals].mySeat]) {
        if (!selfclick) {
            card = [self getCardWithPosition:position];
            rebuild = YES;
            [arrayCards removeObject:card];
            card.enabled = NO;
            [viewTable bringSubviewToFront:card];
        }
        selfclick = NO;
    } else {
        card = [[Card alloc] initWithFrame:CGRectMake(0, 0, 106, 143)];
        [viewTable addSubview:card];
        switch (seat) {
            case 1: {
                card.center = CGPointMake(viewTable.frame.size.width/2, viewTable.frame.size.height);
            }
                break;
            case 2: {
                card.center = CGPointMake(0, viewTable.frame.size.height/2);

            }
                break;
            case 3: {
                card.center = CGPointMake(viewTable.frame.size.width/2, 0);

            }
                break;
            case 4: {
                card.center = CGPointMake(viewTable.frame.size.width, viewTable.frame.size.height/2);

            }
                break;
            default:
                break;
        }
       // card.center = user.center;
        [card setMast:mast Type:type];
    }

    if (!card) {
        return;
    }

    card.delegate = self;
    card.card_state = CardState_Center;
    int distance = 10;
    int diff = 50;
    
    int position_x = rand()%distance;
    int position_y = rand()%distance;
    
    position_x = 350 + position_x;
    position_y = 200 + position_y;

    switch (seat) {
        case 1: {
            position_y += diff;
        }
            break;
        case 2: {
            position_x -= diff;
        }
            break;
        case 3: {
            position_y -= diff;
        }
            break;
        case 4: {
            position_x += diff;
        }
            break;
        default:
            break;
    }
    int angle = rand()%20;
    
    float radius;
    
    if (seat%2 == 0) {
        radius = angle*(M_PI/180) + M_PI_2;
    } else {
        radius = angle*(M_PI/180);
    }
    
    BOOL way = rand()%2;
    
    [card moveTo:CGPointMake(position_x, position_y) Angle:way ? radius : -radius inTime:0.4 Delay:0];
    [self sound:@"drop"];

    if (![arrayCartsOnTable containsObject:card]) {
        [self addCardToList:card];
    }
    
    if (rebuild) {
        [self rebuildCards];
    }
}

- (void)didKickStart:(SFSObject *)obj {
    
    int wt = [obj getInt:@"wt"];
    int t = [obj getInt:@"t"];
    int trwt = [Utils transformSeat:wt];
    User *user = [arrayUsers objectAtIndex:trwt - 1];
    [user displayKickTimer:t];
//    this["ub"+trwt].displayKickTimer(t, trwt);
    
}

- (void)didFinishAnimation:(Card *)card {
    //NSLog(@"didFinishAnimationnnnnnnnnnnnnnnnnnnnnnnnn");

    switch (card.card_state) {
        case CardState_Center: {
            if (take_card_seat != -1) {
              //  User *user = [arrayUsers objectAtIndex:take_card_seat - 1];
                

                while (arrayCartsOnTable.count) {
                    Card *card = [arrayCartsOnTable firstObject];
                    [arrayCartsOnTable removeObject:card];
                    CGPoint takeToPoint;

                    switch (take_card_seat) {
                        case 1: {
                            takeToPoint = CGPointMake(viewTable.frame.size.width/2, viewTable.frame.size.height);
                        }
                            break;
                        case 2: {
                            takeToPoint = CGPointMake(0, viewTable.frame.size.height/2);
                            
                        }
                            break;
                        case 3: {
                            takeToPoint = CGPointMake(viewTable.frame.size.width/2, 0);
                            
                        }
                            break;
                        case 4: {
                            takeToPoint = CGPointMake(viewTable.frame.size.width, viewTable.frame.size.height/2);
                            
                        }
                            break;
                        default:
                            break;
                    }
                    [card moveTo:takeToPoint Angle:0 inTime:0.5 Delay:0.5];
                    card.card_state = CardState_Remove;
                    card.delegate = self;
                }
                
                take_card_seat = -1;
            } else {
                if (card.position != 8) {
                    break;
                }
                for (int i = 0; i < arrayCards.count; i++) {
                    Card *card = [arrayCards objectAtIndex:i];
                    card.card_state = CardState_Bottom;
                    int distance = 50;
                    int position_x = rand()%distance;
                
                    position_x = 350 - distance/2 + position_x;
                    
                    float delay = card.position * 0.1;
                    
                    [card moveTo:CGPointMake(position_x, 900) Angle:0 inTime:0.4 Delay:delay];
                }
            }
        }
            break;
        case CardState_Bottom: {
            if (card.position != 8) {
                break;
            }

            int angle_distance = -4;
            int angle_start_position = 4*angle_distance + angle_distance/2;
            
            for (int i = 0; i < arrayCards.count; i++) {
                Card *card = [arrayCards objectAtIndex:i];
                card.card_state = CardState_Show;
                [card setBack:NO];

                float angle_radians = M_PI/180*(angle_start_position - card.position*angle_distance);
                
                int radius = 700;
                
                float positionY = 1180 - radius*cos(angle_radians);
                float positionX = 350 + radius*sin(angle_radians);
                
                [card moveTo:CGPointMake(positionX, positionY) Angle:angle_radians inTime:0.4 Delay:0];
            }
        }
            break;
        case CardState_Show: {
            card.card_state = CardState_None;
        }
            break;
        case CardState_Remove: {
            [arrayCartsOnTable removeObject:card];
            [card removeFromSuperview];
        }
            break;
        default:
            break;
    }
}

- (void)didClickSelf:(Card*)card {
    if (!selfclick) {
        for (int i = 0; i < arrayCards.count; i++) {
            Card *otherCard = [arrayCards objectAtIndex:i];
            otherCard.enabled = NO;
        }
        int distance = 10;
        int diff = 50;
        
        int position_x = rand()%distance;
        int position_y = rand()%distance;
        
        position_x = 350 + position_x;
        position_y = 200 + position_y;
        position_y += diff;
        
        int angle = rand()%20;
        
        float radius;
        
        radius = angle*(M_PI/180);
        
        BOOL way = rand()%2;
        
        [card moveTo:CGPointMake(position_x, position_y) Angle:way ? radius : -radius inTime:0.4 Delay:0];
        [self sound:@"drop"];
        
        [arrayCards removeObject:card];
        card.enabled = NO;
        [viewTable bringSubviewToFront:card];
        
        [self rebuildCards];
        
        if (![arrayCartsOnTable containsObject:card]) {
            [self addCardToList:card];
        }
        BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
        [[GameManager sharedManager:productionBool] playRequestMast:card.mast Type:card.type];
    }
    
    selfclick = YES;

}

- (void)didUpdateBazarState:(SFSObject *)params {
   // NSLog(@"didUpdateBazarState");
    
//    removePopups();
    viewBazar.hidden = YES;
    viewExtraComplete.hidden = YES;
    viewRecontra.hidden = YES;
    [user1 hideKickTimer];
    [user2 hideKickTimer];
    [user3 hideKickTimer];
    [user4 hideKickTimer];

    lastbazar.hidden = YES;
    currentpoints.hidden = YES;
//    this.bt_knock.visible = true;
    
    if ([params containsKey:@"fp"])
    {
        int fp = [Utils transformSeat:[params getInt:@"fp"]];
        [user1 ShowSA:fp == 1];
        [user2 ShowSA:fp == 2];
        [user3 ShowSA:fp == 3];
        [user4 ShowSA:fp == 4];
        switch (fp) {
            case 1: {
                turnPipView.center = CGPointMake(viewTable.frame.size.width/2, viewTable.frame.size.height - 150);
            }
                break;
            case 2: {
                turnPipView.center = CGPointMake(80, viewTable.frame.size.height/2);
            }
                break;
            case 3: {
                turnPipView.center = CGPointMake(viewTable.frame.size.width/2, 80);
                
            }
                break;
            case 4: {
                turnPipView.center = CGPointMake(viewTable.frame.size.width - 80, viewTable.frame.size.height/2);
            }
                break;
            default:
                break;
        }
    }
   
    
    int wt = [params getInt:@"wt"];
//    FlexGlobals.topLevelApplication.wt = wt;
//    lasttiv = params.getInt("_lt")+1;
//    mymast = params.getInt("xm"+Globals.mySeat);
    
    [self glow:wt];
    
   // int trwt = [Utils transformSeat:wt];
   
    turnPipView.hidden = NO;
    
//    CardsAnim.$().disableCardActions = true;
//    CardsAnim.$().lighthing(Utils.transformSeat(wt));
    
    int tmptrseat;
    int contrer = [params getInt:@"contr"] ;
    int recontrer = [params getInt:@"recontr"];
    for(int i = 1; i <= 4; ++i)
    {
        tmptrseat = [Utils transformSeat:i];
        if (tmptrseat == 1) {
            
         //   viewBazar.hidden = YES;
        }
        User *user = [arrayUsers objectAtIndex:tmptrseat-1];
        [user setBazarData:[params getInt:[NSString stringWithFormat:@"xm%d", i]]
                      Type:[params getInt:[NSString stringWithFormat:@"xt%d", i]]
                   Contrer:contrer==i
                 Recontrer:recontrer==i];
    }
    
    int lacto = [params getInt:@"lacto"];
    int lacti = [params getInt:@"lacti"];
    
    if(lacti > 0)     {
        if(lacti == 3)
            [self showBazarTip:[params getInt:@"contr"] Lacti:lacti Params:params];
        else if(lacti == 4)
            [self showBazarTip:[params getInt:@"recontr"] Lacti:lacti Params:params];
        else
            [self showBazarTip:lacto Lacti:lacti Params:params];
    }
    
    int lwt = [params getInt:@"lwt"];
    kontra_active = false;
    if(lwt > 0)
        kontra_active = (lwt%2 != [Globals sharedGlobals].mySeat%2);
    
    
    if([Globals sharedGlobals].mySeat == wt)
    {
        lastMast = [params getInt:@"_lm"];
        lastTiv = [params getInt:@"_lt"];
//        this.hideContraButton();
        if(contrer > 0)
        {
            // если мы контрили
            if (contrer%2 == [Globals sharedGlobals].mySeat%2)
            {
                [self BazarWindowRecontra:false LastMast:lastMast LastType:lastTiv];
            }
            else
            {
                [self BazarWindowRecontra:true LastMast:lastMast LastType:lastTiv];
            }
        }
        else
        {
            [self BazarWindow:kontra_active LastTiv:lastTiv];
        }
        
    }
    else
    {
        viewBazar.hidden = YES;
        viewExtraComplete.hidden = YES;
        viewRecontra.hidden = YES;
        
        //Внеочередная контра
        if (kontra_active)
        {
            if(contrer > 0)
            {
                if(contrer%2 != [Globals sharedGlobals].mySeat%2) // реконтра
                    buttonContra.hidden = NO;
                else
                    buttonContra.hidden = YES;
            }
            else
                buttonContra.hidden = NO;
            
        }
        else
            buttonContra.hidden = YES;
    }
}


- (void)glow:(int)seat {
   // [glow.layer removeAllAnimations];
   // glow = nil;
    
    if (seat != 0) {
        seat = [Utils transformSeat:seat];
        CGRect frame;
        CGAffineTransform transform = CGAffineTransformMakeRotation(0);
        UIImage *image = [UIImage imageNamed:@"table_top"];
        switch (seat) {
            case 1: {
                frame = CGRectMake(230,547, 564.0, 100);
                image = [UIImage imageNamed:@"table_bottom"];
                
            }
                break;
            case 2: {
                frame = CGRectMake(152, 235.0, 102, 335);
                //  transform = CGAffineTransformMakeRotation(M_PI);
                image = [UIImage imageNamed:@"table_left"];
            }
                break;
            case 3: {
                frame = CGRectMake(228, 156, 568.0, 100);
                //   transform = CGAffineTransformMakeRotation(M_PI);
                
            }
                break;
            case 4: {
                frame = CGRectMake(770, 233, 101, 338);
                image = [UIImage imageNamed:@"table_right"];
                transform = CGAffineTransformMakeRotation(-M_PI/720);
                
            }
                break;
                
            default:
                break;
        }

        glow.frame = frame;
        glow.image = image;
        glow.transform = transform;
        glow.alpha = 0;
        [UIView animateWithDuration:1.5
                              delay:1.5f
                            options: UIViewAnimationOptionRepeat | UIViewAnimationOptionAutoreverse
                         animations:^{
                             glow.alpha = 1.0;
                         }
                         completion:^(BOOL fin) {
                         //    NSLog(@"end of animation");
                         }];
        
        
        [self.view bringSubviewToFront:viewTable];
        
        [self.view bringSubviewToFront:viewBazar];
        [self.view bringSubviewToFront:viewRecontra];
        [self.view bringSubviewToFront:viewExtraComplete];
        [self.view bringSubviewToFront:lastRukDialog];
        [self.view bringSubviewToFront:scoreView];
        [self.view bringSubviewToFront:viewGetChip];
        [self.view bringSubviewToFront:lostView];

    } else {
        glow.alpha = 0;
    }
    
}

- (void)didUpdateGameState:(SFSObject *)params {
    if (!readyButton.hidden) {
        readyButton.hidden = YES;
    }
    turnPipView.hidden = YES;
//    removePopups();
//    
    [user1 hideKickTimer];
    [user2 hideKickTimer];
    [user3 hideKickTimer];
    [user4 hideKickTimer];
//    this.bt_knock.visible = true;
    
    if ([params containsKey:@"last"])
    {
        [lastbazar setMast:[params getInt:@"mast"] tiv:[params getInt:@"tiv"] contra:[params getBool:@"contra"] recontra:[params getBool:@"recontra"]];
//        lastbazar.setData([params getInt:@"mast"], [params getInt:@"tiv"], [params getBool:@"contra"], [params getBool:@"recontra"]);
        lastbazar.hidden = NO;
        buttonContra.hidden = YES;
    }
    @try
    {
        [currentpoints setScore1:[params getInt:@"score1"] setScore2:[params getInt:@"score2"] team1:[params getUtfString:@"abbr1"] team2:[params getUtfString:@"abbr2"]];
        currentpoints.hidden = NO;

//        currentpoints.setData([params getInt:@"score1"], [params getInt:@"score2"], [params getUtfString:@"abbr1"], [params getUtfString:@"abbr2"]);
//        currentpoints.visible = true;
    }
    @catch(NSException *e)
    {
        
    }
    
//    sa1.visible = false;
//    sa2.visible = false;
//    sa3.visible = false;
//    sa4.visible = false;
    
    int wt = [params getInt:@"wt"];
//    FlexGlobals.topLevelApplication.wt = wt;
    [self glow:wt];

    if (wt == [Globals sharedGlobals].mySeat) {
        NSString *complete = @"";
        if ([params containsKey:@"b1"]) {
            complete = currentLunguage.TERZ;
        }
        if ([params containsKey:@"b2"]) {
            if (complete.length > 0) {
                complete = [complete stringByAppendingString:@" + 50"];
            } else {
                complete = @"50";
            }
        }
        if ([params containsKey:@"b3"]) {
            if (complete.length > 0) {
                complete = [complete stringByAppendingString:@" + 100"];
            } else {
                complete = @"100";
            }
        }
        if ([params containsKey:@"b4"]) {
            if (complete.length > 0) {
                complete = [complete stringByAppendingString:@" + 4X"];
            } else {
                complete = @"4X";
            }
        }
        
        if (![complete isEqualToString:@""]) {
            viewExtraComplete.hidden = NO;
            labelExtraComplete.text = [NSString stringWithFormat:@"%@ %@",currentLunguage.Announce,complete];
        }
//            Confirm(extra,0);
        
//        CardsAnim.$().disableCardActions = false;
    } else {
//        CardsAnim.$().disableCardActions = true;
    }
    
    //Turn on/off appropriate lightning
//    CardsAnim.$().lighthing(Utils.transformSeat(wt));
}

- (void)didTakeAllCards:(int)winner {
    //NSLog(@"didTakeAllCards");

    take_card_seat = winner;
}

- (void)didSetPermitted {
    
   // NSLog(@"didSetPermitted");
    SFSObject *pcards = [Globals sharedGlobals].permitted;
    NSArray *ma = [pcards getIntArray:@"ma"];
    NSArray *ta = [pcards getIntArray:@"ta"];
    
    for (Card *card in arrayCards) {
        
        BOOL permited = false;
        for(int i = 0; i < ma.count; ++i) {
            
            if ([[ma objectAtIndex:i] integerValue] == card.mast && [[ta objectAtIndex:i] integerValue] == card.type) {
                permited = true;
                
                break;
            }
        }
        
        if (permited) {
            card.enabled = YES;

        } else {
            card.enabled = NO;

        }
    }
}

- (void) rebuildCards {
    int angle_distance = -4;
    float half = (float)(arrayCards.count)/2;
    float angle_start_position = half*angle_distance - angle_distance/2;
    
    
    for (int i = 0; i < arrayCards.count; i++) {
        
        if (i < arrayCards.count) {
            Card *card = [arrayCards objectAtIndex:i];
            card.enabled = NO;
            
            float angle_radians = M_PI/180*(angle_start_position - i*angle_distance);
            
            int radius = 700;
            
            float positionY = 1180 - radius*cos(angle_radians);
            float positionX = 350 + radius*sin(angle_radians);
            
            [card moveTo:CGPointMake(positionX, positionY) Angle:angle_radians inTime:0.5 Delay:0];
        }
    }
}

- (void)sayExtraTip:(SFSObject *)obj {
    if ([obj containsKey:@"from"]) {
        int seat = [Utils transformSeat:[obj getInt:@"from"]];
        NSString *complete = @"";
        if ([obj containsKey:@"terz"]) {
            complete = currentLunguage.TERZ;
        }
        if ([obj containsKey:@"_50"]) {
            if (complete.length > 0) {
                complete = [complete stringByAppendingString:@" + 50"];
            } else {
                complete = @"50";
            }
        }
        if ([obj containsKey:@"_100"]) {
            if (complete.length > 0) {
                complete = [complete stringByAppendingString:@" + 100"];
            } else {
                complete = @"100";
            }
        }
        if ([obj containsKey:@"_4x"]) {
            if (complete.length > 0) {
                complete = [complete stringByAppendingString:@" + 4X"];
            } else {
                complete = @"4X";
            }
        }
        if ([obj containsKey:@"blot"]) {
            complete = currentLunguage.BELOTE;
        }
        if ([obj containsKey:@"reblot"]) {
            complete = currentLunguage.REBELOTE;
        }
       // [self sound:@"tooltip"];
        if (![complete isEqualToString:@""]) {
            User *user = [arrayUsers objectAtIndex:seat -1];
            [user showToolTipWithState:ToolTipState_Speak Title:complete step:0 andCards:nil];
        }
        

    }
}

- (void)showExtraTip:(SFSObject *)obj {
    int seat = [Utils transformSeat:[obj getInt:@"from"]];
    NSString *str = @"";
    NSString *plus = @"";
    int step = -1;
    if([obj getBool:@"b1"])
    {
        str = currentLunguage.TERZ;
        plus = @"+";

    }
    if([obj getBool:@"b11"])
    {
        str = [NSString stringWithFormat:@"%@%@%@",str,plus,str];
        step = 3;
        plus = @"+";

    }
    if([obj getBool:@"b2"])
    {
        if ([str length]>0) {
            step = 3;
        }
        str = [NSString stringWithFormat:@"%@%@50",str,plus];
        plus = @"+";

    }
    if([obj getBool:@"b21"])
    {
        str = [NSString stringWithFormat:@"%@%@50",str,plus];
        step = 4;
    }
    if([obj getBool:@"b3"])
    {
        if ([str length]>0) {
            step = 3;
        }
        str = [NSString stringWithFormat:@"%@%@100",str,plus];
        plus = @"+";

    }
    if([obj getBool:@"b4"])
    {
        if ([obj getBool:@"b1"]) {
            step = 3;
        }
        if ([obj getBool:@"b2"]) {
            step = 4;
        }

        str = [NSString stringWithFormat:@"%@%@4X",str,plus];
        plus = @"+";

    }
    if([obj getBool:@"b41"])
    {
        str = [NSString stringWithFormat:@"%@%@4X",str,plus];
        plus = @"+";

        step = 4;
    }
    
    User *user = [arrayUsers objectAtIndex:seat - 1];
 
//    SFSObject *test = [[SFSObject alloc]init];
//    SFSObject *card = [[SFSObject alloc]init];
//    NSArray *ma = [[NSArray alloc]initWithObjects:@"4",@"4",@"4", nil];
//    NSArray *ta = [[NSArray alloc]initWithObjects:@"4",@"5",@"6", nil];
//    [card putIntArray:@"ma" value:ma];
//    [card putIntArray:@"ta" value:ta];
//
//    [test putSFSObject:@"cards" value:card];
//    
//    str = @"Terz + 4X";
//    step = 4;
    [user showToolTipWithState:ToolTipState_ShowAndSpeak Title:str step:step andCards:[obj getSFSObject:@"cards"]];
    //this.sndToolTip.play();
    
    //playSound('tooltip');
    
//    Sounds.$().playToolTip();
//    
//    o.putUtfString("title",str);
//    ExtraTooltip(this["et"+seat]).setData(o);
//    this["et"+seat].alpha=0;
//    Fade(seat,this["et"+seat],fader_show_extra_pause);
}

- (void)scoreboardHandler {
    [self scoreButtonAction:nil];
    selected_mast.enabled = YES;
    selected_mast = nil;
    [user1 hideKickTimer];
    [user2 hideKickTimer];
    [user3 hideKickTimer];
    [user4 hideKickTimer];
    [self glow:0];
    for (int i = 0; i < 4; i++) {
        User *user = [arrayUsers objectAtIndex:i];
        [user setBazarData:0 Type:0 Contrer:0 Recontrer:0];
    }
}


- (IBAction)showExtraCompleteButtonAction:(id)sender {
    viewExtraComplete.hidden = YES;
    SFSObject *obj = [SFSObject newInstance];
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] SendWithName:@"sayExtraComplete" Object:obj];
}

- (IBAction)dontShowExtraCompleteButtonAction:(id)sender {
    viewExtraComplete.hidden = YES;
}

- (IBAction)volumeButtonAction:(id)sender {
    BOOL vol = [[NSUserDefaults standardUserDefaults] boolForKey:@"volume"];
    [[NSUserDefaults standardUserDefaults] setBool:!vol forKey:@"volume"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    if (vol) {
        [volumeButton setBackgroundImage:[UIImage imageNamed:@"Sound_off.png"] forState:UIControlStateNormal];
    } else {
        [volumeButton setBackgroundImage:[UIImage imageNamed:@"Sound_on.png"] forState:UIControlStateNormal];

    }
    
}

- (void) showBazarTip:(int)from Lacti:(int)action Params:(SFSObject*)params {
    int seat = [Utils transformSeat:from];
    
    switch(action)
    {
        case 1: {
            User *user = [arrayUsers objectAtIndex:seat - 1];
            [user showBazarToolTipWithMast:[params getInt:@"_lm"] Type:[params getInt:@"_lt"]];
            [self sound:@"tooltip"];

        }
            break;
        case 2: {
            User *user = [arrayUsers objectAtIndex:seat - 1];
            [user showToolTipWithState:ToolTipState_Speak Title:currentLunguage.PASS step:0 andCards:nil];
        }
            break;
        case 3: {
            User *user = [arrayUsers objectAtIndex:seat - 1];
            [user showToolTipWithState:ToolTipState_Speak Title:currentLunguage.CONTRA step:0 andCards:nil];
        }
            break;
        case 4: {
            User *user = [arrayUsers objectAtIndex:seat - 1];
            [user showToolTipWithState:ToolTipState_Speak Title:currentLunguage.RECONTRA step:0 andCards:nil];
        }
            break;
    }
}

- (void) BazarWindowRecontra:(BOOL)recontra LastMast:(int)lm LastType:(int)lt {
    
    viewRecontra.hidden = NO;
    buttonRecontra.enabled = recontra;
    labelRecontra.text = [NSString stringWithFormat:@"%d",lt];
    recontraMastImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"contra%d.png",lm]];
}

- (void) BazarWindow:(BOOL)value LastTiv:(int)lt {
    labelTiv.text = [NSString stringWithFormat:@"%d", lt + 1];
    viewBazar.hidden = NO;
    buttonKontra.enabled = value;
}

- (Card*) getCardWithPosition:(int)pos {
    for (Card *card in arrayCards) {
        if (card.position == pos) {
            return card;
        }
    }
    
    return nil;
}

- (void) addCardToList:(Card*)card {
    if (arrayCartsOnTable.count > 3) {
        [arrayCartsOnTableBuffer addObject:card];
    } else {
        [arrayCartsOnTable addObject:card];
        
        if (arrayCartsOnTableBuffer.count) {
            while (arrayCartsOnTableBuffer.count) {
                Card *card = [arrayCartsOnTableBuffer firstObject];
                
                [arrayCartsOnTable addObject:card];
                [arrayCartsOnTableBuffer removeObject:card];
            }
        }
    }
}

- (IBAction)lastRukButtonAction:(id)sender {
    if ([Globals sharedGlobals].last_ruk_object) {
        SFSObject *lastRuk = [[Globals sharedGlobals].last_ruk_object getSFSObject:@"cards"];
        [lastRukDialog setData:lastRuk];
    }
}

- (IBAction)scoreButtonAction:(id)sender {
    if ([Globals sharedGlobals].game_score) {
        SFSObject *score = [Globals sharedGlobals].game_score;
        [scoreView setData:score];
    }
    
}

- (void)showNewGameOffer:(SFSObject *)obj {
    [self sound:@"ready_bell"];
    [Globals sharedGlobals].game_score = nil;
    lastbazar.hidden = YES;
    currentpoints.hidden = YES;


    NewGameOfferView *newGameOfferView = [[NewGameOfferView alloc] initWithData:obj myName:self.userNameStr imageUrl:self.avatarUrl level:self.levelStr playAgain:YES];
    [self.view addSubview:newGameOfferView];
}

- (void)showWinnerDeclaration:(SFSObject *)obj {
    [Globals sharedGlobals].game_score = nil;
    lastbazar.hidden = YES;
    currentpoints.hidden = YES;
    lastScoreSquere.hidden = YES;
    [self.navigationController popViewControllerAnimated:YES];

    NewGameOfferView *newGameOfferView = [[NewGameOfferView alloc] initWithData:obj myName:self.userNameStr imageUrl:self.avatarUrl level:self.levelStr playAgain:NO];
    [[[[self.navigationController viewControllers] objectAtIndex:0] view] addSubview:newGameOfferView];
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
    //NSLog(@"productPurchased");
    viewGetChip.hidden = YES;
    
}
- (void)failed:(NSString *)urlStr {
    //NSLog(@"failed");
    viewGetChip.hidden = YES;
    
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
        
        
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"BlotClub"
                                                          message:@"Payment failed"
                                                         delegate:self
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    }
}

- (void)updateMyself:(SFSObject *)me {
    self.levelStr = [NSString stringWithFormat:@"%d",[[me getUtfString:@"fslevel"] integerValue]];
    level.text = self.levelStr;
    
    NSInteger maxVal = [[me getUtfString:@"fsedge"] integerValue];
    NSInteger minVal = [[me getUtfString:@"fslowedge"] integerValue];
    NSInteger currentVal = [[me getUtfString:@"fspoints"]integerValue];
    self.edgeStr = [NSString stringWithFormat:@"%d/%d",currentVal,maxVal];
    
    if (maxVal >10000) {
        self.edgeStr = [NSString stringWithFormat:@"%0.1fk/%0.1fk",(float)currentVal/1000,(float)maxVal/1000];
    }
    currentAndMaxEdge.text = self.edgeStr;
    
    self.proggesWidth = (currentVal - minVal)*(viewProgress.frame.size.width)/(maxVal - minVal);
    UIView *currentProggesView = [[UIView alloc] initWithFrame:CGRectMake(1, 1, self.proggesWidth - 2, viewProgress.frame.size.height -2)];
    currentProggesView.backgroundColor = [UIColor colorWithRed:(221/255.0) green:(184/255.0) blue:(31/255.0) alpha:1];
    [viewProgress addSubview:currentProggesView];
    
    self.creditsVal = [NSString stringWithFormat:@"%d",[[me getUtfString:@"fscredits"] integerValue]];;
    credits.text = self.creditsVal;
}

- (void)lunguageButtonAction:(id)sender {
    UIButton *lunguage = (UIButton *)sender;
    [currentLunguage setLunguage:lunguage.tag];
    [self setLunguage];
        [[NSUserDefaults standardUserDefaults] setInteger:lunguage.tag forKey:@"Language"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    lunguageView.hidden = YES;

}

- (IBAction)chooseLunguageButtonAction:(id)sender {
    lunguageView.hidden = NO;
}

- (void)setLunguage {
    [readyButton setTitle:currentLunguage.READY forState:UIControlStateNormal];
    [buttonContra setTitle:currentLunguage.CONTRA forState:UIControlStateNormal];
    labelLavelText.text = currentLunguage.LEVEL;
    labelGetChips.text  = currentLunguage.GET_CHIPS;
    lastScoreSquere.labelScore.text = currentLunguage.TOTAL_SCORE;
    labelTurn.text = currentLunguage.turn;
    [buttonExit setTitle:currentLunguage.EXIT forState:UIControlStateNormal];
    [buttonKontra setTitle:currentLunguage.CONTRA forState:UIControlStateNormal];
    [buttonPass setTitle:currentLunguage.PASS forState:UIControlStateNormal];
    [buttonXod setTitle:currentLunguage.MOVE forState:UIControlStateNormal];
    [buttonRecontra setTitle:currentLunguage.RECONTRA forState:UIControlStateNormal];
    [buttonNO setTitle:currentLunguage.disagree forState:UIControlStateNormal];
    [buttonYes setTitle:currentLunguage.agree forState:UIControlStateNormal];
    labelRate.text = [NSString stringWithFormat:@"%@: %d",currentLunguage.RATE,rateValue];

}

@end