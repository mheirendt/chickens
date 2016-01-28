//
//  AlertView.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/26/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"

// -----------------------------------------------------------------

@interface AlertView : CCNode

// -----------------------------------------------------------------
// properties
// -----------------------------------------------------------------
// methods

//+ (instancetype)node;
//- (instancetype)init;

+ (void)ShowAlert: (NSString*) message onLayer: (CCNode *) layer
         withOpt1: (NSString*) opt1 withOpt1Block: (void(^)())opt1Block
          andOpt2: (NSString*) opt2 withOpt2Block: (void(^)())opt2Block;

// -----------------------------------------------------------------

@end




