//
//  LoginViewController.h
//  Connector
//
//  Created by Hamest Tadevosyan on 3/3/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameManager.h"


@interface LoginViewController : UIViewController <GameManagerDelegate> {
    GameManager *gameManager;
    BOOL productionBool;
}

@end
