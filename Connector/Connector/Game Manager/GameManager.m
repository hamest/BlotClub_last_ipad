       //
//  GameManager.m
//  Connector
//
//  Created by Hamest Tadevosyan on 1/31/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "GameManager.h"
#import "Utils.h"
#import "Common.h"


@implementation GameManager


static GameManager *sharedGameManager;

+ (GameManager *) sharedManager:(BOOL)production {
	@synchronized([GameManager class])
	{
		if (!sharedGameManager)
			sharedGameManager = [[GameManager alloc] init:production];
        
		return sharedGameManager;
	}
	// to avoid compiler warning
	return nil;
}

+ (id) alloc {
	@synchronized([GameManager class])
	{
		NSAssert(sharedGameManager == nil, @"Attempted to allocate a second instance of a singleton.");
		sharedGameManager = [super alloc];
		return sharedGameManager;
	}
	// to avoid compiler warning
	return nil;
}

- (id) init:(BOOL) production{
    self = [super init];
    
    if (self) {
        smartFox = [[SmartFox2XClient alloc] initSmartFoxWithDebugMode:YES delegate:self];
        smartFox.logger.loggingLevel = LogLevel_DEBUG;
        NSString *config = @"";
        productionBool = production;
        if (production) {
            config = @"config.production.xml";
        } else {
            config = @"config.xml";
        }
        [smartFox loadConfig:config connectOnSuccess:NO];
        /**
         * Connect to SFS2X
         */
        [self connect];
        
        globals = [Globals sharedGlobals];
    }
    
    return self;
}

- (void)connect {
    [smartFox connect];
}

- (void)disconnect {
    [smartFox disconnect];
}

- (void) loginWithUserName:(NSString*)userName {
    
    if ([userName isEqualToString:@""]) {
        userName = @"MASTER OF PUPPETS";
       // userName = @"887d12cb08616faa2838e26355d4b588";
    }

    [smartFox send:[LoginRequest requestWithUserName:userName password:@"" zoneName:nil params:nil]];
}

- (void) logout {
    [smartFox send:[LogoutRequest request]];
}

- (void) chooseClub:(int)cred {
    SFSObject *obj = [[SFSObject alloc] init];
    [obj putInt:@"cred" value:cred];
    [obj putBool:@"change" value:YES];
    
    
    ExtensionRequest *req = [[ExtensionRequest alloc] initWithExtCmd:[Utils getFullName:@"join_arcade"] params:obj room:nil isUDP:NO];
    [smartFox send:req];
}

- (void) backClub:(int)cred {
    SFSObject *obj = [[SFSObject alloc] init];
    [obj putInt:@"cred" value:cred];
    [obj putBool:@"change" value:YES];
    
    
    ExtensionRequest *req = [[ExtensionRequest alloc] initWithExtCmd:[Utils getFullName:@"join_arcade_back"] params:obj room:nil isUDP:NO];
    [smartFox send:req];
}

- (void) SendWithName:(NSString*)name Object:(SFSObject*)obj {
    @try {
        ExtensionRequest *req = [[ExtensionRequest alloc] initWithExtCmd:[Utils getFullName:name] params:obj room:nil isUDP:NO];
        [smartFox send:req];
    }
    @catch (NSException *exception) {
       // NSLog(@"exception.description: %@", exception.description);
    }
}

- (void)sayRequestAct:(NSString*)act Tiv:(int)tiv Mast:(int)mast {
    
    SFSObject *obj = [SFSObject newInstance];
    
    if ([act isEqualToString:@"PASS"]) {
        [obj putInt:@"act" value:2];
    } else {
        if ([act isEqualToString:@"XOD"]) {
            [obj putInt:@"act" value:1];
        } else {
            if ([act isEqualToString:@"CONTRA"]) {
                [obj putInt:@"act" value:3];
            } else {
                [obj putInt:@"act" value:3];
            }
        }
    }
    
    [obj putInt:@"tiv" value:tiv];
    [obj putInt:@"mast" value:mast];
    
    [self SendWithName:@"say" Object:obj];
}

- (void) playRequestMast:(int)mast Type:(int)type {
   // NSLog(@"playRequestMast");
    SFSObject *obj = [SFSObject newInstance];
    
    [obj putInt:@"mast" value:mast];
    [obj putInt:@"tiv" value:type];
    
    [self SendWithName:@"play" Object:obj];
}

- (void)postNotificationOnMainThreadWithName:(NSString *)aName object:(id)anObject{
	NSNotification *notification = [NSNotification notificationWithName:aName object:anObject];
    [[NSNotificationCenter defaultCenter] performSelectorOnMainThread:@selector(postNotification:) withObject:notification waitUntilDone:NO];
    
}

#pragma mark - Connection Event Handlers

- (void)onConfigLoadSuccess:(SFSEvent *)evt
{
   // NSLog(@"Config file loaded, connection attempt permitted");
}

- (void)onConfigLoadFailure:(SFSEvent *)evt
{
   // NSLog(@"%@", [NSString stringWithFormat:@"Config file load failed: %@", [evt.params objectForKey:@"message"]]);
}

/**
 * Connection Events
 */
- (void)onConnection:(SFSEvent *)evt {
    
    if ([self.delegate respondsToSelector:@selector(didConnect:)]) {
        [self.delegate didConnect:evt];
    }
}

- (void)onConnectionLost:(SFSEvent *)evt
{
   // NSLog(@"You have been disconnected from SFS2X");

    if ([self.delegate respondsToSelector:@selector(didConnectLost:)]) {
        [self.delegate didConnectLost:evt];
    }
}

- (void)onConnectionRetry:(SFSEvent *)evt
{
   // NSLog(@"Connection error. Re-attempting SFS2X connection...");
}

#pragma mark - Login Event Handlers

- (void)onLogin:(SFSEvent *)evt
{
    //NSLog(@"You are now logged into the Demo zone");
    
    if ([self.delegate respondsToSelector:@selector(didLogin:)]) {
        [self.delegate didLogin:evt];
    }
}

- (void)onLoginError:(SFSEvent *)evt
{
  //  NSLog(@"%@",evt);
  //  NSLog(@"Error logging into the BasicExamples zone, please check logs");

    if ([self.delegate respondsToSelector:@selector(didLoginError:)]) {
        [self.delegate didLoginError:evt];
    }
}


- (void)onLogout:(SFSEvent *)evt
{
   // NSLog(@"You are no longer logged into the BasicExamples zone");

   /* if ([self.delegate respondsToSelector:@selector(didLogout:)]) {
        [self.delegate didLogout:evt];
    }*/
}

- (void) ready {
    SFSObject *obj = [[SFSObject alloc] init];
    
    ExtensionRequest *req = [[ExtensionRequest alloc] initWithExtCmd:[Utils getFullName:@"ready"] params:obj room:nil isUDP:NO];
    [smartFox send:req];
}

#pragma mark - Room Event Handlers

-(void)onRoomJoin:(SFSEvent *)evt {
    current_game_room = [evt.params objectForKey:@"room"];
  //  NSArray *playerList = current_game_room.playerList;
 
    
    [self postNotificationOnMainThreadWithName:kNotification_Room object:@"JOIN"];
   // [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Room object:@"JOIN"];
}

- (void) onRoomAdd:(SFSEvent *)evt {
    SFSRoom *room = [evt.params objectForKey:@"room"];
    if([evt.type isEqualToString:@"roomRemove"] && [room.name isEqualToString:current_game_room.name]) {
//        Application.$().switchView("lobby");
    }
}

- (void) onUserEnterRoom:(SFSEvent *)evt {
   // NSLog(@"onUserEnterRoom");
  //  SFSRoom *room = (SFSRoom *)[evt.params objectForKey:@"room"];
 //   NSArray *playerList = room.playerList;
//    if ([self.delegate respondsToSelector:@selector(updateUsers:)]) {
//        [self.delegate updateUsers:playerList];
//    }
    
//    Globals.last_ruk_object = null;
//    (Application.$().board as GameDashboard).UpdateUsers(evt.params.room.playerList,this.sfs.mySelf);
}

-(void)onUserVariablesUpdate:(SFSEvent *)evt {
    
    
}
- (void) onUserExitRoom:(SFSEvent *)evt {
//    if(evt.params.user.name==this.sfs.mySelf.name)
//        Application.$().switchView("lobby");
}

- (void) Leave {
    LeaveRoomRequest *request = [LeaveRoomRequest requestWithRoom:[self getRoom]];
    [smartFox send:request];

}

- (SFSRoom*) getRoom {
    return smartFox.lastJoinedRoom;
}

- (NSArray*) getGamePlayers {
    if (current_game_room != nil)
        return current_game_room.playerList;

    return nil;
}

- (void) getGameState {
    SFSObject *obj = [[SFSObject alloc] init];
    [self SendWithName:@"state" Object:obj];
}

- (void) joinGameWithCredits:(int)credits Replace:(BOOL)replace {
    globals.tablecredits = credits;
    
    SFSObject *obj = [[SFSObject alloc] init];
    [obj putInt:@"cred" value:credits];
    [obj putBool:@"change" value:replace];
    
    [self SendWithName:@"join_arcade" Object:obj];
}

- (void) joinGameBack {
    SFSObject *obj = [[SFSObject alloc] init];
    
    [self SendWithName:@"join_arcade_back" Object:obj];
}

- (SFSUser*) mySelf {
    return smartFox.mySelf;
}

- (BOOL) checkConnected {
    if (smartFox.isConnected) {
        if (![smartFox.currentZone isEqualToString:globals.zone]) {
            [smartFox send:[LoginRequest requestWithUserName:globals.username password:globals.password zoneName:nil params:nil]];
        }
        
        return YES;
    }

    self.autologin = true;
    [smartFox connect];
    
    return false;
}

- (void) getTables {
    SFSObject *obj = [[SFSObject alloc] init];

    [self SendWithName:@"listrooms" Object:obj];
}

- (void) sendRestart {
    SFSObject *obj = [[SFSObject alloc] init];
    
    [self SendWithName:@"manualrestartprepare" Object:obj];
}

- (void) sayExtraComplete {
    SFSObject *obj = [[SFSObject alloc] init];
    
    [self SendWithName:@"sayExtraComplete" Object:obj];
}

- (void) moveAfterRebuild:(SFSObject*)responseParams Name:(NSString*)name {
  //  SFSObject *card = [responseParams getSFSObject:name];
//    int seat = [Utils transformSeat:[card getInt:@"wt"]+1];
//    
//    int type = [card getInt:@"t"];
//    int mast = [card getInt:@"m"];
//    int pos = [card getInt:@"pos"];

//    obj.position	= pos;
//    obj.seat  = seat;
//    obj.type  = type;
//    obj.mast  = mast;
//    
//    this.dispatchEvent(new SFServiceEvent(SFServiceEvent.PLAYER_MOVED,obj));
}

-(void)onExtensionResponse:(SFSEvent *)evt {
    SFSObject *responseParams = [evt.params objectForKey:@"params"];

    NSString *cmd = [evt.params objectForKey:@"cmd"];
    NSArray *cases = [[NSArray alloc]initWithObjects:@"welcome_back",@"listrooms",@"notaprofy",@"notenoughcredits",@"restarting",@"roomState",@"readyState",@"bazarState",@"kickStart",@"scoreBoard",@"newGameOffer",@"gameWinnersDeclaration",@"showExtraComplete",@"sayExtraComplete",@"points",@"levelup",@"userObject",@"playerCards",@"playerMoved",@"moveBack",@"gameState", nil];
    int cmdIndex = [cases indexOfObject:cmd];
    switch (cmdIndex) {
        case 0: { //welcome_back
          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            
            [Globals sharedGlobals].tablecredits = [responseParams getInt:@"stake"]; // восстанавливаем предыдущую ставку
            if ([self.delegate respondsToSelector:@selector(askToJoinLastRoom)]) {
                [self.delegate askToJoinLastRoom];
            }
//            Application.$().askToJoinLastRoom();
            
    }
            break;
        case 1: {//listrooms
           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
//            Application.$().updateTables(responseParams);
        }
            break;
        case 2: { //notaprofy
          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            if ([self.delegate respondsToSelector:@selector(showMassage:)]) {
                [self.delegate showMassage:MSGTAG_NOT_PROF];
            }
        }
            break;
            
        case 3:{ //notenoughcredits
           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            if ([self.delegate respondsToSelector:@selector(showMassage:)]) {
                [self.delegate showMassage:MSGTAG_NOT_ENOUGH_CREDITS];
            }
        }
            break;
        case 4: { //restarting
          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            if ([self.delegate respondsToSelector:@selector(showMassage:)]) {
                [self.delegate showMassage:MSGTAG_RESTARTING];
            }
        }
            break;
        case 5: { //roomState
            [Globals sharedGlobals].state =[cases objectAtIndex:cmdIndex];

           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            

            SFSUser *user = [self mySelf];
            
            SFSUserVariable *seat = [user getVariable:@"seat"];
            int value = [seat getIntValue];
            
            globals.mySeat = value;
            

            if ([responseParams getBool:@"paused"]){
//                (Application.$().board as GameDashboard).UpdateUsersNoReset(this.getGamePlayers(),sfs.mySelf);
            } else {
                if ([self.delegate respondsToSelector:@selector(didResetBoard)]) {
                    [self.delegate didResetBoard];
                }
                
                if ([self.delegate respondsToSelector:@selector(updateUsers:)]) {
                    [self.delegate updateUsers:[[GameManager sharedManager:productionBool] getGamePlayers]];
                }
                
//                Application.$().dispatchEvent(new AppEvent(AppEvent.RESET_BOARD));
//                (Application.$().board as GameDashboard).removePopups();
//                (Application.$().board as GameDashboard).UpdateUsers(this.getGamePlayers(),sfs.mySelf);
            }
        }
            break;
        case 6: { //readyState
            [Globals sharedGlobals].state =[cases objectAtIndex:cmdIndex];

           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            
          //  NSLog(@"list aaaaaaaaaaaaaaaaaa %@",[[GameManager sharedManager:productionBool] getGamePlayers]);
            
           
            if ([self.delegate respondsToSelector:@selector(updateUsers:)]) {
                [self.delegate updateUsers:[[GameManager sharedManager:productionBool] getGamePlayers]];
            }
            if ([self.delegate respondsToSelector:@selector(updateReadyState:)]) {
                [self.delegate updateReadyState:[responseParams getIntArray:@"rpl"]];
            }
            
            [Globals sharedGlobals].last_ruk_object = nil;
        }
            break;
        case 7: { //bazarState
            [Globals sharedGlobals].state =[cases objectAtIndex:cmdIndex];

          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);

            if([responseParams containsKey:@"rebuild"] && [responseParams containsKey:@"cards"]) {
               // [responseParams putBool:@"isGameState" value:false];
                if ([self.delegate respondsToSelector:@selector(showUnUsedCards:)]) {
                    [self.delegate showUnUsedCards:[responseParams getSFSObject:@"cards"]];
                }
                
            }
            
            
            [Globals sharedGlobals].last_ruk_object = nil;

            if ([self.delegate respondsToSelector:@selector(didUpdateBazarState:)]) {
                [self.delegate didUpdateBazarState:responseParams];
            }
        }
            break;
        case 8: { //kickStart
           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            if ([self.delegate respondsToSelector:@selector(didKickStart:)]) {
                [self.delegate didKickStart:responseParams];
            }

            //            (Application.$().board as GameDashboard).KickStart(responseParams as SFSObject);
        }
            break;
        case 9: { //scoreBoard
           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);

            [Globals sharedGlobals].last_ruk_object = nil;
            [Globals sharedGlobals].game_score = responseParams;
            if ([self.delegate respondsToSelector:@selector(scoreboardHandler)]) {
                [self.delegate scoreboardHandler];
            }
//            (Application.$().board as GameDashboard).scoreboardHandler();
        }
            break;
        case 10: { //newGameOffer
            [Globals sharedGlobals].state =[cases objectAtIndex:cmdIndex];

           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);

            [Globals sharedGlobals].last_ruk_object = nil;
            [Globals sharedGlobals].game_score = nil;

            if ([self.delegate respondsToSelector:@selector(showNewGameOffer:)]) {
                [self.delegate showNewGameOffer:responseParams];
            }
//            (Application.$().board as GameDashboard).offerHandler(responseParams as SFSObject);
        }
            break;
        case 11: { //gameWinnersDeclaration
            [Globals sharedGlobals].state =[cases objectAtIndex:cmdIndex];

           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            if ([self.delegate respondsToSelector:@selector(showWinnerDeclaration:)]) {
                [self.delegate showWinnerDeclaration:responseParams];
            }
//            Application.$().showWinnerDeclaration(responseParams);
        }
            break;
        case 12: { //showExtraComplete
           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
//            (Application.$().board as GameDashboard).showExtraTip(responseParams);
            if ([self.delegate respondsToSelector:@selector(showExtraTip:)]) {
                [self.delegate showExtraTip:responseParams];
            }
        }
            break;
        case 13: { //sayExtraComplete
          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            
            if ([self.delegate respondsToSelector:@selector(sayExtraTip:)]) {
                [self.delegate sayExtraTip:responseParams];
            }
//            (Application.$().board as GameDashboard).sayExtraTip(responseParams);
            
        }
            break;
        case 14: { //points
           // NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
//            (Application.$().board as GameDashboard).showPoints(responseParams);
        }
            break;
        case 15: { //levelup
          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
//            Application.$().callLevelUp(responseParams);
        }
            break;
        case 16: { //userObject
          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);

            @try{
                [Globals sharedGlobals].me = responseParams;
                if ([self.delegate respondsToSelector:@selector(updateMyself:)]) {
                    [self.delegate updateMyself:[Globals sharedGlobals].me];
                }
            } @catch (NSException *e) {
          //      NSLog(@"e.description: %@", e.description);
            }

        }
            break;
        case 17: { //playerCards
          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
            if ([self.delegate respondsToSelector:@selector(didShareCards:)]) {
                [self.delegate didShareCards:responseParams];
            }

            //            this.dispatchEvent(new SFServiceEvent(SFServiceEvent.SHARE_CARDS,responseParams));
        }
            break;
        case 18: { //playerMoved
          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);

            if ([self.delegate respondsToSelector:@selector(didPlayerMoved:)]) {
                [self.delegate didPlayerMoved:responseParams];
            }

            
//            SFSObject *card = [responseParams getSFSObject:@"card"]; // the card object beeng thrown
//            int seat = [Utils transformSeat:[responseParams getInt:@"wt"]]; // who is throwing the card
//            int type = [card getInt:@"t"]; // the value of card being thrown
//            int mast = [card getInt:@"m"]; // the suit of card being thrown
//            int position = [responseParams getInt:@"pos"]; // server known card position in player hands
            
//            NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:[NSNumber numberWithInt:seat], @"seat",
//                                  [NSNumber numberWithInt:type], @"type",
//                                  [NSNumber numberWithInt:mast], @"mast",
//                                  [NSNumber numberWithInt:position], @"position", nil];
//            var obj:Object = new Object();
//            obj.seat  = seat;
//            obj.type  = type;
//            obj.mast  = mast;
//            obj.position = position;
//            this.dispatchEvent(new SFServiceEvent(SFServiceEvent.PLAYER_MOVED,obj));
        }
            break;
        case 19: { //moveBack
          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);
          //  NSLog(@"%@",responseParams);
            
//            this.dispatchEvent(new SFServiceEvent(SFServiceEvent.MOVE_BACK));
        }
            break;
        case 20: { //gameState
            [Globals sharedGlobals].state =[cases objectAtIndex:cmdIndex];

          //  NSLog(@"cmd : %@",[cases objectAtIndex:cmdIndex]);

//            Application.$().rxtx(1);
            [Globals sharedGlobals].permitted = nil;
            if([responseParams containsKey:@"p_card"])
            {
                [Globals sharedGlobals].permitted = [responseParams getSFSObject:@"p_card"];
                //                this.dispatchEvent(new SFServiceEvent(SFServiceEvent.SET_PERMITTED,Globals.permitted));
                if ([self.delegate respondsToSelector:@selector(didSetPermitted)]) {
                    [self.delegate didSetPermitted];
                }
            }
            
            if([responseParams containsKey:@"lastruk"]) {
                SFSObject *last = [responseParams getSFSObject:@"lastruk"];
                
                if ([self.delegate respondsToSelector:@selector(didTakeAllCards:)]) {
                    [self.delegate didTakeAllCards:[Utils transformSeat:[last getInt:@"winner"]]];
                }

//                this.dispatchEvent(new SFServiceEvent(SFServiceEvent.TAKE_ALL_CARDS,
//                                                      Utils.transformSeat(last.getInt("winner"))));
                
                [Globals sharedGlobals].last_ruk_object = [[SFSObject alloc] init];
                [[Globals sharedGlobals].last_ruk_object putSFSObject:@"cards" value:last];
            }
            
            if([responseParams containsKey:@"rebuild"] && [responseParams containsKey:@"cards"]) {
                [responseParams putBool:@"isGameState" value:true];
                
//                this.dispatchEvent(new SFServiceEvent(SFServiceEvent.SHARE_CARDS,responseParams));
                if ([self.delegate respondsToSelector:@selector(showUnUsedCards:)]) {
                    [self.delegate showUnUsedCards:[responseParams getSFSObject:@"cards"]];
                }
                
                if([responseParams containsKey:@"R0"])
                    [self moveAfterRebuild:responseParams Name:@"R0"];
                
                if([responseParams containsKey:@"R1"])
                    [self moveAfterRebuild:responseParams Name:@"R1"];
                
                if([responseParams containsKey:@"R2"])
                    [self moveAfterRebuild:responseParams Name:@"R2"];
                
                if([responseParams containsKey:@"R3"])
                    [self moveAfterRebuild:responseParams Name:@"R3"];
                
            }
            
            if ([self.delegate respondsToSelector:@selector(didUpdateGameState:)]) {
                [self.delegate didUpdateGameState:responseParams];
            }
            
            
//            (Application.$().board as GameDashboard).UpdateGameState(responseParams as SFSObject);
        }
            break;
        default:
            break;
            
    }
}




@end