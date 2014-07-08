//
//  GameViewController.h
//  Connector
//
//  Created by Hamest Tadevosyan on 2/3/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameManager.h"
#import "MKStore/MKStoreManager.h"
#import "GetChipView.h"



@interface GameViewController : UIViewController <GameManagerDelegate, CardDelegate, MKStoreKitDelegate,GetChipDelegate> {
    
    IBOutlet UIView *viewTable;
}

@property (nonatomic) BOOL isProff;
@property (nonatomic, strong) NSURL *avatarUrl;
@property (nonatomic, strong) NSString *userNameStr;
@property (nonatomic, strong) NSString *levelStr;
@property (nonatomic, strong) NSString *edgeStr;
@property (nonatomic, strong) NSString* creditsVal;
@property (nonatomic) float proggesWidth;


@end
