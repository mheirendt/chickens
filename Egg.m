//
//  Egg.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 12/31/15
//
//  Copyright (c) 2015 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Egg.h"

// -----------------------------------------------------------------

@implementation Egg

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
- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"Egg";
}

// -----------------------------------------------------------------

@end





