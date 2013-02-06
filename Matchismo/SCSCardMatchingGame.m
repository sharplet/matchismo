//
//  SCSCardMatchingGame.m
//  Matchismo
//
//  Created by Adam Sharp on 1/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSCardMatchingGame.h"
#import "SCSPlayingCardFlipResult.h"

#define FLIP_COST 1
#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2

@interface SCSCardMatchingGame()
@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;
@property (nonatomic, getter=isStarted) BOOL started;
@property (strong, nonatomic) SCSPlayingCardFlipResult *lastFlipResult;
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
            self.lastFlipResult = [SCSPlayingCardFlipResult flipResultOfType:SCSCardFlipResultFlippedFaceUp
                                                                   withCards:@[card]
                                                                       score:0];

            // search for a matching card
            for (SCSCard *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    NSInteger matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        NSInteger scoreIncrement = matchScore * MATCH_BONUS;
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += scoreIncrement;
                        self.lastFlipResult = [SCSPlayingCardFlipResult flipResultOfType:SCSCardFlipResultMatched
                                                                               withCards:@[card, otherCard]
                                                                                   score:scoreIncrement];
                    }
                    else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.lastFlipResult = [SCSPlayingCardFlipResult flipResultOfType:SCSCardFlipResultNotMatched
                                                                               withCards:@[card, otherCard]
                                                                                   score:MISMATCH_PENALTY];
                    }
                }
            }
            self.score -= FLIP_COST;
        }
        else {
            // card was flipped face down
            self.lastFlipResult = [SCSPlayingCardFlipResult flipResultOfType:SCSCardFlipResultFlippedFaceDown];
        }

        // flip the card
        card.faceUp = !card.isFaceUp;
    }
}

-(NSString *)lastFlipResultDescription
{
    NSString *description = nil;
    if (self.isStarted) {
        return [self.lastFlipResult resultDescription];
    }
    return description;
}

@end
