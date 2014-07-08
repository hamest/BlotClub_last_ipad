//
//  LastRukDialogView.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/19/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "LastRukDialogView.h"
//#import <SFS2XAPIIOS/SmartFox2XClient.h>
#import "Utils.h"

#define cardHeight 143
#define cardWidth 106

@interface LastRukDialogView() {
    UIView *dialog;
    UILabel *titleLabel;
}

@end

@implementation LastRukDialogView

- (id)init
{
    CGRect frame = CGRectMake(0, 0, 1024, 768);
    self = [super initWithFrame:frame];
    if (self) {
       
        self.hidden = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];

        UIView *borderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 400, 400)];
        borderView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:5.55f];
        borderView.center = self.center;
        [self addSubview:borderView];
        
        
        
        dialog = [[UIView alloc]initWithFrame:CGRectMake(10, 8, 380, 384)];
        dialog.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.85];
        [borderView addSubview:dialog];
        
        UIView *headerViwa = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 380, 40)];
        headerViwa.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:184.0f/255.0f blue:31.0f/255.0f alpha:1.0f];
        [dialog addSubview:headerViwa];
        
        titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 250, 25)];
        titleLabel.font = [UIFont boldSystemFontOfSize:24];
        [headerViwa addSubview:titleLabel];
        titleLabel.textColor = [UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake(headerViwa.frame.size.width - 20 - 10, 10, 20, 20);
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"closeScoreButton.png"] forState:UIControlStateNormal];
        cancelButton.tag = 0;
        [headerViwa addSubview:cancelButton];
        
        
    }
    return self;
}

- (void)setData:(SFSObject *)data {
    self.hidden = NO;
    for (UIView *subView in dialog.subviews) {
        if ([subView isKindOfClass:[Card class]]) {
            [subView removeFromSuperview];
        }
    }
    titleLabel.text = [Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].LAST_HAND;

    int winner = [Utils transformSeat:[data getInt:@"winner"]];
    int starter = [Utils transformSeat:[data getInt:@"starter"]];
    NSArray *ta = [data getIntArray:@"ta"];
    NSArray *ma = [data getIntArray:@"ma"];
        
    [self performSelector:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] afterDelay:5.0];
    
    float angle = 0;
    int k = 0;
    for (int j = starter; j < starter + 4; j++) {
        int i = j;
        if (j > 4) {
            i = j - 4;
        }
        
        //  int i = starter;
        
        CGRect frame;
        CGRect pipFrame;
        
        switch (i) {
            case 1: {
                frame = CGRectMake((dialog.frame.size.width - cardWidth)/2, dialog.frame.size.height - cardHeight - 10, cardWidth, cardHeight);
                pipFrame = CGRectMake(-10, cardHeight - 20, 28, 28);
            }
                break;
                
            case 2: {
                frame = CGRectMake(30, (dialog.frame.size.height - cardHeight)/2 + 20, cardWidth, cardHeight);
                pipFrame = CGRectMake(-10, cardHeight - 20, 28, 28);
            }
                break;
            case 3: {
                frame = CGRectMake((dialog.frame.size.width - cardWidth)/2, 50, cardWidth, cardHeight);
                pipFrame = CGRectMake(cardWidth - 10, - 10, 28, 28);
            }
                break;
            case 4: {
                frame = CGRectMake(dialog.frame.size.width - cardWidth - 30, (dialog.frame.size.height - cardHeight - 30)/2 + 20, cardWidth, cardHeight);
                pipFrame = CGRectMake(cardWidth - 10, - 10, 28, 28);
            }
                break;
            default:
                break;
        }
        
        Card *card = [[Card alloc] initWithFrame:frame];
        //[card setBack:YES];
        [dialog addSubview:card];
        int mast = [[ma objectAtIndex:k] intValue];
        int type = [[ta objectAtIndex:k] intValue];
        
        [card setMast:mast Type:type];
        //card.card_state = CardState_Center;
        if (i%2==0) {
            angle = 90;
        } else {
            angle = 0;
        }
        float radius = angle*(M_PI/180);
        card.transform = CGAffineTransformMakeRotation(radius);
        if (i == winner) {
            UIImageView * pipich = [[UIImageView alloc]initWithFrame:pipFrame];
            pipich.image = [UIImage imageNamed:@"winner-pip.png"];
            [card addSubview:pipich];
        }
        k++;
        
        //  angle = angle + 90;
        
        // [arrayCards addObject:card];
        
        // card.delegate = self;
    }

}

- (void)cancelButtonAction:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    self.hidden = YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
