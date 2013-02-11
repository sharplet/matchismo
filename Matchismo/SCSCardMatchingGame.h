//
//  SCSCardMatchingGame.h
//  Matchismo
//
//  Created by Adam Sharp on 1/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSDeck.h"
#import "SCSCardMatchingMode.h"

@interface SCSCardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(SCSDeck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;
-(SCSCard *)cardAtIndex:(NSUInteger)index;
-(NSString *)lastFlipResultDescription;

@property (readonly, nonatomic) NSInteger score;
@property (strong, nonatomic) SCSCardMatchingMode *mode;

@end
