//
//  SCSPlayingCardDeck.m
//  Matchismo
//
//  Created by Adam Sharp on 26/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSPlayingCardDeck.h"
#import "SCSPlayingCard.h"

@interface SCSPlayingCardDeck()

@end

@implementation SCSPlayingCardDeck

-(id)init {
    if (self = [super init]) {
        for (NSString * suit in [SCSPlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [SCSPlayingCard maxRank]; rank++) {
                SCSPlayingCard * card = [[SCSPlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES];
            }
        }
    }
    return self;
}

@end
