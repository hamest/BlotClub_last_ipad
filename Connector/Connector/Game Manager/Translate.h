//
//  Translate.h
//  BlotClub
//
//  Created by Hamest Tadevosyan on 4/18/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Translate : NSObject

@property (nonatomic, strong)NSString *GREETING;
@property (nonatomic, strong) NSString *GET_CHIPS;

@property (nonatomic, strong) NSString *LEVEL;
//@property NSString *SEND_SMS=Send SMS with text
//@property NSString *SEND_SMS_FS=24
//@property NSString *TO_NUMBER=to number 3579
//@property NSString *AND_GET=and get
//@property NSString *SMS_PRICE=the cost of the message is 490 AMD
@property (nonatomic, strong) NSString *CLOSE;
@property (nonatomic, strong) NSString *JOIN_TABLE;

@property (nonatomic, strong) NSString *MSG_TOURNAMENTS_DENY;
@property (nonatomic, strong) NSString *MSG_TOURNAMENTS_EMPTY;
@property (nonatomic, strong) NSString *MSG_PROF_CLUB_DENY;
@property (nonatomic, strong) NSString *EXIT;
@property (nonatomic, strong) NSString *EXIT_CAPS;
@property (nonatomic, strong) NSString *EXIT_GAME;
@property (nonatomic, strong) NSString *EXIT_GAME_RATING;
@property (nonatomic, strong) NSString *SCORE;
@property (nonatomic, strong) NSString *LAST_HAND;
@property (nonatomic, strong) NSString *READY;
@property (nonatomic, strong) NSString *I_AM_READY;
@property (nonatomic, strong) NSString *agree;
@property (nonatomic, strong) NSString *disagree;
@property (nonatomic, strong) NSString *PASS;
@property (nonatomic, strong) NSString *MOVE;
@property (nonatomic, strong) NSString *CONTRA;
@property (nonatomic, strong) NSString *RECONTRA;
@property (nonatomic, strong) NSString *TERZ;
@property (nonatomic, strong) NSString *BELOTE;
@property (nonatomic, strong) NSString *REBELOTE;
@property (nonatomic, strong) NSString *BLIND;
@property (nonatomic, strong) NSString *BITA;
@property (nonatomic, strong) NSString *WINNERS;
@property (nonatomic, strong) NSString *LOSERS;
@property (nonatomic, strong) NSString *PLAY_AGAIN;
@property (nonatomic, strong) NSString *NEWBIE;
@property (nonatomic, strong) NSString *Advanced;
@property (nonatomic, strong) NSString *Professional;
@property (nonatomic, strong) NSString *Expert;
@property (nonatomic, strong) NSString *Guru;
@property (nonatomic, strong) NSString *LB_ARCADE;
@property (nonatomic, strong) NSString *LB_TOURN;
@property (nonatomic, strong) NSString *LB_PROF;
//@property NSString *BAZARTTFS=24
//@property NSString *BUT22FS=22

@property (nonatomic, strong) NSString *refresh;
@property (nonatomic, strong) NSString *Announce;
@property (nonatomic, strong) NSString *turn;

@property (nonatomic, strong) NSString *FOOTER_TEXT_STRATEGY;
//@property NSString *FOOTER_LINK_STRATEGY=http://www.blotclub.am/page/strategy/
@property (nonatomic, strong) NSString *FOOTER_TEXT_RULES;
//@property NSString *FOOTER_LINK_RULES=http://www.blotclub.am/page/rules
@property (nonatomic, strong) NSString *FOOTER_TEXT_BLOG;
//@property NSString *FOOTER_LINK_BLOG=http://www.blotclub.am/page/blog

@property (nonatomic, strong) NSString *GAME_TOTAL;
@property (nonatomic, strong) NSString *GAME_WIN;
@property (nonatomic, strong) NSString *GAME_LOST;
@property (nonatomic, strong) NSString *GAME_UNFINISHED;

@property (nonatomic, strong) NSString *GAME_EXIT;
@property (nonatomic, strong) NSString *GAME_SCORE;
@property (nonatomic, strong) NSString *GAME_LAST_HAND;

@property (nonatomic, strong) NSString *TOTAL_SCORE;
@property (nonatomic, strong) NSString *RATE;

@property (nonatomic, strong) NSString *Reconnect;
@property (nonatomic, strong) NSString *Connection_Lost;

@property (nonatomic, strong) NSString *MSG_NOT_ENOUGH_CREDITS;
@property (nonatomic, strong) NSString *MSG_RESTARTING;
@property (nonatomic, strong) NSString *REJOIN_GAME;

+ (Translate *) sharedManagerLunguage:(int)currentLanguage;
- (void)setLunguage:(int)currentLanguage;

@end
