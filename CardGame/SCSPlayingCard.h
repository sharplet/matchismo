//
//  SCSPlayingCard.h
//  CardGame
//
//  Created by Adam Sharp on 26/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSCard.h"

@interface SCSPlayingCard : SCSCard

@property (strong, nonatomic) NSString * suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSArray *)rankStrings;
+(NSUInteger)maxRank;

@end
