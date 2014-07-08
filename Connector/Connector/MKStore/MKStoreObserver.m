//
//  MKStoreObserver.m
//
//  Created by Mugunth Kumar on 17-Oct-09.
//  Copyright 2009 Mugunth Kumar. All rights reserved.
//

#import "MKStoreObserver.h"
#import "MKStoreManager.h"

@implementation MKStoreObserver

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
	for (SKPaymentTransaction *transaction in transactions)
	{
		switch (transaction.transactionState)
		{
			case SKPaymentTransactionStatePurchased: {
                [self completeTransaction:transaction];
            }
				
                break;
				
            case SKPaymentTransactionStateFailed:
				
                [self failedTransaction:transaction];
				
                break;
				
            case SKPaymentTransactionStateRestored:
				
                [self restoreTransaction:transaction];
				
            default:
				
                break;
		}			
	}
}

- (void) failedTransaction: (SKPaymentTransaction *)transaction
{
   // NSLog(@"transaction.description: %@", transaction.error.description);
    if (transaction.error.code != SKErrorPaymentCancelled)		
    {		
        // Optionally, display an error here.		
    }	
	[[MKStoreManager sharedManager] paymentCanceled];
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

- (void) completeTransaction: (SKPaymentTransaction *)transaction
{		
    [[MKStoreManager sharedManager] provideContent:transaction];	
}

- (void) restoreTransaction: (SKPaymentTransaction *)transaction
{	
    [[SKPaymentQueue defaultQueue] finishTransaction: transaction];
}

@end
