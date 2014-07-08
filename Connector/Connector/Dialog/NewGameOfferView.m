//
//  NewGameOfferView.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/26/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "NewGameOfferView.h"
#import "GameManager.h"
#import "LBAsycImageView.h"

@interface NewGameOfferView() {
     UILabel *name;
}

@end

@implementation NewGameOfferView

- (id)initWithData:(SFSObject *)data myName:(NSString *)myName imageUrl:(NSURL *)url level:(NSString *)level playAgain:(BOOL)playAgain
{
    CGRect frame = CGRectMake(0, 0, 1024, 768);
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        UIView *gameOfferView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 483, 281)];
        gameOfferView.center = self.center;
        [self addSubview:gameOfferView];
        gameOfferView.backgroundColor = [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.56f];
        
        NSString *pl1 = [data getUtfString:@"pl1"];
        NSString *pl2 = [data getUtfString:@"pl2"];
        NSString *pl3 = [data getUtfString:@"pl3"];
        NSString *pl4 = [data getUtfString:@"pl4"];
        
        int winnerteam = [data getInt:@"winnerteam"];
        
        NSString *title = [Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].LOSERS;
        if (winnerteam == 0) {
            if ([myName isEqualToString:pl1] || [myName isEqualToString:pl3]) {
                title = [Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].WINNERS;
            }
        } else {
            if ([myName isEqualToString:pl2] || [myName isEqualToString:pl4]) {
                title = [Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].WINNERS;
            }
        }
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(13, 13,gameOfferView.frame.size.width - 26 , 96)];
        titleLabel.text = title;
        titleLabel.font = [UIFont boldSystemFontOfSize:52];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.backgroundColor = [UIColor colorWithRed:191.0f/255.0f green:1.0f/255.0f blue:2.0f/255.0f alpha:1.0f];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [gameOfferView addSubview:titleLabel];
        
        LBAsyncImageView *coverImage = [[LBAsyncImageView alloc] initWithFrame:CGRectMake(13, titleLabel.frame.size.height + titleLabel.frame.origin.y + 13, 70, 70)];
        [coverImage loadImageFromURL:url];
        coverImage.layer.borderWidth = 1;
        coverImage.layer.borderColor = [UIColor whiteColor].CGColor;
        [gameOfferView addSubview:coverImage];

        name = [[UILabel alloc]initWithFrame:CGRectMake(coverImage.frame.size.width + 2*coverImage.frame.origin.x, coverImage.frame.origin.y, 180, 30)];
        name.font = [UIFont boldSystemFontOfSize:12];
        name.textColor = [UIColor whiteColor];
        name.text = myName;
        [gameOfferView addSubview:name];
        
        UIView *pointView = [[UIView alloc]initWithFrame:CGRectMake(gameOfferView.frame.size.width - 100 - 13, coverImage.frame.origin.y, 100, 70)];
        pointView.layer.borderWidth = 1;
        pointView.layer.borderColor = [UIColor colorWithRed:221.0f/255.0f green:184.0f/255.0f blue:31.0f/255.0f alpha:1.0f].CGColor;
        [gameOfferView addSubview:pointView];
        
        UILabel *pointLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, pointView.frame.size.width, 40)];
        pointLabel.font = [UIFont boldSystemFontOfSize:46];
        pointLabel.textColor = [UIColor colorWithRed:221.0f/255.0f green:184.0f/255.0f blue:31.0f/255.0f alpha:1.0f];
        pointLabel.text = [NSString stringWithFormat:@"%d",125];
        pointLabel.textAlignment = NSTextAlignmentCenter;
        [pointView addSubview:pointLabel];
        
        UILabel *levelLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, pointLabel.frame.size.height +pointLabel.frame.origin.y, pointView.frame.size.width, 20)];
        levelLabel.font = [UIFont boldSystemFontOfSize:13];
        levelLabel.textColor = [UIColor whiteColor];
        NSString *lavevStr = [Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].LEVEL;
        levelLabel.text = [NSString stringWithFormat:@"%@ %@",lavevStr,level];
        levelLabel.textAlignment = NSTextAlignmentCenter;
        [pointView addSubview:levelLabel];

       
        UIButton *playButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [playButton addTarget:self action:@selector(playButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        playButton.frame = CGRectMake(13, gameOfferView.frame.size.height - 55 - 13, 223, 55);
        playButton.backgroundColor = [UIColor colorWithRed:96.0f/255.0f green:27.0f/255.0f blue:14.0f/255.0f alpha:1.0f];
        playButton.tintColor = [UIColor whiteColor];
        playButton.titleLabel.font = [UIFont systemFontOfSize:24];
        [playButton setTitle:[Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].PLAY_AGAIN forState:UIControlStateNormal];
        
        CGRect frame = CGRectMake(playButton.frame.size.width + playButton.frame.origin.x + 11, gameOfferView.frame.size.height - 55 - 13, 223, 55);
         if (playAgain) {
            [gameOfferView addSubview:playButton];
             
         } else {
             frame = CGRectMake((gameOfferView.frame.size.width - 223)/2, gameOfferView.frame.size.height - 55 - 13, 223, 55);
         }
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = frame;
        cancelButton.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:184.0f/255.0f blue:31.0f/255.0f alpha:1.0f];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:24];
        cancelButton.tintColor = [UIColor colorWithRed:96.0f/255.0f green:27.0f/255.0f blue:14.0f/255.0f alpha:1.0f];
        [cancelButton setTitle:[Translate sharedManagerLunguage:[[NSUserDefaults standardUserDefaults] integerForKey:@"Language"]].EXIT_GAME forState:UIControlStateNormal];
        [gameOfferView addSubview:cancelButton];


    }
    
    return self;
}

- (void)playButtonAction:(id)sender {
    BOOL productionBool = [[NSUserDefaults standardUserDefaults] boolForKey:@"productionBool"];
    [[GameManager sharedManager:productionBool] ready];
    [self removeFromSuperview];
}

- (void)cancelButtonAction:(id)sender {
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoBackNotification" object:nil];

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
