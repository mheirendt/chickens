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
#import "AlertView.h"

// -----------------------------------------------------------------

@implementation PauseScene{
    CCNode *pauseNode;
    CCLabelTTF *user;
    CCLabelTTF *rank;
    CCSprite *icon;
    CCProgressNode *_progressNode;
    CCSprite *progress;
    id block;
    CCButton *play;
    CCButton *restart;
    CCButton *quit;
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
    play.enabled = false;
    restart.enabled = false;
    quit.enabled = false;
    [AlertView ShowAlert:@"Are you sure you want to restart? All progress will be lost." onLayer:self withOpt1:@"Yes" withOpt1Block:^(void){
        [GameData sharedGameData].roundScore = 0;
        [[GameData sharedGameData] reset];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] popScene];
        CCScene *game = [CCBReader loadAsScene:@"Gameplay"];
        [[CCDirector sharedDirector] pushScene:game];
    } andOpt2:@"Cancel" withOpt2Block:^(void){
        play.enabled = true;
        restart.enabled = true;
        quit.enabled = true;
    }];
}
-(void)quitPressed{
    play.enabled = false;
    restart.enabled = false;
    quit.enabled = false;
    [AlertView ShowAlert:@"Are you sure you want to quit? All progress will be lost." onLayer:self withOpt1:@"Yes" withOpt1Block:^(void){
        [GameData sharedGameData].roundScore = 0;
        [[GameData sharedGameData]reset];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] popScene];
        if ([GameData sharedGameData].newPlayerFlag){
            [GameData sharedGameData].newPlayerFlag = false;
        }
    } andOpt2:@"Cancel" withOpt2Block:^(void){
        play.enabled = true;
        restart.enabled = true;
        quit.enabled = true;
    }];
}

// -----------------------------------------------------------------

@end





