//
//  PlayingCard.h
//  Matchismo
//
//  Created by Arjen Hendrikse on 17/2/13.
//  Copyright (c) 2013 AHE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
