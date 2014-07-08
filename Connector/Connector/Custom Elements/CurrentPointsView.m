//
//  CurrentPointsView.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/28/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "CurrentPointsView.h"

@interface CurrentPointsView() {
    UILabel *labelTeam1;
    UILabel *labelTeam2;
    UILabel *labelScore1;
    UILabel *labelScore2;
}

@end

@implementation CurrentPointsView

- (id)init
{
    CGRect frame =  CGRectMake(910, 160, 90, 40);
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        labelTeam1 = [[UILabel alloc] initWithFrame:CGRectMake(5, 2, 32, 18)];
        labelTeam1.backgroundColor = [UIColor clearColor];
        labelTeam1.font = [UIFont systemFontOfSize:13];
       // labelTeam1.textAlignment = NSTextAlignmentLeft;
        labelTeam1.textColor = [UIColor whiteColor];
        [self addSubview:labelTeam1];
        
        
        labelTeam2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 20, 32, 18)];
        labelTeam2.backgroundColor = [UIColor clearColor];
        labelTeam2.font = [UIFont systemFontOfSize:13];
       // labelTeam2.textAlignment = NSTextAlignmentLeft;
        labelTeam2.textColor = [UIColor whiteColor];
        [self addSubview:labelTeam2];
        
        labelScore1 = [[UILabel alloc] initWithFrame:CGRectMake(40, 2, 45, 18)];
        labelScore1.backgroundColor = [UIColor clearColor];
        labelScore1.font = [UIFont boldSystemFontOfSize:13];
      //  labelScore1.textAlignment = NSTextAlignmentRight;
        labelScore1.textColor = [UIColor whiteColor];
        [self addSubview:labelScore1];
        
        
        labelScore2 = [[UILabel alloc] initWithFrame:CGRectMake(40, 20, 45, 18)];
        labelScore2.backgroundColor = [UIColor clearColor];
        labelScore2.font = [UIFont boldSystemFontOfSize:13];
        //labelScore2.textAlignment = NSTextAlignmentRight;
        labelScore2.textColor = [UIColor whiteColor];
        [self addSubview:labelScore2];

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
-(void)setScore1:(int)score1 setScore2:(int)score2 team1:(NSString *)team1 team2:(NSString *)team2 {
    labelTeam1.text = [NSString stringWithFormat:@"%@",team1];
    labelTeam2.text = [NSString stringWithFormat:@"%@",team2];
    labelScore1.text = [NSString stringWithFormat:@"%d",score1];
    labelScore2.text = [NSString stringWithFormat:@"%d",score2];

}


@end
