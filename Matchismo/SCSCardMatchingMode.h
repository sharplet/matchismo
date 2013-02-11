//
//  SCSCardMatchingMode.h
//  Matchismo
//
//  Created by Adam Sharp on 8/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCSCardMatchingMode : NSObject

@property (readonly, nonatomic) NSUInteger cardsToMatch;
@property (readonly, nonatomic) NSInteger flipCost;
@property (readonly, nonatomic) NSInteger mismatchPenalty;
@property (readonly, nonatomic) NSUInteger matchBonus;

-(id)initWithNumberOfCardsToMatch:(NSUInteger)cardsToMatch;

@end
