//
//  HighScoresScene.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/1/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "HighScoresScene.h"

// -----------------------------------------------------------------

@implementation HighScoresScene

// -----------------------------------------------------------------

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);

    return self;
}

-(void)backToMenu{
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

// -----------------------------------------------------------------

@end





