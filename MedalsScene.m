//
//  MedalsScene.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/1/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "MedalsScene.h"
#import "TableView.h"
#import "GameData.h"

// -----------------------------------------------------------------

@implementation MedalsScene{

}
@synthesize doubleKills;
@synthesize tripleKills;
@synthesize overKills;
// -----------------------------------------------------------------

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    self.doubleKills = 0;
    TableView *table = [TableView node];
    table.contentSizeType = CCSizeTypeNormalized;
    table.positionType = CCPositionTypeNormalized;
    table.position = ccp(.2f,-0.01f);
    table.contentSize = CGSizeMake(1, 1);
    table.zOrder = 1000;
    [self addChild:table];
    
    return self;
}

-(void)backToMenu{
    //CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    //[[CCDirector sharedDirector] replaceScene:gameplayScene];
    [GameData sharedGameData].tableID = 0;
    [[CCDirector sharedDirector] popScene];
}

// -----------------------------------------------------------------

@end





