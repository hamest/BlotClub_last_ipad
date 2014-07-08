//
//  ScoreView.h
//  Connector
//
//  Created by Hamest Tadevosyan on 2/21/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SFS2XAPIIOS/SmartFox2XClient.h>


@interface ScoreView : UIView <UITableViewDataSource, UITableViewDelegate>

- (void)setData:(SFSObject *)data;

@end
