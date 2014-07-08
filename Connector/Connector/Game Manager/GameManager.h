//
//  GameManager.h
//  Connector
//
//  Created by Hamest Tadevosyan on 1/31/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Globals.h"
#import "Card.h"


#define kNotification_Room @"kNotification_Room"
#define kNotification_SHARE_CARDS @"kNotification_SHARE_CARDS"
#define kNotification_BAZARSTATE @"kNotification_BAZARSTATE"




@protocol GameManagerDelegate <NSObject>

@optional
- (void)didConnect:(SFSEvent *)evt;
- (void)didConnectLost:(SFSEvent *)evt;
- (void)didLogin:(SFSEvent *)evt;
- (void)didLoginError:(SFSEvent *)evt;
- (void)didLogout:(SFSEvent *)evt;
- (void)didUpdateBazarState:(SFSObject *)obj;
- (void)didUpdateGameState:(SFSObject *)params;
- (void)didShareCards:(SFSObject *)obj;
- (void)didPlayerMoved:(SFSObject *)obj;
- (void)didKickStart:(SFSObject *)obj;
- (void)sayExtraTip:(SFSObject *)obj;
- (void)showExtraTip:(SFSObject *)obj;
- (void)updateUsers:(NSArray *)playersList;
- (void)updateReadyState:(NSArray *)readyPlayersList;
- (void)didTakeAllCards:(int)winner;
- (void)didSetPermitted;
- (void)didResetBoard;
- (void)askToJoinLastRoom;
- (void)showUnUsedCards:(SFSObject *)obj;
- (void)showNewGameOffer:(SFSObject *)obj;
- (void)showWinnerDeclaration:(SFSObject *)obj;
- (void)updateMyself:(SFSObject *)me;
- (void)scoreboardHandler;
- (void)showMassage:(int)massageTag;

@end


@interface GameManager : NSObject <ISFSEvents> {
    SmartFox2XClient *smartFox;
    Globals *globals;
    SFSRoom *current_game_room;
    BOOL productionBool;
}

@property (nonatomic, assign) id <GameManagerDelegate> delegate;
@property (nonatomic, assign) BOOL autologin;

+ (GameManager*) sharedManager:(BOOL)production;
- (void) loginWithUserName:(NSString*)userName;
- (void) logout;
- (void) chooseClub:(int)cred;
- (void) backClub:(int)cred;
- (void) ready;
- (void) Leave;
- (SFSUser*) mySelf;
- (NSArray*) getGamePlayers;
- (void) SendWithName:(NSString*)name Object:(SFSObject*)obj;
- (void) sayRequestAct:(NSString*)act Tiv:(int)tiv Mast:(int)mast;
- (void) playRequestMast:(int)mast Type:(int)type;
- (void)connect;
- (void)disconnect;


@end