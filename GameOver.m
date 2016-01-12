//
//  GameOver.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/10/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameOver.h"
#import "GameData.h"
// -----------------------------------------------------------------

@implementation GameOver{

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

    // class initalization goes here
    return self;
}
-(void) onEnter
{
    [super onEnter];
    NSString *doubles = [NSString stringWithFormat:@"%li", [GameData sharedGameData].score];
    CCLabelTTF* count = [CCLabelTTF labelWithString:doubles fontName:@"HelveticaNeue" fontSize:30];
    count.positionType = CCPositionTypeNormalized;
    count.position = ccp(.5f,.4f);
    
    [GameData sharedGameData].highScore = MAX([GameData sharedGameData].score,
                                                [GameData sharedGameData].highScore);
    
    [self addChild:count];
}
-(void)retryPressed{
    [[GameData sharedGameData] reset];
    [[CCDirector sharedDirector] popScene];
    CCScene *game = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] pushScene:game];
}
-(void)backPressed{
    [[GameData sharedGameData] reset];
    [[CCDirector sharedDirector] popScene];
    //[[CCDirector sharedDirector] popScene];
    //CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    //[[CCDirector sharedDirector] pushScene:MainScene];
}

// -----------------------------------------------------------------

@end





