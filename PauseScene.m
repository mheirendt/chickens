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

// -----------------------------------------------------------------

@implementation PauseScene{
    CCNode *pauseNode;
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
-(void)resumePressed{
    [[CCDirector sharedDirector] popScene];
}
-(void)quitPressed{
    [[CCDirector sharedDirector] popScene];
    [[CCDirector sharedDirector] popScene];
    //CCScene *mainMenu = [CCBReader loadAsScene:@"MainScene"];
    //[[CCDirector sharedDirector] replaceScene:mainMenu];
}
// -----------------------------------------------------------------

@end





