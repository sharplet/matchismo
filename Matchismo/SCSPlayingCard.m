//
//  SCSPlayingCard.m
//  Matchismo
//
//  Created by Adam Sharp on 26/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSPlayingCard.h"

static NSArray * VALID_SUITS = nil;
static NSArray * RANK_STRINGS = nil;

@implementation SCSPlayingCard

@synthesize suit = _suit;

-(NSString *)suit {
    return _suit ? _suit : @"?";
}
-(void)setSuit:(NSString *)suit {
    if ([[SCSPlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

-(void)setRank:(NSUInteger)rank {
    if (rank <= [SCSPlayingCard maxRank]) {
        _rank = rank;
    }
}

-(NSString *)contents {
    NSArray * rankStrings = [SCSPlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

-(NSString *)description
{
    return self.contents;
}

#pragma mark - Matching cards

-(NSInteger)match:(NSArray *)otherCards
{
    NSInteger match = 0;
    NSUInteger suitMatches = 0;
    NSUInteger rankMatches = 0;

    if ([otherCards count] > 0) {
        // match this card against each other card, and count the types of match
        for (id otherCard in otherCards) {
            if ([otherCard isKindOfClass:[SCSPlayingCard class]]) {
                SCSPlayingCard *otherPlayingCard = (SCSPlayingCard *)otherCard;
                if ([self.suit isEqualToString:otherPlayingCard.suit]) {
                    suitMatches++;                }
                else if (self.rank == otherPlayingCard.rank) {
                    rankMatches++;
                }
            }
        }

        // if we matched each card the same way, set the base score
        // depending on difficulty
        if (suitMatches == [otherCards count]) {
            match = 2;
        }
        else if (rankMatches == [otherCards count]) {
            match = 4;
        }

        // apply a bonus multiplier for the number of cards in the match
        match *= [otherCards count];
    }

    return match;
}

#pragma mark - Class helpers

+(NSArray *)validSuits {
    if (!VALID_SUITS) VALID_SUITS = @[@"♥",@"♦",@"♠",@"♣"];
    return VALID_SUITS;
}
+(NSArray *)rankStrings {
    if (!RANK_STRINGS) RANK_STRINGS = @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    return RANK_STRINGS;
}
+(NSUInteger)maxRank {
    return [self rankStrings].count - 1;
}

@end
