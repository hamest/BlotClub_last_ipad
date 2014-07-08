//
//  User.h
//  Connector
//
//  Created by Hamest Tadevosyan on 2/3/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SFS2XAPIIOS/SmartFox2XClient.h>


enum ToolTipState {
    ToolTipState_Speak = 0,
    ToolTipState_MastAndTipe,
    ToolTipState_ShowAndSpeak,
};

@interface User : UIView {
}

@property (nonatomic, strong) SFSUser *sfsUser;
@property (nonatomic, strong) UILabel *contraLabel;

- (id)initWithFrame:(CGRect)frame andTag:(int)tag;
- (void) hideKickTimer;
- (void)displayKickTimer:(int)time;
- (void) ShowSA:(BOOL)show;
- (void) setBazarData:(int)mast Type:(int)type Contrer:(int)contrer Recontrer:(int)recontrer;
- (void)showToolTipWithState:(enum ToolTipState)state Title:(NSString *)title step:(int)step andCards:(SFSObject *)cards;
- (void) showBazarToolTipWithMast:(int)mast Type:(int)type;

@end