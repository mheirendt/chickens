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
}
// -----------------------------------------------------------------
// properties
// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
-(void)pauseScene;
// -----------------------------------------------------------------

@end




