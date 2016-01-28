//
//  Ranks.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/26/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Ranks.h"
#import "RankTable.h"


// -----------------------------------------------------------------

@implementation Ranks
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
    
    RankTable *table = [RankTable node];
    table.contentSizeType = CCSizeTypeNormalized;
    table.positionType = CCPositionTypeNormalized;
    table.position = ccp(.2f,0.32f);
    table.contentSize = CGSizeMake(1.f, 1.f);
    table.zOrder = 1000;
    [self addChild:table];
    
    
    return self;
}
-(void)backPressed{
    [[CCDirector sharedDirector] popScene];
}

// -----------------------------------------------------------------

@end





