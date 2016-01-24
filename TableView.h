//
//  TableView.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/7/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "Gameplay.h"

// -----------------------------------------------------------------

@interface TableView : CCNode <CCTableViewDataSource>

// -----------------------------------------------------------------
// properties
// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
-(void)createUser;
// -----------------------------------------------------------------

@end




