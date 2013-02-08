//
//  SCSCardMatchingMode.m
//  Matchismo
//
//  Created by Adam Sharp on 8/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSCardMatchingMode.h"

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

@implementation SCSCardMatchingMode

-(id)init
{
    return [self initWithNumberOfCardsToMatch:2];
}
-(id)initWithNumberOfCardsToMatch:(NSUInteger)cardsToMatch
{
    self = [super init];
    if (self) {
        _cardsToMatch = cardsToMatch;
        _flipCost = FLIP_COST;
        _matchBonus = MATCH_BONUS;
        _mismatchPenalty = MISMATCH_PENALTY;
    }
    return self;
}

@end
