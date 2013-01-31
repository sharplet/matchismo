//
//  SCSDeck.m
//  Matchismo
//
//  Created by Adam Sharp on 26/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSDeck.h"

@interface SCSDeck()
@property (strong, nonatomic) NSMutableArray * cards;
@end

@implementation SCSDeck

-(NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void)addCard:(SCSCard *)card atTop:(BOOL)atTop {
    if (card) {
        if (atTop) {
            [self.cards insertObject:card atIndex:0];
        }
        else {
            [self.cards addObject:card];
        }
    }
}

-(SCSCard *)drawRandomCard {
    SCSCard * randomCard;
    if (self.cards.count) {
        NSUInteger index = arc4random() % self.cards.count;
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    return randomCard;
}

@end
