//
//  ToolTipView.h
//  Connector
//
//  Created by Hamest Tadevosyan on 2/7/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SFS2XAPIIOS/SmartFox2XClient.h>
#import "Card.h"

@interface ToolTipView : UIView

- (id) initWithSeat:(int)seat_;
-(void)setText:(NSString *)title step:(int)step andCards:(SFSObject *)cardsObjj;

@end
