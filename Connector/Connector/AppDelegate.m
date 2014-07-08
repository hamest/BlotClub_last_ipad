//
//  AppDelegate.m
//  BlotClub
//
//  Created by Hamest Tadevosyan on 1/29/14.
//  Copyright (c) 2014 Fluger. All rights reserved.
//

#import "AppDelegate.h"
//#import "TestFlight.h"
#import <HockeySDK/HockeySDK.h>
#import "MKStore/MKStoreManager.h"
#import <CommonCrypto/CommonDigest.h>


@implementation AppDelegate


@synthesize facebook = _facebook;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // [TestFlight takeOff:@"9db03ead-870e-41c9-a717-0ff43e2f700b"];
    
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"cb2fa4dc3195705d362f5bff1364b5ff"];
    [[BITHockeyManager sharedHockeyManager] startManager];
    [[BITHockeyManager sharedHockeyManager].authenticator authenticateInstallation];
    
    
    NSString *appId = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"FacebookAppID"];
    _facebook = [[Facebook alloc] initWithAppId:appId urlSchemeSuffix:nil andDelegate:self];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        self.facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        self.facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
  //  NSString *deviceType = [UIDevice currentDevice].model;
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    } else {
      //  [defaults setObject:@"iPad" forKey:@"Device"];
    }
  //  [self settingForDevice:(NSString *)deviceType];
   // [MKStoreManager sharedManager];
    [defaults setInteger:1 forKey:@"Language"];
    [defaults synchronize];
    [self sendFailedRequests];
    
    return YES;
}

- (void)settingForDevice:(NSString *)deviceType {
    
}

-(void)sendFailedRequests {
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"PaymentUrlArray"]];
    
//    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
//    [dic setObject:urlStr forKey:@"urlStr"];
//    [dic setObject:[NSNumber numberWithInt:0] forKey:@"count"];
//    [array addObject:dic];
//    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"PaymentUrlArray"];
    
    
    for (int i = 0; i < array.count; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[array objectAtIndex:i]];
        
        int count = [[dic objectForKey:@"count"] intValue];
        if (count >3) {
            [array removeObject:dic];
            [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"PaymentUrlArray"];

        } else {
            NSString *urlStr = [dic objectForKey:@"urlStr"];
            NSURL *url = [NSURL URLWithString:urlStr];
            
          //  NSLog(@"%@",[url absoluteString]);
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request setTimeoutInterval:30];
            
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
                if (error) {
                    [self failed:YES url:[response.URL absoluteString]];
                } else {
                    if (responseData) {
                        NSError *jsonError = nil;
                        NSDictionary * data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
                       // NSLog(@"%@",data);
                        
                        if (jsonError == nil) {
                            if ([data isKindOfClass:[NSDictionary class]]) {
                                if (![data objectForKey:@"error"]) {
                                    [self failed:NO url:[response.URL absoluteString]];

                                } else {
                                    [self failed:YES url:[response.URL absoluteString]];
 
                                }
                            } else {
                                [self failed:YES url:[response.URL absoluteString]];
  
                            }
                        } else {
                            [self failed:YES url:[response.URL absoluteString]];

                        }
                    } else {
                        [self failed:YES url:[response.URL absoluteString]];
                    }
                    
                }}];
        }
    }
    

}
             
- (void)failed:(BOOL)failed url:(NSString *)urlStr {
    
    NSMutableArray *array = [[NSMutableArray alloc]initWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"PaymentUrlArray"]];
   // NSLog(@"%@",array);
    
    for (int i = 0; i < array.count; i++) {
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]initWithDictionary:[array objectAtIndex:i]];
       
        NSString *dicurlStr = [dic objectForKey:@"urlStr"];
        if (dicurlStr == urlStr && failed) {
            int count = [[dic objectForKey:@"count"] intValue];
            NSNumber *newCount =[NSNumber numberWithInt:count+1];
            [dic setObject:newCount forKey:@"count"];
            
            [array replaceObjectAtIndex:i withObject:dic];
        }
        if (!failed) {
            [array removeObject:dic];
            i--;
            
        }

    }
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"PaymentUrlArray"];

}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    return [_facebook handleOpenURL:url];
}

- (void)fbLogin {
    
    //  if (![self.facebook isSessionValid]) {
    NSArray* permissionArray = [NSArray arrayWithObjects:@"email", @"user_birthday", @"publish_stream",
                                @"publish_actions",@"user_hometown",@"offline_access", nil];
    [self.facebook authorize:permissionArray];
    //  }
}

- (void)fbLogout {
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"FBAccessTokenKey"];
    [defaults removeObjectForKey:@"FBExpirationDateKey"];
	[defaults synchronize];
	self.facebook.accessToken = nil;
	self.facebook.expirationDate = nil;
}


- (void)fbDidExtendToken:(NSString *)accessToken expiresAt:(NSDate *)expiresAt {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:accessToken forKey:@"FBAccessTokenKey"];
    [defaults setObject:expiresAt forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
}

- (void)fbDidLogin {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self.facebook accessToken] forKey:@"FBAccessTokenKey"];
    [defaults setObject:[self.facebook expirationDate] forKey:@"FBExpirationDateKey"];
    [defaults synchronize];
    [self getFacebookInfo];
}


- (void)getFacebookInfo {
    
    [_facebook requestWithGraphPath:@"me?fields=id,name" andDelegate:self];
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


#pragma mark - FBRequestDelegate methods

- (void)request:(FBRequest *)fbrequest didLoad:(id)result {
    
    NSDictionary *userInfo = (NSDictionary *)result;
   // NSLog(@"FB user info : %@",userInfo);
    
    NSString *blotsecret = @"7da62a3b5ddbae1a5558ff51a250c077";
    NSString *md5Str = [NSString stringWithFormat:@"act=IdentityFBUserfb_id=%@fb_token=%@%@",[userInfo objectForKey:@"id"],_facebook.accessToken,blotsecret];
    md5Str = [self MD5String:md5Str];
    NSString *params = [[NSString alloc] initWithFormat:@"act=IdentityFBUser&fb_id=%@&fb_token=%@&sig=%@",[userInfo objectForKey:@"id"],_facebook.accessToken,md5Str];
    NSString *urlStr = [NSString stringWithFormat:@"https://www.blotclub.am/api/index.php?%@",params];
    NSURL *url = [NSURL URLWithString:urlStr];
   // NSLog(@"%@",[url absoluteString]);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
  //  NSString *params = [[NSString alloc] initWithFormat:@"act=Identity&FBUserfb_id=%@&fb_token=%@&sig=md5Str",[userInfo objectForKey:@"id"],_facebook.accessToken];
  //  NSLog(@"%@",params);
  //  [request setHTTPMethod:@"POST"];
  //  [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *responseData, NSError *error) {
        if (error) {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                              message:[error localizedDescription]
                                                             delegate:self
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles:nil];
            [message show];
        } else {
            NSError *jsonError = nil;
            NSDictionary * data = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&jsonError];
            if (jsonError == nil) {

              //  NSLog(@"%@",data.class);
               // NSLog(@"Response Data is:  %@",data);
                if ([[data objectForKey:@"success"] boolValue]) {
                    NSString *user_id = [[data objectForKey:@"data"] objectForKey:@"user_id"];
                    [[NSUserDefaults standardUserDefaults] setObject:user_id forKey:@"user_id"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    user_id = [self MD5String:[NSString stringWithFormat:@"fish%@",user_id]];
                   
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"LoginUserNotification" object:user_id];

                }

            } else {
                UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[jsonError localizedDescription] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                [alertView show];
               // NSLog(@"ERROR --- jsonError --- %@",[jsonError localizedDescription]);
            }
        }
    }];
}



- (void)fbDidNotLogin:(BOOL)cancelled {
   // NSLog(@"facebook did not login");
}

- (void)fbDidLogout {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"]) {
        [defaults removeObjectForKey:@"FBAccessTokenKey"];
        [defaults removeObjectForKey:@"FBExpirationDateKey"];
        [defaults synchronize];
    }
   // NSLog(@"facebook did logout");
}

- (void)fbSessionInvalidated {
  //  NSLog(@"facebook session is invalidated");
}


@end
