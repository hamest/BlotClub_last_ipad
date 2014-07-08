//
//  Translate.m
//  BlotClub
//
//  Created by Hamest Tadevosyan on 4/18/14.
//  Copyright (c) 2014 A51 Intgerated. All rights reserved.
//

#import "Translate.h"
#import "Common.h"

@interface Translate() {
    NSBundle* languageBundle;
}


@end

@implementation Translate


@synthesize GREETING;
@synthesize GET_CHIPS;

@synthesize LEVEL;

@synthesize CLOSE;
@synthesize JOIN_TABLE;

@synthesize MSG_TOURNAMENTS_DENY;
@synthesize MSG_TOURNAMENTS_EMPTY;
@synthesize MSG_PROF_CLUB_DENY;
@synthesize EXIT;
@synthesize EXIT_CAPS;
@synthesize EXIT_GAME;
@synthesize EXIT_GAME_RATING;
@synthesize SCORE;
@synthesize LAST_HAND;
@synthesize READY;
@synthesize I_AM_READY;
@synthesize agree;
@synthesize disagree;
@synthesize PASS;
@synthesize MOVE;
@synthesize CONTRA;
@synthesize RECONTRA;
@synthesize TERZ;
@synthesize BELOTE;
@synthesize REBELOTE;
@synthesize BLIND;
@synthesize BITA;
@synthesize WINNERS;
@synthesize LOSERS;
@synthesize PLAY_AGAIN;
@synthesize NEWBIE;
@synthesize Advanced;
@synthesize Professional;
@synthesize Expert;
@synthesize Guru;
@synthesize LB_ARCADE;
@synthesize LB_TOURN;
@synthesize LB_PROF;
//@property NSString *BAZARTTFS=24
//@property NSString *BUT22FS=22

@synthesize refresh;
@synthesize Announce;
@synthesize turn;

@synthesize FOOTER_TEXT_STRATEGY;
//@property NSString *FOOTER_LINK_STRATEGY=http://www.blotclub.am/page/strategy/
@synthesize FOOTER_TEXT_RULES;
//@property NSString *FOOTER_LINK_RULES=http://www.blotclub.am/page/rules
@synthesize FOOTER_TEXT_BLOG;
//@property NSString *FOOTER_LINK_BLOG=http://www.blotclub.am/page/blog

@synthesize GAME_TOTAL;
@synthesize GAME_WIN;
@synthesize GAME_LOST;
@synthesize GAME_UNFINISHED;

@synthesize GAME_EXIT;
@synthesize GAME_SCORE;
@synthesize GAME_LAST_HAND;

@synthesize TOTAL_SCORE;
@synthesize RATE;

@synthesize Connection_Lost;
@synthesize Reconnect;

@synthesize MSG_NOT_ENOUGH_CREDITS;
@synthesize MSG_RESTARTING;
@synthesize REJOIN_GAME;

static Translate *sharedLanguageManager;

+ (Translate *) sharedManagerLunguage:(int)currentLanguage {
	@synchronized([Translate class])
	{
		if (!sharedLanguageManager) //{
			sharedLanguageManager = [[Translate alloc] initWithLunguage:currentLanguage];
//        } else {
//            [sharedLanguageManager setLunguage:currentLanguage];
//
//        }
        

		return sharedLanguageManager;
	}
	return nil;
}

+ (id) alloc {
	@synchronized([Translate class])
	{
		sharedLanguageManager = [super alloc];
		return sharedLanguageManager;
	}
	// to avoid compiler warning
	return nil;
}


- (id)initWithLunguage:(int)currentLanguage {
    self = [super init];
    if(self) {
        [self setLunguage:currentLanguage];
    }
    return self;
}

- (void)setLunguage:(int)currentLanguage {
    NSString *path;
	if(currentLanguage==ENGLSIH_LANGUAGE)
		path = [[NSBundle mainBundle] pathForResource:@"en" ofType:@"lproj"];
	else if(currentLanguage==RUSSIAN_LANGUAGE)
		path = [[NSBundle mainBundle] pathForResource:@"ru" ofType:@"lproj"];
	else if(currentLanguage==ARMENIAN_LANGUAGE)
		path = [[NSBundle mainBundle] pathForResource:@"hy" ofType:@"lproj"];
	
	languageBundle = [NSBundle bundleWithPath:path];
    //	NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
    
    self.GREETING = [languageBundle localizedStringForKey:@"GREETING" value:@"" table:nil];
    self.GET_CHIPS = [languageBundle localizedStringForKey:@"GET_CHIPS" value:@"" table:nil];
    
    self.LEVEL = [languageBundle localizedStringForKey:@"LEVEL" value:@"" table:nil];

    self.CLOSE = [languageBundle localizedStringForKey:@"CLOSE" value:@"" table:nil];
    self.JOIN_TABLE = [languageBundle localizedStringForKey:@"JOIN_TABLE" value:@"" table:nil];
    
    self.MSG_TOURNAMENTS_DENY = [languageBundle localizedStringForKey:@"MSG_TOURNAMENTS_DENY" value:@"" table:nil];
    self.MSG_TOURNAMENTS_EMPTY = [languageBundle localizedStringForKey:@"MSG_TOURNAMENTS_EMPTY" value:@"" table:nil];
    self.MSG_PROF_CLUB_DENY = [languageBundle localizedStringForKey:@"MSG_PROF_CLUB_DENY" value:@"" table:nil];
    self.EXIT = [languageBundle localizedStringForKey:@"EXIT" value:@"" table:nil];
    self.EXIT_CAPS = [languageBundle localizedStringForKey:@"EXIT_CAPS" value:@"" table:nil];
    self.EXIT_GAME = [languageBundle localizedStringForKey:@"EXIT_GAME" value:@"" table:nil];
    self.EXIT_GAME_RATING = [languageBundle localizedStringForKey:@"EXIT_GAME_RATING" value:@"" table:nil];
    self.SCORE = [languageBundle localizedStringForKey:@"SCORE" value:@"" table:nil];
    self.LAST_HAND = [languageBundle localizedStringForKey:@"LAST_HAND" value:@"" table:nil];
    self.READY = [languageBundle localizedStringForKey:@"READY" value:@"" table:nil];
    self.I_AM_READY = [languageBundle localizedStringForKey:@"I_AM_READY" value:@"" table:nil];
    self.agree = [languageBundle localizedStringForKey:@"YES" value:@"" table:nil];
    self.disagree = [languageBundle localizedStringForKey:@"NO" value:@"" table:nil];
    self.PASS = [languageBundle localizedStringForKey:@"PASS" value:@"" table:nil];
    self.MOVE = [languageBundle localizedStringForKey:@"MOVE" value:@"" table:nil];
    self.CONTRA = [languageBundle localizedStringForKey:@"CONTRA" value:@"" table:nil];
    self.RECONTRA = [languageBundle localizedStringForKey:@"RECONTRA" value:@"" table:nil];
    self.TERZ = [languageBundle localizedStringForKey:@"TERZ" value:@"" table:nil];
    self.BELOTE = [languageBundle localizedStringForKey:@"BELOTE" value:@"" table:nil];
    self.REBELOTE = [languageBundle localizedStringForKey:@"REBELOTE" value:@"" table:nil];
    self.BLIND = [languageBundle localizedStringForKey:@"BLIND" value:@"" table:nil];
    self.BITA = [languageBundle localizedStringForKey:@"BITA" value:@"" table:nil];
    self.WINNERS = [languageBundle localizedStringForKey:@"WINNERS" value:@"" table:nil];
    self.LOSERS = [languageBundle localizedStringForKey:@"LOSERS" value:@"" table:nil];
    self.PLAY_AGAIN = [languageBundle localizedStringForKey:@"PLAY_AGAIN" value:@"" table:nil];
    self.NEWBIE = [languageBundle localizedStringForKey:@"NEWBIE" value:@"" table:nil];
    self.Advanced = [languageBundle localizedStringForKey:@"Advanced" value:@"" table:nil];
    self.Professional = [languageBundle localizedStringForKey:@"Professional" value:@"" table:nil];
    self.Expert = [languageBundle localizedStringForKey:@"Expert" value:@"" table:nil];
    self.Guru = [languageBundle localizedStringForKey:@"" value:@"" table:nil];
    self.LB_ARCADE = [languageBundle localizedStringForKey:@"LB_ARCADE" value:@"" table:nil];
    self.LB_TOURN = [languageBundle localizedStringForKey:@"LB_TOURN" value:@"" table:nil];
    self.LB_PROF = [languageBundle localizedStringForKey:@"LB_PROF" value:@"" table:nil];
    //@property NSString *BAZARTTFS=24
    //@property NSString *BUT22FS=22
    
    self.refresh = [languageBundle localizedStringForKey:@"refresh" value:@"" table:nil];
    self.Announce = [languageBundle localizedStringForKey:@"Announce" value:@"" table:nil];
    self.turn = [languageBundle localizedStringForKey:@"turn" value:@"" table:nil];
    
    self.FOOTER_TEXT_STRATEGY = [languageBundle localizedStringForKey:@"FOOTER_TEXT_STRATEGY" value:@"" table:nil];
    //@property NSString *FOOTER_LINK_STRATEGY=http://www.blotclub.am/page/strategy/
    self.FOOTER_TEXT_RULES = [languageBundle localizedStringForKey:@"FOOTER_TEXT_RULES" value:@"" table:nil];
    //@property NSString *FOOTER_LINK_RULES=http://www.blotclub.am/page/rules
    self.FOOTER_TEXT_BLOG = [languageBundle localizedStringForKey:@"FOOTER_TEXT_BLOG" value:@"" table:nil];
    //@property NSString *FOOTER_LINK_BLOG=http://www.blotclub.am/page/blog
    
    self.GAME_TOTAL = [languageBundle localizedStringForKey:@"GAME_TOTAL" value:@"" table:nil];
    self.GAME_WIN = [languageBundle localizedStringForKey:@"GAME_WIN" value:@"" table:nil];
    self.GAME_LOST = [languageBundle localizedStringForKey:@"GAME_LOST" value:@"" table:nil];
    self.GAME_UNFINISHED = [languageBundle localizedStringForKey:@"GAME_UNFINISHED" value:@"" table:nil];
    
    self.GAME_EXIT = [languageBundle localizedStringForKey:@"GAME_EXIT" value:@"" table:nil];
    self.GAME_SCORE = [languageBundle localizedStringForKey:@"GAME_SCORE" value:@"" table:nil];
    self.GAME_LAST_HAND = [languageBundle localizedStringForKey:@"GAME_LAST_HAND" value:@"" table:nil];
    
    self.TOTAL_SCORE = [languageBundle localizedStringForKey:@"TOTAL_SCORE" value:@"" table:nil];
    self.RATE = [languageBundle localizedStringForKey:@"RATE" value:@"" table:nil];
    
    self.Connection_Lost = [languageBundle localizedStringForKey:@"Connection_Lost" value:@"" table:nil];
    self.Reconnect = [languageBundle localizedStringForKey:@"Reconnect" value:@"" table:nil];
    
    self.MSG_NOT_ENOUGH_CREDITS = [languageBundle localizedStringForKey:@"MSG_NOT_ENOUGH_CREDITS" value:@"" table:nil];
    self.MSG_RESTARTING = [languageBundle localizedStringForKey:@"MSG_RESTARTING" value:@"" table:nil];
    self.REJOIN_GAME = [languageBundle localizedStringForKey:@"REJOIN_GAME" value:@"" table:nil];
    
}

@end
