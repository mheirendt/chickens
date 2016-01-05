//
//  Chicken.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/1/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Chicken.h"

// -----------------------------------------------------------------

@implementation Chicken

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
- (void)didLoadFromCCB {
    self.physicsBody.collisionType = @"Chicken";
}


// -----------------------------------------------------------------

@end





