//
//  SCSFlipResult.m
//  Matchismo
//
//  Created by Adam Sharp on 7/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSPlayingCardFlipResult.h"
#import "SCSPlayingCard.h"

@implementation SCSPlayingCardFlipResult

+(SCSPlayingCardFlipResult *)flipResultOfType:(SCSPlayingCardFlipResultType)result
{
    return [self flipResultOfType:result withCards:nil score:0];
}
+(SCSPlayingCardFlipResult *)flipResultOfType:(SCSPlayingCardFlipResultType)result
                         withCards:(NSArray *)cards
                             score:(NSInteger)score
{
    return [[SCSPlayingCardFlipResult alloc] initWithFlipResultType:result cards:cards score:score];
}

-(id)init
{
    return nil;
}
-(id)initWithFlipResultType:(SCSPlayingCardFlipResultType)resultType
                      cards:(NSArray *)cards
                      score:(NSInteger)score
{
    self = [super init];
    if (self) {
        _resultType = resultType;
        _score = score;

        // if we find something that isn't an SCSPlayingCard, break
        // and return nil
        for (id card in cards) {
            if (![card isKindOfClass:[SCSPlayingCard class]]) {
                return nil;
            }
        }
        _cards = cards;
    }
    return self;
}

-(NSString *)cardListString
{
    NSString *cardListString;
    if ([self.cards count] > 1) {
        NSIndexSet *commaSeparatedCardIndexes = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.cards count]-1)];
        NSArray *commaSeparatedCards = [self.cards objectsAtIndexes:commaSeparatedCardIndexes];
        cardListString = [NSString stringWithFormat:@"%@ and %@", [commaSeparatedCards componentsJoinedByString:@", "], [self.cards lastObject]];
    }
    else {
        cardListString = [[self.cards lastObject] description];
    }
    return cardListString;
}
-(NSString *)resultDescription
{
    switch (self.resultType) {
        case SCSPlayingCardFlipResultTypeMatched:
            return [NSString stringWithFormat:@"Matched %@ for %d points",
                    [self cardListString],
                    self.score];
        case SCSPlayingCardFlipResultTypeNotMatched:
            return [NSString stringWithFormat:@"%@ don't match! %d point penalty!",
                    [self cardListString],
                    self.score];
        case SCSPlayingCardFlipResultTypeFaceUp:
            return [NSString stringWithFormat:@"Flipped up %@", [self.cards lastObject]];
        default:
            return nil;
    }
}
-(NSString *)description
{
    return [self resultDescription];
}

@end
