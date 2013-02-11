//
//  SCSCardMatchingGame.m
//  Matchismo
//
//  Created by Adam Sharp on 1/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSCardMatchingGame.h"
#import "SCSPlayingCardFlipResult.h"

@interface SCSCardMatchingGame()
@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;
@property (strong, nonatomic) NSMutableArray *cardsAlreadyInPlay;
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
-(NSMutableArray *)cardsAlreadyInPlay
{
    if (!_cardsAlreadyInPlay) {
        _cardsAlreadyInPlay = [[NSMutableArray alloc] init];
    }
    return _cardsAlreadyInPlay;
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
                break;
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

        if (!card.isFaceUp) {
            // indicate that a card has flipped -- if it also matches, this will be overridden
            self.lastFlipResult = [SCSPlayingCardFlipResult flipResultOfType:SCSPlayingCardFlipResultTypeFaceUp
                                                                   withCards:@[card]
                                                                       score:0];

            // if there are already cards in play, try and match them
            if ([self.cardsAlreadyInPlay count] > 0) {
                NSInteger matchScore = [card match:self.cardsAlreadyInPlay];
                NSArray *cardsInMatch = [self.cardsAlreadyInPlay arrayByAddingObject:card];

                // check if we've matched all the cards in this mode
                if (matchScore && [cardsInMatch count] == self.mode.cardsToMatch) {
                    NSInteger scoreIncrement = matchScore * self.mode.matchBonus;
                    [cardsInMatch enumerateObjectsUsingBlock:^(SCSCard *cardInMatch, NSUInteger index, BOOL *stop) {
                        cardInMatch.unplayable = YES;
                    }];
                    self.score += scoreIncrement;
                    self.lastFlipResult = [SCSPlayingCardFlipResult flipResultOfType:SCSPlayingCardFlipResultTypeMatched
                                                                           withCards:cardsInMatch
                                                                               score:scoreIncrement];
                    [self.cardsAlreadyInPlay removeAllObjects];
                }
                // if we had a mismatch (i.e., score was 0)
                else if (!matchScore) {
                    [self.cardsAlreadyInPlay enumerateObjectsUsingBlock:^(SCSCard *otherCard, NSUInteger index, BOOL *stop) {
                        otherCard.faceUp = NO;
                    }];
                    self.score -= self.mode.mismatchPenalty;
                    self.lastFlipResult = [SCSPlayingCardFlipResult flipResultOfType:SCSPlayingCardFlipResultTypeNotMatched
                                                                           withCards:cardsInMatch
                                                                               score:-self.mode.mismatchPenalty];
                    [self.cardsAlreadyInPlay removeAllObjects];
                    [self.cardsAlreadyInPlay addObject:card];
                }
                // otherwise, we had a partial match
                else {
                    [self.cardsAlreadyInPlay addObject:card];
                }
            }
            // there were no cards already in play, so put this one in play
            else {
                [self.cardsAlreadyInPlay addObject:card];
            }

            self.score -= self.mode.flipCost;
        }
        else {
            // card was flipped face down
            self.lastFlipResult = [SCSPlayingCardFlipResult flipResultOfType:SCSPlayingCardFlipResultTypeFaceDown];
            [self.cardsAlreadyInPlay removeObject:card];
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
