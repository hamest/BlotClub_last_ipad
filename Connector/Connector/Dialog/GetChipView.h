//
//  GetChipView.h
//  BlotClub
//
//  Created by Hamest Tadevosyan on 4/10/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GetChipDelegate <NSObject>

@optional

- (void)buyChipsWithTag:(int)tag;

@end

@interface GetChipView : UIView

@property (nonatomic, strong) UIView * transparent;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@property (nonatomic, assign) id <GetChipDelegate> delegate;

- (void)cancelButtonAction:(id)sender;

@end
