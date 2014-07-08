//
//  ScoreTableViewCell.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/21/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "ScoreTableViewCell.h"

@implementation ScoreTableViewCell

- (id)initWithType:(int)type Mast:(int)mast
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MyIdentifier"];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView = [UIView new] ;
        self.selectedBackgroundView = [UIView new];
        
        _score1Label = [[UILabel alloc] init];
        self.score1Label.frame = CGRectMake(100, 0, 140, 20);
        [self.score1Label setTextColor:[UIColor blackColor]];
        [self.score1Label setBackgroundColor:[UIColor clearColor]];
        [self.score1Label setFont:[UIFont systemFontOfSize:11.0f]];
        self.score1Label.textColor = [UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
      //  [self.score1Label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.score1Label];
        
        _score2Label = [[UILabel alloc] init];
        self.score2Label.frame = CGRectMake(240, 0, 140, 20);
        [self.score2Label setTextColor:[UIColor blackColor]];
        [self.score2Label setBackgroundColor:[UIColor clearColor]];
        [self.score2Label setFont:[UIFont systemFontOfSize:11.0f]];
        self.score2Label.textColor = [UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
       // [self.score2Label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.score2Label];
        
        
        _contraLabel = [[UILabel alloc] init];
        self.contraLabel.frame = CGRectMake(50, 0, 15, 30);
        [self.contraLabel setTextColor:[UIColor blackColor]];
        [self.contraLabel setBackgroundColor:[UIColor clearColor]];
        [self.contraLabel setFont:[UIFont systemFontOfSize:11.0f]];
       // [self.contraLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.contraLabel];
        self.contraLabel.text = @"K";
        self.contraLabel.hidden = YES;

        
        _reContreLabel = [[UILabel alloc] init];
        self.reContreLabel.frame = CGRectMake(65, 0, 15, 30);
        [self.reContreLabel setTextColor:[UIColor blackColor]];
        [self.reContreLabel setBackgroundColor:[UIColor clearColor]];
        [self.reContreLabel setFont:[UIFont systemFontOfSize:11.0f]];
       // [self.reContreLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addSubview:self.reContreLabel];
        self.reContreLabel.text = @"R";
        self.reContreLabel.hidden = YES;

        
        if (type != 0 && mast != 0) {
            labelType = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 20, 25)];
            labelType.backgroundColor = [UIColor clearColor];
            labelType.font = [UIFont boldSystemFontOfSize:11.0f];
            labelType.textAlignment = NSTextAlignmentCenter;
            labelType.text = [NSString stringWithFormat:@"%d",type];
            labelType.textColor = [UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
            
            [self.contentView addSubview:labelType];
            
            imageViewMast = [[UIImageView alloc] initWithFrame:CGRectMake(20, 3, 20, 20)];
            imageViewMast.image = [UIImage imageNamed:[NSString stringWithFormat:@"contra%d.png",mast]];
            [self addSubview:imageViewMast];

        }
        
        [self.contentView setTranslatesAutoresizingMaskIntoConstraints:NO];

        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
