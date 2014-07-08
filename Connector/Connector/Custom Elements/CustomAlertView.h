//
//  CustomAlertView.h
//  Connector
//
//  Created by Hamest Tadevosyan on 2/14/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol CustomAlertViewDelegate;


@interface CustomAlertView : UIView

@property (nonatomic,assign)id <CustomAlertViewDelegate> delegate;

//- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate otherButtonTitle:(NSString *)otherButtonTitle;
- (id)initWithdelegate:(id)delegate;
- (void)showWithMessage:(NSString *)message otherButtonTitle:(NSString *)otherButtonTitle;

@end


@protocol CustomAlertViewDelegate <NSObject>

- (void)alertView:(CustomAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;


@end