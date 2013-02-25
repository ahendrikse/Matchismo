//
//  Deck.h
//  Matchismo
//
//  Created by Arjen Hendrikse on 17/2/13.
//  Copyright (c) 2013 AHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
