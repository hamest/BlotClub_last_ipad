//
//  Card.m
//  Connector
//
//  Created by Hamest Tadevosyan on 1/31/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "Card.h"

@interface Card () {
    NSString *imageName;
    UIImage *imageBack;

    enum CardState card_state;
}

- (void) selfClick:(id)sender;
- (void) setCardImage:(UIImage*)image;

@end


@implementation Card


@synthesize delegate = _delegate;
@synthesize mast = _mast;
@synthesize type = _type;
@synthesize position = _position;
@synthesize blocked = _blocked;
@synthesize back = _back;
@synthesize card_state = _card_state;

- (id) initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.position = 0;
        self.blocked = false;
        self.back = false;
        self.enabled = false;
        _card_state = CardState_None;
        
        imageBack = [UIImage imageNamed:@"Back.png"];
        
        imageName = @"";
        
        [self addTarget:self action:@selector(selfClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void) setMast:(int)mast_ Type:(int)type_ {
    self.mast = mast_;
    self.type = type_;
    
    switch (type_) {
        case 1: {
            imageName = @"7";
        }
            break;
        case 2: {
            imageName = @"8";
        }
            break;
        case 3: {
            imageName = @"9";
        }
            break;
        case 4: {
            imageName = @"10";
        }
            break;
        case 5: {
            imageName = @"Jack";
        }
            break;
        case 6: {
            imageName = @"Quin";
        }
            break;
        case 7: {
            imageName = @"King";
        }
            break;
        case 8: {
            imageName = @"Ace";
        }
            break;
        default:
            break;
    }
    
    switch (mast_) {
        case 1: { // xach
            imageName = [imageName stringByAppendingString:@"_Clubs"];
        }
            break;
        case 2: { // sirt
            imageName = [imageName stringByAppendingString:@"_Hearts"];
        }
            break;
        case 3: { // qyap
            imageName = [imageName stringByAppendingString:@"_Diamonds"];
        }
            break;
        case 4: { // ghar
            imageName = [imageName stringByAppendingString:@"_Spades"];
        }
            break;
            
        default:
            break;
    }
    
    imageName = [imageName stringByAppendingString:@".png"];
    
    if (!self.back) {
        UIImage *image = [UIImage imageNamed:imageName];
        [self setCardImage:image];
    } else {
        [self setCardImage:imageBack];
    }
}

- (void) setBack:(BOOL)back {
    _back = back;
    
    if (self.back) {
        [self setCardImage:imageBack];
    } else {
        UIImage *image = [UIImage imageNamed:imageName];
        [self setCardImage:image];
    }
}

- (void) moveTo:(CGPoint)point Angle:(float)angle inTime:(NSTimeInterval)time Delay:(NSTimeInterval)delay {
    CGPoint center = self.center;
    center.x +=1;
    center.y +=1;

    [UIView animateWithDuration:delay
                     animations:^{
                         self.center = center;
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:time
                                          animations:^{
                                              self.center = point;
                                              self.transform = CGAffineTransformMakeRotation(angle);
                                          } completion:^(BOOL finished) {
                                              if ([self.delegate respondsToSelector:@selector(didFinishAnimation:)]) {
                                                  [self.delegate didFinishAnimation:self];
                                              }
                                          }];
                     }];
}

- (NSString*)toString {
    NSArray *suit = @[@"xach", @"sirt", @"qyap", @"ghar"];
    NSArray *val = @[@"7", @"8", @"9", @"10", @"V", @"D", @"K", @"T"];
    
    return [NSString stringWithFormat:@"%@%@ (pos:%d)", suit[self.mast-1], val[self.type -1], self.position];
}

- (void) selfClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didClickSelf:)]) {
        [self.delegate didClickSelf:self];
    }
}

- (void) setCardImage:(UIImage*)image {
    [self setBackgroundImage:image forState:UIControlStateNormal];
    [self setBackgroundImage:image forState:UIControlStateDisabled];
}

@end