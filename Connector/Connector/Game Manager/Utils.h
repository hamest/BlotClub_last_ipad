//
//  Utils.h
//  Connector
//
//  Created by Hamest Tadevosyan on 1/31/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Globals.h"


@interface Utils : NSObject

+ (void) alignHorizontalCenter:(CGPoint)target;
+ (int) transformSeat:(int)seat;
+ (NSString*) getCardMastAndType:(int)mast Type:(int)type;
+ (NSString*) getFullName:(NSString*)name;
+ (BOOL) exitWithAlert;

@end