//
//  SCSCardGameViewController.m
//  Matchismo
//
//  Created by Adam Sharp on 30/01/13.
//  Copyright (c) 2013 Adam Sharp. All rights reserved.
//

#import "SCSCardGameViewController.h"
#import "SCSCard.h"
#import "SCSDeck.h"

@interface SCSCardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (nonatomic) NSUInteger flipCount;
@property (strong, nonatomic) SCSDeck *deck;
@end

@implementation SCSCardGameViewController

-(SCSDeck *)deck
{
    if (!_deck) {
        _deck = [[SCSPlayingCardDeck alloc] init];
    }
    return _deck;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    for (UIButton *button in self.cardButtons) {
        SCSCard *card = [self.deck drawRandomCard];
        [button setTitle:card.contents forState:UIControlStateSelected];
    }
}

-(void)setFlipCount:(NSUInteger)flipCount
{
    _flipCount = flipCount;
    self.flipCountLabel.text = [NSString stringWithFormat:@"Flips: %d", _flipCount];
}

- (IBAction)flipCard:(UIButton *)sender
{
    sender.selected = !sender.isSelected;
    self.flipCount++;
}

@end
