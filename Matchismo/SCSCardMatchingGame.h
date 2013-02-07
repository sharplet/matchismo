//
//  SCSCardMatchingGame.h
//  Matchismo
//
//  Created by Adam Sharp on 1/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSDeck.h"

typedef NS_ENUM(NSUInteger, SCSCardMatchingGameMatchMode) {
    SCSCardMatchingGameMatchMode2Cards,
    SCSCardMatchingGameMatchMode3Cards
};

@interface SCSCardMatchingGame : NSObject

-(id)initWithCardCount:(NSUInteger)cardCount
             usingDeck:(SCSDeck *)deck;

-(void)flipCardAtIndex:(NSUInteger)index;
-(SCSCard *)cardAtIndex:(NSUInteger)index;
-(NSString *)lastFlipResultDescription;

@property (readonly, nonatomic) NSInteger score;
@property (nonatomic) SCSCardMatchingGameMatchMode mode;

@end
