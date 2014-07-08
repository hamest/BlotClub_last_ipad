//
//  ToolTipBazar.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/7/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "ToolTipBazar.h"

@interface ToolTipBazar () {
    UILabel *labelTitle;
    UIImageView *imageViewMast;
    
    int seat;
}

@end

@implementation ToolTipBazar

- (id) initWithSeat:(int)seat_ {
    self = [super initWithFrame:CGRectMake(0, 0, 132, 75)];
    
    if (self) {
        // Initialization code
        
        CGRect frame = self.frame;
        seat = seat_;
        switch (seat) {
            case 1: {
                frame.origin.y = -150;
            }
                break;
            case 2: {
                frame.origin.x = 120;
            }
                break;
            case 3: {
                frame.origin.y = 90;
            }
                break;
            case 4: {
                frame.origin.x = -142;
            }
                break;
            default:
                break;
        }
        
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 13.0f;
        
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, 66, 75)];
        labelTitle.backgroundColor = [UIColor clearColor];
        labelTitle.font = [UIFont systemFontOfSize:25];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:labelTitle];

        imageViewMast = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 52, 52)];
        [self addSubview:imageViewMast];
    }
    
    return self;
}

- (void) setMast:(int)mast_ Type:(int)type_ {
    if (!self.hidden) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:2.5];
        
        return;
    }
    
    self.hidden = NO;
    
    imageViewMast.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",mast_]];
    labelTitle.text = [NSString stringWithFormat:@"%d", type_];
    [self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:2.5];
}

@end