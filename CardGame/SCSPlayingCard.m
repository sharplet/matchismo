//
//  SCSPlayingCard.m
//  CardGame
//
//  Created by Adam Sharp on 26/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSPlayingCard.h"

@interface SCSPlayingCard()

@end

@implementation SCSPlayingCard
@synthesize suit = _suit;

+(NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}
+(NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}
+(NSUInteger)maxRank {
    return [self rankStrings].count - 1;
}

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

@end
