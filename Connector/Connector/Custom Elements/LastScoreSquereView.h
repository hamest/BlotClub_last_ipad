//
//  LastScoreSquereView.h
//  Connector
//
//  Created by Hamest Tadevosyan on 2/28/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LastScoreSquereView : UIView

@property (nonatomic, strong) UILabel *labelScore;
-(void)setScore1:(int)score1 setScore2:(int)score2 team1:(NSString *)team1 team2:(NSString *)team2;

@end
