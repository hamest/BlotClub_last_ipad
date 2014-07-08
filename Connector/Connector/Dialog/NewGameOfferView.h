//
//  NewGameOfferView.h
//  Connector
//
//  Created by Hamest Tadevosyan on 2/26/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SFS2XAPIIOS/SmartFox2XClient.h>


@interface NewGameOfferView : UIView

- (id)initWithData:(SFSObject *)data myName:(NSString *)name imageUrl:(NSURL *)url level:(NSString *)level playAgain:(BOOL)playAgain;

@end
