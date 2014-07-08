//
//  Utils.m
//  Connector
//
//  Created by Hamest Tadevosyan on 1/31/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "Utils.h"


@implementation Utils


+ (void) alignHorizontalCenter:(CGPoint)target {
//    target.x = (FlexGlobals.topLevelApplication.width - target.width)/2;
}

+ (int) transformSeat:(int)seat {
    int arr[7] = {2, 3, 4, 1, 2, 3, 4};

    return arr[seat - [Globals sharedGlobals].mySeat + 3];
}

+ (NSString*) getCardMastAndType:(int)mast Type:(int)type {
    NSString *mast_str;
    NSString *type_str;
    
    switch(mast) {
        case 1: mast_str = @"clubs"; 	break;
        case 2: mast_str = @"hearts"; 	break;
        case 3: mast_str = @"diamonds"; 	break;
        case 4: mast_str = @"spades"; 	break;
    }
    
    switch(type) {
        case 1: type_str = @"7"; 	break;
        case 2: type_str = @"8"; 	break;
        case 3: type_str = @"9"; 	break;
        case 4: type_str = @"10"; 	break;
        case 5: type_str = @"jack"; 	break;
        case 6: type_str = @"queen"; break;
        case 7: type_str = @"king"; 	break;
        case 8: type_str = @"ace"; 	break;
    }			
    
    return [NSString stringWithFormat:@"%@_%@", mast_str, type_str];
}

+ (NSString*) getFullName:(NSString*)name {
    return [NSString stringWithFormat:@"%@%@", [Globals sharedGlobals].CMD_PFX, name];
}

+ (BOOL) exitWithAlert {
    NSString *state = [Globals sharedGlobals].state;
    if ([state isEqualToString:@"bazarState" ]|| [state isEqualToString:@"gameState"]) {
        return YES;
    } else {
        return NO;
    }
}

@end