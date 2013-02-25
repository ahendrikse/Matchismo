//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Arjen Hendrikse on 17/2/13.
//  Copyright (c) 2013 AHE. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *flipResultLabel;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameComplexity;
@property (nonatomic) int gameMode;
@end

@implementation CardGameViewController

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:self.cardButtons.count usingDeck:[[PlayingCardDeck alloc] init]];
    return _game;
}

- (void)setCardButtons:(NSArray *)cardButtons
{
    _cardButtons = cardButtons;
    [self updateUI];
}

- (IBAction)resetGame:(UIButton *)sender {
    self.game = nil;
    self.flipCount = 0;
    [self updateUI];
    self.gameComplexity.enabled = YES;

}

- (NSString *)resultString
{
    NSString *temp = @"";
    id openCard1 = self.game.lastOpenCard1.contents;
    id openCard2 = self.game.lastOpenCard2.contents;
    int lastScore = self.game.lastScore;
    
    if (self.game.lastOpenCard2) { //2 card on the table
        if (self.game.lastScore>0) { // won
            temp = [NSString stringWithFormat:@"Matched %@ %@ for %d points", openCard1, openCard2, lastScore];
        } else //lost
         temp = [NSString stringWithFormat:@"%@ %@ don't match. %d point penalty!", openCard1, openCard2, -lastScore];
    } else if (self.game.lastOpenCard1)   //only 1 card on table
         temp = [NSString stringWithFormat:@"Flipped up %@", openCard1];
    return temp;
}

- (void)updateUI
{
    UIImage *cardBackImage = [UIImage imageNamed:@"cardback.png"];
    for (UIButton *cardButton in self.cardButtons) {
        Card *card = [self.game cardAtIndex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        cardButton.selected = card.isFaceUp;
        cardButton.enabled = !card.isUnplayable;
        cardButton.alpha = card.isUnplayable ? 0.3 : 1.0;
        
        UIEdgeInsets inset;
        inset.top = 2;
        inset.left = 2;
        inset.bottom = 10;
        inset.right = 10;
        cardButton.imageEdgeInsets = inset;
        [cardButton setImage:cardBackImage forState:UIControlStateNormal];
        if (card.isFaceUp) {
            [cardButton setImage:nil forState:UIControlStateNormal];
        }
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.flipResultLabel.text = [self resultString];
}

- (void)setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    if (self.flipCount > 0) self.gameComplexity.enabled = NO;
}

- (IBAction)flipCard:(UIButton *)sender
{
    [self.game flipCardAtIndex:[self.cardButtons indexOfObject:sender]];
    self.flipCount++;
    [self updateUI];
}

@end
