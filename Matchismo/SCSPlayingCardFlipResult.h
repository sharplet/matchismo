//
//  SCSFlipResult.h
//  Matchismo
//
//  Created by Adam Sharp on 7/02/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SCSCardFlipResult) {
    SCSCardFlipResultFlippedFaceUp,
    SCSCardFlipResultFlippedFaceDown,
    SCSCardFlipResultMatched,
    SCSCardFlipResultNotMatched
};

@interface SCSPlayingCardFlipResult : NSObject

@property (readonly, nonatomic) SCSCardFlipResult resultType;
@property (readonly, strong, nonatomic) NSArray *cards; // of SCSPlayingCard
@property (readonly, nonatomic) NSInteger score;

+(SCSPlayingCardFlipResult *)flipResultOfType:(SCSCardFlipResult)result;
+(SCSPlayingCardFlipResult *)flipResultOfType:(SCSCardFlipResult)result
                                    withCards:(NSArray *)cards
                                        score:(NSInteger)score;

// designated initialiser
//
// NOTE: -init will *always* return nil -- the designated initialiser
// must be used.
-(id)initWithFlipResultType:(SCSCardFlipResult)resultType
                      cards:(NSArray *)cards
                      score:(NSInteger)score;

-(NSString *)resultDescription;

@end
