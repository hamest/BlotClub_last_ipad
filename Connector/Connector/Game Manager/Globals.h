//
//  Globals.h
//  Connector
//
//  Created by Hamest Tadevosyan on 1/31/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SFS2XAPIIOS/SmartFox2XClient.h>


@interface Globals : NSObject


+ (Globals*) sharedGlobals;

@property (nonatomic, strong) NSString *HOME_URL;
@property (nonatomic, strong) NSString *DEFAULT_LOCALE;
// prefix for sending commands to server
@property (nonatomic, strong) NSString *CMD_PFX;
@property (nonatomic, strong) NSString *BASE_PATH;

// SWF paths
@property (nonatomic, strong) NSString *SWF_BASE_PATH;
@property (nonatomic, strong) NSString *GAME_BUTTON_SWF_PATH;
@property (nonatomic, strong) NSString *STYLESHEET_PATH;
@property (nonatomic, strong) NSString *ROOM_CASH;
@property (nonatomic, strong) NSString *ROOM_PROF;
@property (nonatomic, strong) NSString *ROOM_TOUR;
@property (nonatomic, strong) NSString *CURR_GRADE;
@property (nonatomic, strong) NSString *state;

@property (nonatomic, strong) SFSObject *me;
@property (nonatomic, strong) NSArray *testers;

@property (nonatomic, strong) NSString *zone;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;

@property (nonatomic, assign) BOOL debug;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *config;
@property (nonatomic, strong) NSString *buildpath;

@property (nonatomic, strong) SFSObject *game_score;
@property (nonatomic, strong) SFSObject *last_ruk_object;
@property (nonatomic, strong) SFSObject *permitted;

@property (nonatomic, assign) int tablecredits;
@property (nonatomic, assign) int readyTimeout;
@property (nonatomic, assign) int kickTimeout;
@property (nonatomic, assign) int mySeat;

@property (nonatomic, assign) BOOL DIRECT_PLAY;
@property (nonatomic, assign) int gameRate;

@end