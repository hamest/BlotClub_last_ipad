//
//  ToolTipView.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/7/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "ToolTipView.h"



@interface ToolTipView() {
    UILabel *labelTitle;
    int seat;

}

@end

#define cardHeight 71
#define cardWidth 53

@implementation ToolTipView



- (id) initWithSeat:(int)seat_ {

    self = [super initWithFrame:CGRectMake(0, 0, 250, 100)];
    
    if (self) {
        // Initialization code
        
      //  CGRect frame = self.frame;
        seat = seat_;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 13.0f;
        
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 200, 20)];
        labelTitle.backgroundColor = [UIColor clearColor];
        labelTitle.font = [UIFont systemFontOfSize:20];
        labelTitle.textAlignment = NSTextAlignmentLeft;
        
        [self addSubview:labelTitle];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setText:(NSString *)title step:(int)step andCards:(SFSObject *)cardsObj {
    if (!self.hidden) {
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:5];
        
        return;
    }
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[Card class]]) {
            [subView removeFromSuperview];
        }
    }
    
    self.hidden = NO;
    labelTitle.text = title;

    NSArray *ma = [cardsObj getIntArray:@"ma"];
    NSArray *ta = [cardsObj getIntArray:@"ta"];
    
    CGRect frame = self.frame;
    int count = [ma count];
    switch (count) {
        case 3: {
            frame.size.width = 125;
        }
             break;
        case 4: {
            frame.size.width = 150;
        }
             break;
        case 5: {
            frame.size.width = 175;
        }
        case 6: {
            frame.size.width = 200;
        }
         break;
        case 7: {
            frame.size.width = 225;
        }
             break;
        case 8: {
            frame.size.width = 250;
        }
            break;
            
        default:
            break;
    }
    switch (seat) {
        case 1: {
            frame.origin.y = -170;
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
            frame.origin.x = -self.frame.size.width +20;
        }
            break;
        default:
            break;
    }
    
    self.frame = frame;

    
    
    
    float dist = 0;

    for (int i = 0; i < count; i++) {
        if (i == step) {
            dist = 40;
        }
        Card *card = [[Card alloc] initWithFrame:CGRectMake(5 + i * (cardWidth*2/5) +dist, 25, cardWidth, cardHeight)];
        [self addSubview:card];
        int mast = [[ma objectAtIndex:i] intValue];
        int type = [[ta objectAtIndex:i] intValue];
        
        [card setMast:mast Type:type];
        
        [self addSubview:card];
    }
    [self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:5];

    
}




@end
