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
#import "GameData.h"

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
-(void) onEnter
{
    [super onEnter];
    NSString *doubles = [NSString stringWithFormat:@"%li", [GameData sharedGameData].highScore];
    CCLabelTTF* count = [CCLabelTTF labelWithString:doubles fontName:@"HelveticaNeue" fontSize:30];
    count.positionType = CCPositionTypeNormalized;
    count.position = ccp(.5f,.4f);
    
    [self addChild:count];
}

// -----------------------------------------------------------------

@end





