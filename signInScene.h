//
//  signInScene.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/13/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface signInScene : CCNode

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
+ (instancetype)sharedGameData;
- (instancetype)init;
- (NSString *)buttonText:(CCTextField*)sender;
-(void)createPressed;

// -----------------------------------------------------------------

@end




