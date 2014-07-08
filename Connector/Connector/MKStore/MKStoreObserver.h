//
//  MKStoreObserver.m
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 Mugunth Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>

//enum FILM_PURCHASE_STATE {
//    FILM_PURCHASE_STATE_NONE = 1,
//    FILM_PURCHASE_STATE_SENDET,
//    FILM_PURCHASE_STATE_PURCHASED
//    };
@interface MKStoreObserver : NSObject<SKPaymentTransactionObserver> {

	
}
	
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions;
- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (void) completeTransaction: (SKPaymentTransaction *)transaction;
- (void) restoreTransaction: (SKPaymentTransaction *)transaction;

@end
