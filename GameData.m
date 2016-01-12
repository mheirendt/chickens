//
//  GameData.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/11/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameData.h"
// -----------------------------------------------------------------

@implementation GameData

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

+ (instancetype)sharedGameData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}
-(void)reset
{
    self.score = 0;
}

// -----------------------------------------------------------------

@end





