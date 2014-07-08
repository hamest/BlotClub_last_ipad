//
//  GetChipView.m
//  BlotClub
//
//  Created by Hamest Tadevosyan on 4/10/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "GetChipView.h"

@interface GetChipView() {
    UIView *dialogView;
}

@end

@implementation GetChipView

- (id)init
{
    CGRect frame = CGRectMake(0, 0, 1024, 768);
    self = [super initWithFrame:frame];
    if (self) {
        dialogView = [[UIView alloc]initWithFrame:CGRectMake(238, 275, 549, 254)];
        dialogView.backgroundColor = [UIColor blackColor];
        [self addSubview:dialogView];
        
        self.hidden = YES;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        UILabel *getChits = [[UILabel alloc]initWithFrame:CGRectMake(9, 0, 318, 62)];
        getChits.font = [UIFont boldSystemFontOfSize:29];
        getChits.text = [Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].GET_CHIPS;
        getChits.textColor = [UIColor colorWithRed:221.0f/255.0f green:184.0f/255.0f blue:31.0f/255.0f alpha:1.0f];
        [dialogView addSubview:getChits];
        [self createButton:1000];
        [self createButton:2500];
        [self createButton:5500];
        [self createButton:15500];
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake(dialogView.frame.size.width - 20 - 10, 20, 20, 20);
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"closeScoreButton.png"] forState:UIControlStateNormal];
        cancelButton.tag = 0;
        [dialogView addSubview:cancelButton];
        
        self.transparent = [[UIView alloc]initWithFrame:CGRectMake(0, 53, dialogView.frame.size.width, dialogView.frame.size.height -53)];
        self.transparent.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.9];
        [dialogView addSubview:self.transparent];
        
        self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.indicator.frame = CGRectMake((self.transparent.frame.size.width - 24)/2, (self.transparent.frame.size.height - 44)/2, 24, 24);
        [self.transparent addSubview:self.indicator];
        
        UILabel *initialization = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, self.transparent.frame.size.width, 20)];
        initialization.text = @"Initialization store";
        initialization.textColor = [UIColor whiteColor];
        initialization.textAlignment = NSTextAlignmentCenter;
        [self.transparent addSubview:initialization];
        
    }
    return self;
}

- (void)createButton:(int)tag {
    CGRect frame;
    int chipCount = 1;
    int distans = 20;
    float xPosition = 33;
    float yPosition = 41;
    switch (tag) {
        case 1000:{
            frame = CGRectMake(10, 63, 125, 176);
        }
            break;
        case 2500:{
            frame = CGRectMake(145, 63, 125, 176);
            chipCount = 2;
         //   distans = 20;
            xPosition = 24;
        }
            break;

        case 5500:{
            frame = CGRectMake(280, 63, 125, 176);
            chipCount = 3;
          //  distans = 0;
            xPosition = 14;

        }
            break;

        case 15500:{
            frame = CGRectMake(415, 63, 125, 176);
            chipCount = 4;
        //    distans = 0;
            xPosition = 5;

        }
            break;

        default:
            break;
    }
    UIButton *button= [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(buyChipsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame = frame;
    button.tag = tag;
    button.backgroundColor = [UIColor colorWithRed:61.0f/255.0f green:19.0f/255.0f blue:11.0f/255.0f alpha:1.0f];
    
    [dialogView addSubview:button];
    
    for (int i = 0; i < chipCount; i++) {
        UIImageView *chip = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chip.png"]];
        chip.frame = CGRectMake(xPosition + i*distans, yPosition, 59, 60);
        [button addSubview:chip];
    }
    UIView *foother = [[UIView alloc]initWithFrame:CGRectMake(0, 125, 125, 51)];
    foother.backgroundColor = [UIColor colorWithRed:145.0f/255.0f green:40.0f/255.0f blue:15.0f/255.0f alpha:1.0f];

    [button addSubview:foother];
    
    UIImageView *rightStar = [[UIImageView alloc]initWithFrame:CGRectMake(10, 17, 17, 17)];
    rightStar.image = [UIImage imageNamed:@"star.png"];
    [foother addSubview:rightStar];
    
    UIImageView *leftStar = [[UIImageView alloc]initWithFrame:CGRectMake(98, 17, 17, 17)];
    leftStar.image = [UIImage imageNamed:@"star.png"];
    [foother addSubview:leftStar];
    
    UILabel *chipValue = [[UILabel alloc]initWithFrame:CGRectMake(rightStar.frame.origin.x + rightStar.frame.size.width, 0, foother.frame.size.width - 2*(rightStar.frame.origin.x + rightStar.frame.size.width), foother.frame.size.height)];
    chipValue.text = [NSString stringWithFormat:@"%d",tag];
    chipValue.textAlignment = NSTextAlignmentCenter;
    chipValue.font = [UIFont boldSystemFontOfSize:22];
    chipValue.textColor = [UIColor colorWithRed:221.0f/255.0f green:184.0f/255.0f blue:31.0f/255.0f alpha:1.0f];
    [foother addSubview:chipValue];

}

- (void)buyChipsButtonAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",button.tag] forKey:@"amount"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.delegate buyChipsWithTag:button.tag];
}

- (void)cancelButtonAction:(id)sender {
    self.hidden = YES;
    if (self.indicator.isAnimating) {
        [self.indicator stopAnimating];
    }
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
