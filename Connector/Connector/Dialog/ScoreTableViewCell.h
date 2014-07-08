//
//  ScoreTableViewCell.h
//  Connector
//
//  Created by Hamest Tadevosyan on 2/21/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreTableViewCell : UITableViewCell {
    UILabel *labelType;
    UIImageView *imageViewMast;
}


- (id)initWithType:(int)type Mast:(int)mast;

@property (nonatomic, strong) UILabel *score1Label;
@property (nonatomic, strong) UILabel *score2Label;
@property (nonatomic) int mast;
@property (nonatomic) int type;
@property (nonatomic, strong) UILabel *contraLabel;
@property (nonatomic, strong) UILabel *reContreLabel;






@end
