//
//  LastBazarView.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/28/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "LastBazarView.h"

@interface LastBazarView() {
    UIImageView *imageViewMast;
    UILabel *labelTitle;
    UILabel *labelContra;
}

@end

@implementation LastBazarView

- (id)init
{
    CGRect frame = CGRectMake(820, 160, 80, 40);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(32, 10, 23, 20)];
        labelTitle.backgroundColor = [UIColor clearColor];
        labelTitle.font = [UIFont boldSystemFontOfSize:20];
        labelTitle.textAlignment = NSTextAlignmentLeft;
        labelTitle.textColor = [UIColor whiteColor];
        [self addSubview:labelTitle];

        
        labelContra = [[UILabel alloc] initWithFrame:CGRectMake(55, 19, 23, 10)];
        labelContra.backgroundColor = [UIColor clearColor];
        labelContra.font = [UIFont boldSystemFontOfSize:10];
        labelContra.textAlignment = NSTextAlignmentCenter;
        labelContra.textColor = [UIColor whiteColor];
        [self addSubview:labelContra];
        
        imageViewMast = [[UIImageView alloc] initWithFrame:CGRectMake(4, 8, 24, 24)];
        [self addSubview:imageViewMast];
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

-(void)setMast:(int)mast tiv:(int)tiv contra:(BOOL)contra recontra:(BOOL)recontra {
    imageViewMast.image = [UIImage imageNamed:[NSString stringWithFormat:@"contra%d.png",mast]];
    labelTitle.text = [NSString stringWithFormat:@"%d",tiv];
    NSString *contraText = @"";
    if (contra) {
        if (recontra) {
            contraText = @"K R";
        } else {
            contraText = @"K";
        }
    }
    labelContra.text = contraText;
}

@end
