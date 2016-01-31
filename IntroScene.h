//
//  IntroScene.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/29/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCVideoPlayer.h"

// -----------------------------------------------------------------

@interface IntroScene : CCNode <CCVideoPlayerDelegate>

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;

// -----------------------------------------------------------------

@end




