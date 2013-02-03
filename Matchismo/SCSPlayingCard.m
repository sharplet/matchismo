//
//  SCSPlayingCard.m
//  Matchismo
//
//  Created by Adam Sharp on 26/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSPlayingCard.h"

@interface SCSPlayingCard()

@end

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

#pragma mark - Matching cards

-(NSInteger)match:(NSArray *)otherCards
{
    NSInteger match = 0;
    if ([otherCards count] == 1) {
        SCSPlayingCard *otherCard = [otherCards lastObject];
        if ([self.suit isEqualToString:otherCard.suit]) {
            match = 1;
        }
        else if (self.rank == otherCard.rank) {
            match = 4;
        }
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
