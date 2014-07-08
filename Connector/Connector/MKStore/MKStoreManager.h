//
//  StoreManager.h
//  MKSync
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 MK Inc. All rights reserved.
//  mugunthkumar.com

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import "MKStoreObserver.h"


// all your features should be managed one and only by StoreManager
static NSString *tier1          = @"bc_cp_1000";
static NSString *tier2          = @"bc_cp_15500";
static NSString *tier3          = @"bc_cp_2500";
static NSString *tier4          = @"bc_cp_5500";


@protocol MKStoreKitDelegate <NSObject>
@optional
- (void)productPurchased:(SKPaymentTransaction*)paymentTransaction;
- (void)failed:(NSString *)urlStr;
@end

@interface MKStoreManager : NSObject<SKProductsRequestDelegate, SKPaymentTransactionObserver> {

	NSMutableArray *purchasableObjects;
	MKStoreObserver *storeObserver;	

	id<MKStoreKitDelegate> delegate;
}

@property (nonatomic, retain) id<MKStoreKitDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *purchasableObjects;
@property (nonatomic, retain) MKStoreObserver *storeObserver;

- (void) requestProductData;

// do not call this directly. This is like a private method
- (void) buyFilmByValue:(NSString *)valu;
//- (SKProduct*) getProductByTier:(int)tier;
- (void) paymentCanceled;

- (void) failedTransaction: (SKPaymentTransaction *)transaction;
- (void) provideContent:(SKPaymentTransaction*)paymentTransaction;

+ (MKStoreManager*)sharedManager;

+ (BOOL) getPurchasesByInAppID:(NSString*)inAppID;
- (void) sendRequestForSuccessPurchased:(SKPaymentTransaction *)transaction;
- (void) RestorePurchase;
- (NSString *) priceAsStringAsCurrency:(SKProduct*)product;

@end
