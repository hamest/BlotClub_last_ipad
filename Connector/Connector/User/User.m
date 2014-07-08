//
//  User.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/3/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "User.h"
#import "Utils.h"
#import "LBAsycImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "ToolTipView.h"
#import "ToolTipTitle.h"
#import "ToolTipBazar.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>


@interface User () {
    LBAsyncImageView *imageViewUser;
    UIImageView *imageViewSA;
    UILabel *userName;
    UIActivityIndicatorView *indicatorView;
    UIView *transparent;
    ToolTipView *viewToolTip;
    ToolTipTitle *toolTipTitle;
    ToolTipBazar *toolTipBazar;
    
    UIView *bazarView;
    UIImageView *mastView;
    UILabel *labelType;
    
    int lastMast;
    int currentTime;
    SystemSoundID mySound;


}

@property (nonatomic, strong) AVAudioPlayer *theAudio;


@end


@implementation User


@synthesize sfsUser = _sfsUser;


- (id)initWithFrame:(CGRect)frame andTag:(int)tag
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        imageViewUser = [[LBAsyncImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        [imageViewUser setImage:[UIImage imageNamed:@"UknownUser.png"]];
        [self addSubview:imageViewUser];
      //  [self setBackgroundColor:[UIColor redColor]];
        
        _contraLabel = [[UILabel alloc]initWithFrame:CGRectMake(imageViewUser.frame.size.width - 27, 0, 27, 27)];
        self.contraLabel.backgroundColor = [UIColor whiteColor];
        self.contraLabel.textColor = [UIColor redColor];
        self.contraLabel.font = [UIFont boldSystemFontOfSize:20];
        self.contraLabel.textAlignment = NSTextAlignmentCenter;
        self.contraLabel.hidden = YES;
        [imageViewUser addSubview:self.contraLabel];

        userName = [[UILabel alloc]initWithFrame:CGRectMake(0, 65, 200, 22)];
        userName.textColor = [UIColor whiteColor];
        userName.font = [UIFont boldSystemFontOfSize:20];
      //  userName.backgroundColor = [UIColor redColor];
        
        transparent = [[UIView alloc]initWithFrame:imageViewUser.frame];
        transparent.backgroundColor = [UIColor blackColor];
        transparent.alpha = 0.6;
        [imageViewUser addSubview:transparent];
        transparent.hidden = YES;
        
        indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatorView.center = CGPointMake(imageViewUser.frame.size.width/2, imageViewUser.frame.size.height/2);
        [transparent addSubview:indicatorView];
      //  indicatorView.hidden = YES;
        [indicatorView hidesWhenStopped];
        
        imageViewSA = [[UIImageView alloc] initWithFrame:CGRectMake(70, 10, 20, 20)];
        [imageViewSA setBackgroundColor:[UIColor yellowColor]];
        imageViewSA.hidden = YES;
        
        viewToolTip = [[ToolTipView alloc] init];
        viewToolTip.hidden = YES;
        [self addSubview:viewToolTip];
        
        toolTipTitle = nil;
        toolTipBazar = nil;
        
        bazarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        bazarView.backgroundColor = [UIColor colorWithRed:163.0f/255.0f green:10.0f/255.0f blue:5.0f/255.0f alpha:1.0f];
        bazarView.hidden = YES;
        
        mastView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 5, 20, 20)];
        [bazarView addSubview:mastView];
        
        labelType = [[UILabel alloc] initWithFrame:CGRectMake(bazarView.frame.size.height, 0, bazarView.frame.size.width - bazarView.frame.size.height, bazarView.frame.size.height)];
        labelType.font = [UIFont boldSystemFontOfSize:19];
        labelType.textColor = [UIColor whiteColor];
        [bazarView addSubview:labelType];
        
        [self addSubview:bazarView];
        
        switch (tag) {
            case 0: {
                userName.frame = CGRectMake(65, 80, 200, 22);
                bazarView.frame = CGRectMake(65, 40, bazarView.frame.size.width, bazarView.frame.size.height);
                imageViewUser.frame = CGRectMake(0, self.bounds.size.height - 60, 60, 60);
             //   self.backgroundColor = [UIColor redColor];
            }
                break;
            case 1: {
                userName.frame = CGRectMake(self.bounds.size.width - 200, 95, 200, 22);
                userName.textAlignment = NSTextAlignmentRight;
                imageViewUser.frame = CGRectMake(self.bounds.size.width - 60, 30, 60, 60);
                bazarView.frame = CGRectMake(self.bounds.size.width - bazarView.frame.size.width , 0, bazarView.frame.size.width, bazarView.frame.size.height);

             //   self.backgroundColor = [UIColor greenColor];

            }
                break;
            case 2: {
                imageViewUser.frame = CGRectMake(0, 0, 60, 60);
                bazarView.frame = CGRectMake(65, imageViewUser.frame.size.height - bazarView.frame.size.height, bazarView.frame.size.width, bazarView.frame.size.height);
                userName.frame = CGRectMake(65, imageViewUser.frame.origin.y, 200, 22);
                

              //  self.backgroundColor = [UIColor blueColor];

            }
                break;
            case 3: {
                imageViewUser.frame = CGRectMake(0, 30, 60, 60);
                bazarView.frame = CGRectMake(0, 0, bazarView.frame.size.width, bazarView.frame.size.height);
                userName.frame = CGRectMake(0, 95, 200, 22);

             //   self.backgroundColor = [UIColor yellowColor];

            }
                break;
            default:
                break;
        }
        [self addSubview:userName];


    }
    
    return self;
}

- (void) setSfsUser:(SFSUser *)sfsUser {
    _sfsUser = sfsUser;

    if (self.sfsUser == nil) {
        [imageViewUser setImage:[UIImage imageNamed:@"UknownUser.png"]];
        userName.text = @"";
    } else {
        SFSUserVariable *seat = [sfsUser getVariable:@"seat"];
        int value = [seat getIntValue];
        
        int userSeat = [Utils transformSeat:value];
        
        if (toolTipTitle) {
            [toolTipTitle removeFromSuperview];
        }
        
        toolTipTitle = [[ToolTipTitle alloc] initWithSeat:userSeat];
        toolTipTitle.hidden = YES;
        [self addSubview:toolTipTitle];

        if (toolTipBazar) {
            [toolTipBazar removeFromSuperview];
        }
        
        toolTipBazar = [[ToolTipBazar alloc] initWithSeat:userSeat];
        toolTipBazar.hidden = YES;
        [self addSubview:toolTipBazar];
        
        if (viewToolTip) {
            [viewToolTip removeFromSuperview];
        }
        
        viewToolTip = [[ToolTipView alloc] initWithSeat:userSeat];
        viewToolTip.hidden = YES;
        [self addSubview:viewToolTip];
                
        NSString *userNameStr = [self.sfsUser name];
        NSString *avatar = [[self.sfsUser getVariable:@"fsavatar"] getStringValue];
        if (avatar) {
            NSURL *avatarUrl = [[NSURL alloc]initWithString:avatar];
            [imageViewUser loadImageFromURL:avatarUrl];
            imageViewUser.layer.borderWidth = 1;
            imageViewUser.layer.borderColor = [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:1.0f].CGColor;
            [self addSubview:imageViewUser];
        } else {
            [imageViewUser setImage:[UIImage imageNamed:@"noimage.png"]];
            imageViewUser.layer.borderWidth = 1;
            imageViewUser.layer.borderColor = [UIColor colorWithRed:60.0f/255.0f green:60.0f/255.0f blue:60.0f/255.0f alpha:1.0f].CGColor;
            userNameStr = @"Blotiko";
        }
        
        
        
        userName.text = userNameStr;
    }
//
//    NSInteger levelVal = [[sfsObject getUtfString:@"fslevel"] integerValue];
//    level.text = [NSString stringWithFormat:@"Level %d",levelVal];
//    
//    NSInteger maxVal = [[sfsObject getUtfString:@"fsedge"] integerValue];
//    NSInteger minVal = [[sfsObject getUtfString:@"fslowedge"] integerValue];
//    NSInteger currentVal = [[sfsObject getUtfString:@"fspoints"]integerValue];
//    
//    minEdge.text = [NSString stringWithFormat:@"%d",minVal];
//    currentAndMaxEdge.text = [NSString stringWithFormat:@"%d/%d",currentVal,maxVal] ;
//    
//    float width = (currentVal - minVal)*viewProgress.frame.size.width/(maxVal - minVal);
//    UIView *currentProggesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, viewProgress.frame.size.height)];
//    currentProggesView.backgroundColor = [UIColor blueColor];
//    [viewProgress addSubview:currentProggesView];
//    
//    NSInteger creditsVal = [[sfsObject getUtfString:@"fscredits"] integerValue];
//    credits.text = [NSString stringWithFormat:@"%d",creditsVal];
}

- (void)displayKickTimer:(int)time {
    [self performSelector:@selector(showTimer) withObject:nil afterDelay:10];

}

- (void)showTimer {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    transparent.hidden = NO;
    [indicatorView startAnimating];
    [self sound:@"timer_loop"];
}

- (void)sound:(NSString *)soundName {
    BOOL vol = [[NSUserDefaults standardUserDefaults] boolForKey:@"volume"];
    if (vol) {
        NSString *path = [[NSBundle mainBundle] pathForResource:soundName ofType:@"mp3"];
        
        NSURL *fileURL = [[NSURL alloc] initFileURLWithPath: path];
        
        self.theAudio=[[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:NULL];
        self.theAudio.volume = 1.0;
        [self.theAudio prepareToPlay];
        [self.theAudio play];
    }
}

- (void) hideKickTimer {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [indicatorView stopAnimating];
    transparent.hidden = YES;
    [self.theAudio stop];
}

- (void) ShowSA:(BOOL)show {
    imageViewSA.hidden = !show;
}

- (void) setBazarData:(int)mast Type:(int)type Contrer:(int)contrer Recontrer:(int)recontrer {
    if (type > 7) {
        bazarView.hidden = NO;
        labelType.text = [NSString stringWithFormat:@"%d",type];
        mastView.image = [UIImage imageNamed:[NSString stringWithFormat:@"contra%d.png",mast]];
       // [self showBazarToolTipWithMast:mast Type:type];

    } else {
        bazarView.hidden = YES;
    }
    
    lastMast = mast;
    if (contrer > 0) {
        self.contraLabel.hidden = NO;
        self.contraLabel.text = @"K";
    } else {
        self.contraLabel.hidden = YES;
    }
    
//    if (recontrer > 0) {
//        self.contraLabel.hidden = NO;
//        self.contraLabel.text = @"R";
//    } else {
//     //   self.contraLabel.hidden = YES;
//    }
    
    if (type != 0) {
       // [self showToolTipWithState:ToolTipState_MastAndTipe Title:[NSString stringWithFormat:@"%d",type] andCards:nil];
    }
}

- (void)showToolTipWithState:(enum ToolTipState)state Title:(NSString *)title step:(int)step andCards:(SFSObject *)cards {
    [self toolTipSound:@"tooltip"];

    switch (state) {
        case ToolTipState_Speak:
        {
            [toolTipTitle setTitle:title];
        }
            break;
        case ToolTipState_MastAndTipe: {
            [self showBazarToolTipWithMast:lastMast Type:title];
        }
            break;
        case ToolTipState_ShowAndSpeak:
        {
            if (cards) {
                [viewToolTip setText:title step:step andCards:cards];
            } else {
                [toolTipTitle setTitle:title];
            }
        }
            break;
            
        default:
            break;
    }

    
}

- (void)toolTipSound:(NSString *)soundName {
    BOOL vol = [[NSUserDefaults standardUserDefaults] boolForKey:@"volume"];
    if (vol) {
        SystemSoundID myTipSound;
        
        NSString *soundPath = [[NSBundle mainBundle]
                               pathForResource:soundName ofType:@"mp3"];
        NSURL *soundURL = [NSURL fileURLWithPath:soundPath];
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &myTipSound);
        AudioServicesPlaySystemSound(myTipSound);
    }
}

- (void) showBazarToolTipWithMast:(int)mast Type:(int)type {
    [toolTipBazar setMast:mast Type:type];
}


@end