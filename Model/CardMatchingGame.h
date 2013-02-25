//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Arjen Hendrikse on 19/2/13.
//  Copyright (c) 2013 AHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (id)initWithCardCount:(NSUInteger)cardCount usingDeck:(Deck *)deck;

- (void)flipCardAtIndex:(NSUInteger)index;

- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) int score;
@property (nonatomic, strong) Card *lastOpenCard1;
@property (nonatomic, strong) Card *lastOpenCard2;
@property (nonatomic) int lastScore;


@end
