//
//  SCSCard.h
//  Matchismo
//
//  Created by Adam Sharp on 26/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCSCard : NSObject
@property (strong, nonatomic) NSString * contents;
@property (nonatomic, getter=isFaceUp) BOOL faceUp;
@property (nonatomic, getter=isUnplayable) BOOL unplayable;
-(NSInteger)match:(NSArray *)otherCards;
@end
