//
//  SCSCard.m
//  CardGame
//
//  Created by Adam Sharp on 26/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSCard.h"

@interface SCSCard()

@end

@implementation SCSCard

-(NSInteger)match:(NSArray *)otherCards {
    NSInteger score = 0;
    for (SCSCard * card in otherCards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
