//
//  Users.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/28/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Users.h"
#import "UsersTable.h"
#import "GameData.h"

// -----------------------------------------------------------------

@implementation Users

// -----------------------------------------------------------------

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    UsersTable *table = [UsersTable node];
    table.contentSizeType = CCSizeTypeNormalized;
    table.positionType = CCPositionTypeNormalized;
    table.position = ccp(.2f,-0.01f);
    table.contentSize = CGSizeMake(1, 1);
    table.zOrder = 1000;
    [self addChild:table];
    
    return self;
}
-(void)createUser{
    [GameData sharedGameData].tableID = 3;
    CCScene *gameplayScene = [CCBReader loadAsScene:@"SignIn"];
    [[CCDirector sharedDirector] pushScene:gameplayScene];
}
-(void)backPressed{
    [[CCDirector sharedDirector] popScene];
}


// -----------------------------------------------------------------

@end





