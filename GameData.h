//
//  GameData.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/11/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface GameData : NSObject

// -----------------------------------------------------------------
// properties
@property (assign, nonatomic) long highScore;
@property (assign, nonatomic) long score;
@property (assign, nonatomic) long doubleKills;
// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
+(instancetype)sharedGameData;
-(void)reset;
// -----------------------------------------------------------------

@end




