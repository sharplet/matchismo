//
//  SCSCardGameViewController.m
//  Matchismo
//
//  Created by Adam Sharp on 30/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSCardGameViewController.h"
#import "SCSCard.h"

@interface SCSCardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (nonatomic) NSUInteger flipCount;
@end

@implementation SCSCardGameViewController

-(SCSPlayingCardDeck *)deck
{
    if (!_deck) {
        _deck = [[SCSPlayingCardDeck alloc] init];
    }
    return _deck;
}

-(void)setFlipCount:(NSUInteger)flipCount
{
    _flipCount = flipCount;
    self.flipCountLabel.text = [NSString stringWithFormat:@"Flips: %d", _flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        SCSCard *card = [self.deck drawRandomCard];
        [sender setTitle:card.contents forState:UIControlStateSelected];
    }
    self.flipCount++;
}

@end
