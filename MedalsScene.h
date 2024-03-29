//
//  MedalsScene.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/1/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface MedalsScene : CCNode

// -----------------------------------------------------------------
// properties
@property (readwrite, nonatomic) int doubleKills;
@property (readwrite, nonatomic) int tripleKills;
@property (readwrite, nonatomic) int overKills;
// -----------------------------------------------------------------
// methods
-(void)backToMenu;
+ (instancetype)node;
- (instancetype)init;
// -----------------------------------------------------------------

@end




