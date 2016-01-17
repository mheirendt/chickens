//
//  GameOver.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/10/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface GameOver : CCNode

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
+ (instancetype)sharedGameData;
-(void)retryPressed;
-(void)backPressed;
-(void)addHighScore;
-(void)assignRank;
// -----------------------------------------------------------------

@end




