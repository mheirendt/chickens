//
//  PauseScene.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/2/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface PauseScene : CCNode

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
-(void)resumePressed;
-(void)quitPressed;
// -----------------------------------------------------------------

@end




