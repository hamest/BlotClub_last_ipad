//
//  CustomAlertView.m
//  Connector
//
//  Created by Hamest Tadevosyan on 2/14/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "CustomAlertView.h"
#import <QuartzCore/QuartzCore.h>

@interface CustomAlertView(){
    UILabel *titleLabel;
    UILabel *messageLabel;
    UIButton *otherButton;
    UIButton *cancelButton;
    UIView *alert;
}

@end

@implementation CustomAlertView

- (id)initWithdelegate:(id)delegate
{
    CGRect frame = CGRectMake(0, 0, 1024, 768);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.delegate = delegate;
        UIViewController *viewController = (UIViewController *)delegate;
        [viewController.view addSubview:self];
        
        self.hidden = YES;
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.65];
        
        alert= [[UIView alloc]initWithFrame:CGRectMake(0, 0, 318, 200)];
        alert.center = self.center;
       // alert.backgroundColor = [UIColor colorWithRed:95.0f/255.0f green:27.0f/255.0f blue:18.0f/255.0f alpha:1.0f];
        alert.backgroundColor = [UIColor blackColor];
        [self addSubview:alert];
        
       
//        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, alert.frame.size.width - 20, 30)];
//        titleLabel.font = [UIFont boldSystemFontOfSize:20];
//        titleLabel.textColor = [UIColor whiteColor];
//        titleLabel.textAlignment = NSTextAlignmentCenter;
//        [alert addSubview:titleLabel];
        
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, alert.frame.size.width - 20, 80)];
        messageLabel.font = [UIFont boldSystemFontOfSize:20];
        messageLabel.textColor = [UIColor whiteColor];
        messageLabel.textAlignment = NSTextAlignmentCenter;
        messageLabel.numberOfLines = 3;
        [alert addSubview:messageLabel];
        
        cancelButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [cancelButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        cancelButton.frame = CGRectMake(162, alert.frame.size.height - 54 - 20, 144, 54);
        [cancelButton setBackgroundColor:[UIColor colorWithRed:96.0f/255.0f green:24.0f/255.0f blue:17.0f/255.0f alpha:1.0f]];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont boldSystemFontOfSize:23];
        cancelButton.tag = 0;
        [alert addSubview:cancelButton];
        
      
        otherButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [otherButton addTarget:self action:@selector(cancelButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        otherButton.frame = CGRectMake(12, alert.frame.size.height - 54 - 20, 144, 54);
        [otherButton setBackgroundColor:[UIColor colorWithRed:96.0f/255.0f green:24.0f/255.0f blue:17.0f/255.0f alpha:1.0f]];
        [otherButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        otherButton.titleLabel.font = [UIFont boldSystemFontOfSize:23];
        otherButton.tag = 1;
        [alert addSubview:otherButton];
            
        
        
      //  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you want to say hello?" message:@"More info..." delegate:self cancelButtonTitle:@"Cancel" //otherButtonTitles:@"Say Hello",nil];
      //  [alert show];
    }
    return self;
}


- (void)showWithMessage:(NSString *)message otherButtonTitle:(NSString *)otherButtonTitle {
     self.hidden = NO;
   // titleLabel.text = title;
    messageLabel.text = message;
    if (otherButtonTitle) {
        [otherButton setTitle:otherButtonTitle forState:UIControlStateNormal];
        [cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];

    } else {
        otherButton.frame = CGRectZero;
        cancelButton.frame = CGRectMake(12, alert.frame.size.height - 54 - 20, alert.frame.size.width - 24, 54);
        [cancelButton setTitle:@"OK" forState:UIControlStateNormal];
    }



}

- (void)cancelButtonAction:(id)sender {
    UIButton*button = (UIButton *)sender;
    if ([self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:button.tag];
    }
    self.hidden = YES;
    

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
