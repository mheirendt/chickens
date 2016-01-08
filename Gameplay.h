//
//  Gameplay.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 12/30/15
//
//  Copyright (c) 2015 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface Gameplay : CCNode <CCPhysicsCollisionDelegate>{
    int medalCount;
    int targetsLaunched;
}
// -----------------------------------------------------------------
// properties
// -----------------------------------------------------------------
// methods
+ (instancetype)node;
- (instancetype)init;
//-(void)addChicken:(CGPoint*)position androtation:(float)rotation;
-(void)pauseScene;
-(void)newRound:(NSString*)round;
-(void)initRound:(int)number;
// -----------------------------------------------------------------

@end




