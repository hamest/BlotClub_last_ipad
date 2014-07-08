//
//  ViewController.h
//  Connector
//
//  Created by Wayne Helman on 12-03-09.
//  Copyright (c) 2012 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "GameManager.h"
#import "CustomAlertView.h"
#import "MKStore/MKStoreManager.h"
#import "GetChipView.h"



@interface ViewController : UIViewController <ISFSEvents, GameManagerDelegate, CustomAlertViewDelegate, MKStoreKitDelegate,GetChipDelegate>
{
	GameManager *gameManager;
    
    IBOutlet UITextView *debugLog;
    
    IBOutlet UIButton *disconnectBtn;
    
    IBOutlet UIButton *loginBtn;
    IBOutlet UIButton *logoutBtn;
    
    IBOutlet UILabel *userName;
    IBOutlet UIView *avatarView;
    IBOutlet UILabel *level;
    IBOutlet UILabel *currentAndMaxEdge;
    IBOutlet UIView *viewProgress;
    IBOutlet UILabel *credits;
}

- (IBAction)login:(id)sender;
- (IBAction)disconnect:(id)sender;

- (IBAction)logout:(id)sender;
- (IBAction)tabelsButtonAction:(id)sender;
- (IBAction)profClubButtonAction:(id)sender;


@end
