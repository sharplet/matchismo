//
//  SCSCardMatchingGame.m
//  Matchismo
//
//  Created by Adam Sharp on 1/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSCardMatchingGame.h"

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

typedef NS_ENUM(NSInteger, SCSCardFlipResult) {
    SCSCardFlipResultFlippedFaceUp,
    SCSCardFlipResultFlippedFaceDown,
    SCSCardFlipResultMatched,
    SCSCardFlipResultNotMatched
};

@interface SCSCardMatchingGame()
@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, getter=isStarted) BOOL started;
@property (nonatomic) SCSCardFlipResult lastFlipResult;
@end

@implementation SCSCardMatchingGame

-(NSMutableArray *)cards
{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

#pragma mark - Designated initialiser

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(SCSDeck *)deck
{
    if (self = [super init]) {
        for (int i = 0; i < cardCount; i++) {
            SCSCard *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            }
            else {
                self = nil;
            }
        }
    }
    return self;
}

#pragma mark - Working with cards

-(SCSCard *)cardAtIndex:(NSUInteger)index
{
    if (index < [self.cards count]) {
        return self.cards[index];
    }
    else {
        return nil;
    }
}

-(void)flipCardAtIndex:(NSUInteger)index
{
    SCSCard *card = [self cardAtIndex:index];

    if (!card.isUnplayable) {
        // a card is being flipped, indicate that the game has started
        self.started = YES;

        // scoring happens whenever a card is flipped face up
        if (!card.isFaceUp) {
            // indicate that a card has flipped -- if it also matches, this will be overridden
            self.lastFlipResult = SCSCardFlipResultFlippedFaceUp;

            // search for a matching card
            for (SCSCard *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    NSInteger matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.lastFlipResult = SCSCardFlipResultMatched;
                    }
                    else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.lastFlipResult = SCSCardFlipResultNotMatched;
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        else {
            // card was flipped face down
            self.lastFlipResult = SCSCardFlipResultFlippedFaceDown;
        }

        // flip the card
        card.faceUp = !card.isFaceUp;
    }
}

-(NSString *)lastFlipResultDescription
{
    NSString *description = nil;
    if (self.isStarted) {
        description = [NSString stringWithFormat:@"Result: %d", self.lastFlipResult];
    }
    return description;
}

@end
