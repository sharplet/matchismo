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

+(SCSPlayingCardFlipResult *)flipResultOfType:(SCSCardFlipResult)result
{
    return [self flipResultOfType:result withCards:nil score:0];
}
+(SCSPlayingCardFlipResult *)flipResultOfType:(SCSCardFlipResult)result
                         withCards:(NSArray *)cards
                             score:(NSInteger)score
{
    return [[SCSPlayingCardFlipResult alloc] initWithFlipResultType:result cards:cards score:score];
}

-(id)init
{
    return nil;
}
-(id)initWithFlipResultType:(SCSCardFlipResult)resultType
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

-(NSString *)resultDescription
{
    switch (self.resultType) {
        case SCSCardFlipResultMatched:
            return [NSString stringWithFormat:@"Matched %@ and %@ for %d points",
                    self.cards[0],
                    self.cards[1],
                    self.score];
        case SCSCardFlipResultNotMatched:
            return [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!",
                    self.cards[0],
                    self.cards[1],
                    self.score];
        case SCSCardFlipResultFlippedFaceUp:
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
