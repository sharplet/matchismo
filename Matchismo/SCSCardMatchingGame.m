//
//  SCSCardMatchingGame.m
//  Matchismo
//
//  Created by Adam Sharp on 1/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSCardMatchingGame.h"

@interface SCSCardMatchingGame()
@property (readwrite, nonatomic) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;
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

@end
