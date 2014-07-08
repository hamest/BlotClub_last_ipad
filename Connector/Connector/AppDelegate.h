//
//  AppDelegate.h
//  BlotClub
//
//  Created by Hamest Tadevosyan on 1/29/14.
//  Copyright (c) 2014 Fluger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Facebook.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, FBDialogDelegate, FBSessionDelegate, FBRequestDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) Facebook *facebook;

- (void)fbLogin;
- (void)fbLogout;

@end
