//
//  Card.h
//  Connector
//
//  Created by Hamest Tadevosyan on 1/31/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <Foundation/Foundation.h>

enum CardState {
    CardState_None = 0,
    CardState_Center,
    CardState_Bottom,
    CardState_Show,
    CardState_Remove
};

@protocol CardDelegate;



@interface Card : UIButton {
//    id<CardDelegate> _delegate;
}

@property (nonatomic, assign) id <CardDelegate> delegate;
@property (nonatomic, assign) int mast;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int position;
@property (nonatomic, assign) enum CardState card_state;

@property (nonatomic, assign) BOOL blocked;
@property (nonatomic, assign) BOOL back;

- (void) setMast:(int)mast_ Type:(int)type_;
- (void) moveTo:(CGPoint)point Angle:(float)angle inTime:(NSTimeInterval)time Delay:(NSTimeInterval)delay;
- (NSString*)toString;

@end


@protocol CardDelegate <NSObject>

- (void)didClickSelf:(Card*)card;
- (void)didFinishAnimation:(Card*)card;

@end
