//
//  SCSDeck.h
//  CardGame
//
//  Created by Adam Sharp on 26/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCSCard.h"

@interface SCSDeck : NSObject
-(void)addCard:(SCSCard *)card atTop:(BOOL)atTop;
-(SCSCard *)drawRandomCard;
@end
