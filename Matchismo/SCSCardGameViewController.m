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
#import "SCSCardMatchingGame.h"

@interface SCSCardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastFlipResultLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic) NSUInteger flipCount;
@property (strong, nonatomic) SCSCardMatchingGame *game;
@end

@implementation SCSCardGameViewController

-(SCSCardMatchingGame *)game
{
    if (!_game) {
        _game = [[SCSCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                     usingDeck:[[SCSPlayingCardDeck alloc] init]];
        _game.mode = SCSCardMatchingGameMatchMode2Cards;
    }
    return _game;
}

-(void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

#pragma mark - View lifecycle

-(void)viewDidLoad
{
    [self updateUI];
}

#pragma mark - Updating UI

-(void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        SCSCard *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
    }
    self.flipCountLabel.text = [NSString stringWithFormat:@"Flips: %d", _flipCount];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.lastFlipResultLabel.text = [self.game lastFlipResultDescription];
}

#pragma mark - Controller actions

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

- (IBAction)redeal
{
    // reset the game and flip count
    self.flipCount = 0;
    self.game = [[SCSCardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                     usingDeck:[[SCSPlayingCardDeck alloc] init]];

    [self updateUI];
}

- (IBAction)setNumberOfCardsToMatch:(UISegmentedControl *)sender
{
    if (sender.selectedSegmentIndex == 0) {
        self.game.mode = SCSCardMatchingGameMatchMode2Cards;
    }
    else if (sender.selectedSegmentIndex == 1) {
        self.game.mode = SCSCardMatchingGameMatchMode3Cards;
    }
}

@end
