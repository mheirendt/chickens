//
//  LowAlert.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 2/7/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface LowAlert : CCNode

// -----------------------------------------------------------------
// properties

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;

- (void)ShowAlertOnLayer: (CCNode *) layer;
+ (void) dismiss: (CCSprite*) alertDialog onCoverLayer: (CCNode*) coverLayer executingBlock: (void(^)())block ;
-(void)changeColor:(int)color;
// -----------------------------------------------------------------

@end




