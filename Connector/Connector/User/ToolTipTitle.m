//
//  ToolTipTitle.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/7/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "ToolTipTitle.h"

@interface ToolTipTitle () {
    UILabel *labelTitle;
    int seat;
}

@end

@implementation ToolTipTitle

- (id) initWithSeat:(int)seat_ {
    self = [super initWithFrame:CGRectMake(0, 0, 0, 50)];
    
    if (self) {
        // Initialization code
        
        CGRect frame = self.frame;
        seat = seat_;
        switch (seat) {
            case 1: {
                frame.origin.y = -130;
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
                frame.origin.x = -110;
            }
                break;
            default:
                break;
        }
        
        self.frame = frame;
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 13.0f;
        
        labelTitle = [[UILabel alloc] init];
        labelTitle.backgroundColor = [UIColor clearColor];
        labelTitle.font = [UIFont systemFontOfSize:25];
        labelTitle.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:labelTitle];
    }
    
    return self;
}

- (void) setTitle:(NSString*)title {
    if (!self.hidden) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:2.5];
        
        return;
    }
    
    self.hidden = NO;
    
    NSDictionary *attributes = @{NSFontAttributeName:labelTitle.font};
    CGSize size = [title sizeWithAttributes:attributes];
    CGRect frame = self.frame;
    frame.size.width = size.width + 20;
    if (seat == 4) {
        frame.origin.x = -(frame.size.width + 10);
    }
    
    self.frame = frame;
   // frame = self.frame;
   // frame.origin.x = 0;
   // frame.origin.y = 0;
    labelTitle.frame = self.bounds;
    labelTitle.text = title;
    
    [self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:2.5];
}

@end