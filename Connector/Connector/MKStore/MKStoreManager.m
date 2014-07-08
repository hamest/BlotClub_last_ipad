//
//  MKStoreManager.m
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 Mugunth Kumar. All rights reserved.
//  mugunthkumar.com
//

#import "MKStoreManager.h"
#import <CommonCrypto/CommonDigest.h>
#import "Base64.h"



@implementation MKStoreManager

@synthesize purchasableObjects;
@synthesize storeObserver;
@synthesize delegate;


static MKStoreManager* _sharedStoreManager; // self


+ (MKStoreManager*)sharedManager
{
	@synchronized(self) {
		
        if (_sharedStoreManager == nil) {
			
            [[self alloc] init];
			_sharedStoreManager.purchasableObjects = [[NSMutableArray alloc] init];			
			[_sharedStoreManager requestProductData];
			_sharedStoreManager.storeObserver = [[MKStoreObserver alloc] init];
			[[SKPaymentQueue defaultQueue] addTransactionObserver:_sharedStoreManager.storeObserver];
        }
    }
    return _sharedStoreManager;
}


#pragma mark Singleton Methods

+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (_sharedStoreManager == nil) {
            _sharedStoreManager = [super allocWithZone:zone];
            return _sharedStoreManager;  // assignment and return on first allocation
        }
    }
	
    return nil; //on subsequent allocation attempts return nil	
}


- (id)copyWithZone:(NSZone *)zone
{
    return self;	
}

- (void) requestProductData
{
	SKProductsRequest *request= [[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObjects:
                                                                                       tier1,
                                                                                       tier2,
                                                                                       tier3,
                                                                                       tier4,
                                                                                       nil]];
	request.delegate = self;
	[request start];
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
	[purchasableObjects addObjectsFromArray:response.products];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShowChipButtonsNotifocation" object:nil];

	// populate your UI Controls here
//	for (int i=0;i<[purchasableObjects count];i++) {
//		SKProduct *product = [purchasableObjects objectAtIndex:i];
//		NSLog(@"Feature: %@, Cost: %f, ID: %@",[product localizedTitle], [[product price] doubleValue], [product productIdentifier]);
//        NSLog(@"%@", product.localizedDescription);
//        NSLog(@"%@", product.localizedTitle);
//        NSLog(@"%@", product.productIdentifier);
//        
//        NSLog(@"%@", [self priceAsStringAsCurrency:product]);
//	}
}

- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
   // NSLog(@"error.localizedDescription: %@", error.localizedDescription);
}

- (void) buyFilmByValue:(NSString *)valu
{
    
//    int purchase_state = [[NSUserDefaults standardUserDefaults] integerForKey:@"FILM_PURCHASE_STATE"];
//    
//    if (purchase_state == FILM_PURCHASE_STATE_PURCHASED) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Cinecliq"
//                                                        message:@"You have no complite film purchase"
//                                                       delegate:self
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        
//        if([delegate respondsToSelector:@selector(failed:)])
//            [delegate failed];
//        
//        return;
//    }
    
	if ([SKPaymentQueue canMakePayments]) {
        if (self.purchasableObjects && self.purchasableObjects.count > 0) {
            SKProduct *product;
            for (SKProduct *purchasableProduct in purchasableObjects) {
                if ([purchasableProduct.productIdentifier isEqualToString:valu]) {
                    product = purchasableProduct;
                    
                    break;
                }
            }
            if (product) {
                SKPayment *payment = [SKPayment paymentWithProduct:product];
                [[SKPaymentQueue defaultQueue] addPayment:payment];
            } else {
                if([delegate respondsToSelector:@selector(failed:)])
                    [delegate failed:nil];
            }
        } else {
            if([delegate respondsToSelector:@selector(failed:)])
                [delegate failed:nil];
        }
	} else {
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BlotClub"
                                                        message:@"You are not authorized to purchase from AppStore."
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
		[alert show];

        if([delegate respondsToSelector:@selector(failed:)])
            [delegate failed:nil];
	}
}

-(void)paymentCanceled
{
	if([delegate respondsToSelector:@selector(failed:)])
		[delegate failed:nil];
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
	if([delegate respondsToSelector:@selector(failed:)])
		[delegate failed:nil];
	
	NSString *messageToBeShown = [NSString stringWithFormat:@"Reason: %@, You can try: %@", [transaction.error localizedFailureReason], [transaction.error localizedRecoverySuggestion]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Unable to complete your purchase."
                                                    message:messageToBeShown
												   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles: nil];
	[alert show];
}

- (void) provideContent:(SKPaymentTransaction*)paymentTransaction
{
	[self sendRequestForSuccessPurchased:paymentTransaction];
}


+(BOOL) getPurchasesByInAppID:(NSString*)inAppID
{
	NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];	
	return [userDefaults boolForKey:inAppID];
}

- (NSString *)MD5String:(NSString *)str {
    
    const char *cstr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, strlen(cstr), result);
    
    NSMutableString *hex = [NSMutableString string];
    for (int i=0; i<16; i++)
        [hex appendFormat:@"%02x", result[i]];
    
    // And if you insist on having the hex in an immutable string:
    NSString *immutableHex = [NSString stringWithString:hex];
    
    return immutableHex;
}

- (void) sendRequestForSuccessPurchased:(SKPaymentTransaction *)transaction {
    
    NSString *strBase64 = [[NSString alloc] initWithData:transaction.transactionReceipt encoding:NSUTF8StringEncoding];
    strBase64 = [strBase64 base64EncodedString];
  //  strBase64 = [strBase64 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   // strBase64 = [strBase64 stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] objectForKey:@"user_id"];
    NSString *amount = [[NSUserDefaults standardUserDefaults] objectForKey:@"amount"];
    if (!user_id) {
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }
    NSString *blotsecret = @"7da62a3b5ddbae1a5558ff51a250c077";
    NSString *md5Str = [NSString stringWithFormat:@"act=purchaseamount=%@receipt=%@user_id=%@%@",amount,strBase64,user_id,blotsecret];
    md5Str = [self MD5String:md5Str];
    NSString *params = [[NSString alloc] initWithFormat:@"act=purchase&user_id=%@&amount=%@&sig=%@",user_id, amount,md5Str];
    NSString *urlStr = [NSString stringWithFormat:@"https://www.blotclub.am/api/index.php?%@",params];

    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    urlStr = [urlStr stringByAppendingString:[NSString stringWithFormat:@"&receipt=%@", strBase64]];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    
   // NSLog(@"%@",[url absoluteString]);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30];
    
//    [request setHTTPMethod:@"GET"];
//    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
        if (error) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"BlotClub"
                                                              message:[error localizedDescription]
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
            
            if([delegate respondsToSelector:@selector(failed:)])
                [delegate failed:urlStr];
        } else {
            if (responseData) {
                NSError *jsonError = nil;
                NSDictionary * data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
              //  NSLog(@"%@",data);

                if (jsonError == nil) {
                    if ([data isKindOfClass:[NSDictionary class]]) {
                        if (![data objectForKey:@"error"]) {
                            if([delegate respondsToSelector:@selector(productPurchased:)])
                                [delegate productPurchased:transaction];
                          //  [delegate failed:urlStr];
                            
                            [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                            
                        } else {
                            if([delegate respondsToSelector:@selector(failed:)])
                                [delegate failed:urlStr];
                        }
                    } else {
                        if([delegate respondsToSelector:@selector(failed:)])
                            [delegate failed:urlStr];
                    }
                } else {
                    if([delegate respondsToSelector:@selector(failed:)])
                        [delegate failed:urlStr];
                }
            } else {
                if([delegate respondsToSelector:@selector(failed:)])
                    [delegate failed:urlStr];
            }
        }
        
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    }];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
}

/*- (SKProduct*) getProductByTier:(int)tier {
    NSString *strTier = nil;
    switch (tier) {
        case 1:
            strTier = tier2;
            break;
        case 2:
            strTier = tier3;
            break;
        case 3:
            strTier = tier4;
            break;
        case 4:
            strTier = tier5;
            break;
        default:
            break;
    }
    
    if (purchasableObjects && purchasableObjects.count) {
        for (SKProduct *product in purchasableObjects) {
            if ([product.productIdentifier isEqualToString:strTier]) {
                return product;
            }
        }
    }
    
    return nil;
}*/

- (void)RestorePurchase {
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BlotClub"
                                                    message:@"Restore Success!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];

   // NSLog(@"paymentQueueRestoreCompletedTransactionsFinished");
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"BlotClub"
                                                    message:@"Restore Failed"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    
    [alert show];

   // NSLog(@"restoreCompletedTransactionsFailedWithError");
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
               // NSLog(@"SKPaymentTransactionStatePurchased");
                break;
            case SKPaymentTransactionStateFailed:
               // NSLog(@"SKPaymentTransactionStateFailed");
                break;
            case SKPaymentTransactionStateRestored:
              //  NSLog(@"SKPaymentTransactionStateRestored");
            default:
                break;
        }
    }
}

- (NSString *) priceAsStringAsCurrency:(SKProduct*)product;
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setLocale:[product priceLocale]];
    
    NSString *str = [formatter stringFromNumber:[product price]];
    return str;
}

@end