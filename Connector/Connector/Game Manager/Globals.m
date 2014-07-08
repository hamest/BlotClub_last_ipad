//
//  self.m
//  Connector
//
//  Created by Hamest Tadevosyan on 1/31/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "Globals.h"

@implementation Globals


static Globals *sharedGlobals;

+ (Globals *) sharedGlobals {
	@synchronized([Globals class])
	{
		if (!sharedGlobals)
			sharedGlobals = [[Globals alloc] init];
        
		return sharedGlobals;
	}
	// to avoid compiler warning
	return nil;
}

+ (id) alloc {
	@synchronized([Globals class])
	{
		NSAssert(sharedGlobals == nil, @"Attempted to allocate a second instance of a singleton.");
		sharedGlobals = [super alloc];
		return sharedGlobals;
	}
	// to avoid compiler warning
	return nil;
}

- (id) init {
    self = [super init];
    
    if (self) {
        self.HOME_URL = @"http://blotclub.am";
		self.DEFAULT_LOCALE = @"ru_RU";
		
		// prefix for sending commands to server
		self.CMD_PFX = @"blot.";
		
		self.BASE_PATH 	= @"";
		
		// SWF paths
		self.SWF_BASE_PATH 			= @"am/blotclub/presentation/ui/swf/";
		self.GAME_BUTTON_SWF_PATH 	= [NSString stringWithFormat:@"%@GameButtons.swf?v=44", self.SWF_BASE_PATH];
		self.STYLESHEET_PATH 		= @"am/blotclub/presentation/skin/css/";
        
		self.ROOM_CASH = @"cash";
		self.ROOM_PROF = @"prof";
		self.ROOM_TOUR = @"tournaments";
		
		self.CURR_GRADE = @"NEWBIE";
		
		self.testers 	= @[@"aramlog",@"gazet",@"coffee",@"test1",@"test2",@"test3",@"test4"];
		self.zone 		= @"Demo";
		self.username 	= @"bd70847d0b639450e9e1856ee3aea3a7";//"MASTER OF PUPPETS";
		self.password 	= @"";
		self.debug      = true;
		self.path 		= @"";
		self.config 	= [NSString stringWithFormat:@"%@sfs-config.xml?25", self.BASE_PATH];
		self.buildpath 	= @"";
		self.game_score = nil;
		self.last_ruk_object = nil;
		self.permitted = nil;
		self.tablecredits = 0;
		self.readyTimeout 	= 15;
		self.kickTimeout 	= 30;
		self.mySeat 		= 0;
		
		self.DIRECT_PLAY = true;
		
		self.gameRate = 0;
        
        self.state = nil;
        
        
//        self.buildpath = FlexGlobals.topLevelApplication.parameters._buildpath==null?Globals.buildpath:FlexGlobals.topLevelApplication.parameters._buildpath;
//        self.zone = FlexGlobals.topLevelApplication.parameters._zone==null?Globals.zone:FlexGlobals.topLevelApplication.parameters._zone;
//        self.debug = FlexGlobals.topLevelApplication.parameters._debug==null?Globals.debug:FlexGlobals.topLevelApplication.parameters._debug;
//        self.path = FlexGlobals.topLevelApplication.parameters._path==null?Globals.path:FlexGlobals.topLevelApplication.parameters._path;
//        self.username = FlexGlobals.topLevelApplication.parameters._username==null?Globals.username:FlexGlobals.topLevelApplication.parameters._username;
//        self.DIRECT_PLAY = FlexGlobals.topLevelApplication.parameters._instantplay==null?true:FlexGlobals.topLevelApplication.parameters._instantplay;
//        
//        Locale.locale = FlexGlobals.topLevelApplication.parameters._locale==null?Locale.locale:FlexGlobals.topLevelApplication.parameters._locale;
//        
//        self.GAME_BUTTON_SWF_PATH = Globals.buildpath + Globals.GAME_BUTTON_SWF_PATH;
//        self.STYLESHEET_PATH = Globals.buildpath + Globals.STYLESHEET_PATH;
//        self.BASE_PATH = Globals.buildpath;
//        self.config = Globals.BASE_PATH+"sfs-config.xml?25";
        
    }
    
    return self;
}

@end