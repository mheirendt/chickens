//
//  IntroScene.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/29/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "IntroScene.h"

// -----------------------------------------------------------------

@implementation IntroScene{
    CCLabelTTF *name;
    CCSprite *logo;
}

// -----------------------------------------------------------------

+ (instancetype)node
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    
    return self;
}
-(void)onEnter{
    [super onEnter];
    CCNode* flying = [CCBReader load:@"Flying"];
    flying.positionType = CCPositionTypeNormalized;
    flying.position = ccp(1.3f,.7f);
    [self addChild:flying];
    CCLOG(@"POSITION:%f, %f",flying.position.x,flying.position.y);
    ccBezierConfig bez;
    bez.controlPoint_1 = ccp(.7f,.4f);
    bez.controlPoint_2 = ccp(.4f,.4f);
    bez.endPosition = ccp(0.f, 1.3f);
    CCActionBezierTo *bezier = [CCActionBezierTo actionWithDuration:2.5f bezier:bez];
    CCAction *delay = [CCActionDelay actionWithDuration:1.f];
    CCActionRemove * removeCK = [CCActionRemove action];
    [flying runAction:[CCActionSequence actions:delay, bezier, removeCK, nil]];
    name = [CCLabelTTF labelWithString:@"Produced by: Michael Heirendt" fontName:@"Comic Sans" fontSize:32 dimensions:CGSizeMake(280.f, 200.f)];
    name.positionType = CCPositionTypeNormalized;
    name.position = ccp(1.3f,.15f);
    [self addChild:name];
    CCActionFadeIn *delay1 = [CCActionFadeIn actionWithDuration:.5f];
    CCActionMoveTo *slide = [CCActionMoveTo actionWithDuration:5.f position:ccp(-.8f,.15f)];
    CCActionRemove *removeName = [CCActionRemove action];
    [name runAction:[CCActionSequence actions:delay1,slide,removeName,nil]];
    CCLabelTTF *by = [CCLabelTTF labelWithString:@"by" fontName:@"Comic Sans" fontSize:32];
    CCActionRotateTo *rotate = [CCActionRotateTo actionWithDuration:.05f angle:35.f];
    ccBezierConfig bezLab1;
    bezLab1.controlPoint_1 = ccp(190,150);
    bezLab1.controlPoint_2 = ccp(100,250);
    bezLab1.endPosition = ccp(-70, 430);
    CCActionBezierTo *bezier1 = [CCActionBezierTo actionWithDuration:1.6f bezier:bezLab1];
    CCActionDelay *grab1Delay = [CCActionDelay actionWithDuration:2.f];
    CCActionCallBlock *block1 = [CCActionCallBlock actionWithBlock:^(void){
        [name setString:@"Produced   : Michael Heirendt"];
        by.positionType = CCPositionTypePoints;
        by.position = ccp(400,145);
        [self addChild:by];
    }];
    CCActionRotateTo *rotateCK = [CCActionRotateTo actionWithDuration:.8f angle:35.f];
    CCActionDelay *CKdelay = [CCActionDelay actionWithDuration:1.8f];
    [flying runAction:[CCActionSequence actions:CKdelay, rotateCK, nil]];
    [self runAction:[CCActionSequence actions:grab1Delay, block1, nil]];
    [by runAction:[CCActionSequence actions:rotate, bezier1,removeCK,nil]];
    CCActionDelay* sceneLength = [CCActionDelay actionWithDuration:6.f];
    CCActionCallBlock *transition = [CCActionCallBlock actionWithBlock:^(void){
        [self playVideo];
    }];
    [self runAction:[CCActionSequence actions:sceneLength, transition, nil]];
}
-(void)playVideo{
    CCLOG(@"video Playing");
    [CCVideoPlayer setDelegate: self];
    [CCVideoPlayer playMovieWithFile: @"intro.mp4"];
    logo.visible = false;
}
- (void) moviePlaybackFinished
{
    [[CCDirector sharedDirector] startAnimation];
    [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"MainScene"]];
}

- (void) movieStartsPlaying
{
    [[CCDirector sharedDirector] stopAnimation];
}

// -----------------------------------------------------------------

@end





