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
#import "TableView.h"


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


-(void)addChicken:(float)x y:(float)y androtation:(float)rotation andMoveToX:(float)movex andMoveToY:(float)movey;
- (void)launchEgg;
-(void)flyingChicken;
-(void)dropEgg:(CCNode*)flying;
-(void)roundComplete;
-(void)_continuePressed;
- (void)launchEggTopRight;
-(void)newRound:(NSString*)round;
-(void)initRound:(int)number;
-(void)rewardMedal:(CCSprite *)medalType andLabel:(NSString*)input andExp:(int)exp;
-(void)pauseScene;
-(void)bombPressed;
-(void)armoryPressed;
-(void)bombPurchased;
-(void)repairPurchased;
-(void)bladePressed;
// -----------------------------------------------------------------

@end




