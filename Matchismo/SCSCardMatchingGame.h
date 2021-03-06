//
//  SCSCardMatchingGame.h
//  Matchismo
//
//  Created by Adam Sharp on 1/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSDeck.h"

@interface SCSCardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(SCSDeck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;
-(SCSCard *)cardAtIndex:(NSUInteger)index;

@property (readonly, nonatomic) NSInteger score;

@end
