//
//  PauseScene.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/2/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "PauseScene.h"
#import "GameData.h"

// -----------------------------------------------------------------

@implementation PauseScene{
    CCNode *pauseNode;
    CCLabelTTF *user;
    CCLabelTTF *rank;
    CCSprite *icon;
    CCProgressNode *_progressNode;
    CCSprite *progress;
}

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
-(void)onEnter{
    [super onEnter];
    [[GameData sharedGameData]summarizeRank:rank andUser:user andRankIcon:icon];

}
-(void)resumePressed{
    [[CCDirector sharedDirector] popScene];
}
-(void)restartPressed{
    [GameData sharedGameData].roundScore = 0;
    [[GameData sharedGameData] reset];
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] popScene];
    CCScene *game = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] pushScene:game];
}
-(void)quitPressed{
    [GameData sharedGameData].roundScore = 0;
    [[GameData sharedGameData]reset];
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] popScene];
    if ([GameData sharedGameData].newPlayerFlag){
        [GameData sharedGameData].newPlayerFlag = false;
    }
}
// -----------------------------------------------------------------

@end





