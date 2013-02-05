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

@interface SCSCardMatchingGame() {
    // internal storage for any cards related to the last flip result;
    // conceptually this is part of the @lastFlipResult property, so
    // using a standalone instance variable rather than a separate property
    //
    // the first item (if it exists) is expected to be the card that was
    // flipped, and the second item is the other card (in case of a match)
    NSArray *_lastFlipResultCards;

    NSInteger _lastFlipResultScore;
}
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

-(void)setLastFlipResult:(SCSCardFlipResult)lastFlipResult
{
    _lastFlipResult = lastFlipResult;
    _lastFlipResultCards = nil;
    _lastFlipResultScore = 0;
}
-(void)setLastFlipResult:(SCSCardFlipResult)lastFlipResult
                forCards:(NSArray *)cards
                   score:(NSInteger)score
{
    self.lastFlipResult = lastFlipResult;
    _lastFlipResultCards = cards;
    _lastFlipResultScore = score;
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
        _lastFlipResultCards = [[NSArray alloc] init];
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
            [self setLastFlipResult:SCSCardFlipResultFlippedFaceUp forCards:@[card] score:0];

            // search for a matching card
            for (SCSCard *otherCard in self.cards) {
                if (otherCard.isFaceUp && !otherCard.isUnplayable) {
                    NSInteger matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        NSInteger scoreIncrement = matchScore * MATCH_BONUS;
                        otherCard.unplayable = YES;
                        card.unplayable = YES;
                        self.score += scoreIncrement;
                        [self setLastFlipResult:SCSCardFlipResultMatched forCards:@[card, otherCard] score:scoreIncrement];
                    }
                    else {
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        [self setLastFlipResult:SCSCardFlipResultNotMatched forCards:@[card, otherCard] score:MISMATCH_PENALTY];
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
        switch (self.lastFlipResult) {
            case SCSCardFlipResultMatched:
                description = [NSString stringWithFormat:@"Matched %@ and %@ for %d points",
                               _lastFlipResultCards[0],
                               _lastFlipResultCards[1],
                               _lastFlipResultScore];
                break;
            case SCSCardFlipResultNotMatched:
                description = [NSString stringWithFormat:@"%@ and %@ don't match! %d point penalty!",
                               _lastFlipResultCards[0],
                               _lastFlipResultCards[1],
                               _lastFlipResultScore];
            case SCSCardFlipResultFlippedFaceUp:
                description = [NSString stringWithFormat:@"Flipped up %@", [_lastFlipResultCards lastObject]];
            default:
                break;
        }
    }
    return description;
}

@end
