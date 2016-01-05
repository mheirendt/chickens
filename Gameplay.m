//
//  Gameplay.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 12/30/15
//
//  Copyright (c) 2015 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Gameplay.h"
#import "CCPhysics+ObjectiveChipmunk.h"
// -----------------------------------------------------------------

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    CCNode *_canon;
    CCLabelTTF *_scoreLabel;
    CCNode *_chicken;
    
}
int killCount = 0;
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

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    
    //CCNode* _chicken = [CCBReader load:@"Chicken"];
    //self.contentSize.width+Chicken.contentSize.width
    _chicken.position = CGPointMake(300, 300);
    id move=[CCActionMoveTo actionWithDuration:2.0f position:ccp(self.contentSize.width-200,_chicken.position.y)];
    [_chicken runAction:[CCActionSequence actions: move, nil]];
    
    if(killCount < 4){
    int minTime = 2.0f;
    int maxTime = 4.0f;
    int rangeTime = maxTime - minTime;
    int randomTime = (arc4random() % rangeTime) + minTime;
    [self schedule:@selector(launchEgg) interval:.5f];
    }
    if(killCount > 4 && killCount<10){
        int minTime = .3f;
        int maxTime = 2.0f;
        int rangeTime = maxTime - minTime;
        int randomTime = (arc4random() % rangeTime) + minTime;
        [self schedule:@selector(launchEgg) interval:randomTime];
    }
    if(killCount >= 10){
        int minTime = .05f;
        int maxTime = .3f;
        int rangeTime = maxTime - minTime;
        int randomTime = (arc4random() % rangeTime) + minTime;
        [self schedule:@selector(launchEgg) interval:randomTime];
    }

}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    CGPoint touchLocation = [touch locationInNode:self];
    CCNode* bullet = [CCBReader load:@"Bullet"];
    bullet.position = touchLocation;
    [_physicsNode addChild:bullet];
    CCActionRemove *actionRemove = [CCActionRemove action];
    id delay = [CCActionDelay actionWithDuration:.0001f];
    [bullet runAction:[CCActionSequence actionWithArray:@[delay, actionRemove]]];

}

- (void)launchEgg {
    CCNode* egg = [CCBReader load:@"Egg"];
    egg.position = ccpAdd(_canon.position, ccp(-27, 50));
    [_physicsNode addChild:egg];
    egg.scale = 0.6f;
    egg.rotation = -45.0f;
    int minx = -11;
    int miny = 5;
    int maxx = -12;
    int maxy = 15;
    int rangex = maxx - minx;
    int rangey = maxy - miny;
    int randomx = (arc4random() % rangex) + minx;
    int randomy = (arc4random() % rangey) + miny;
    CGPoint launchDirection = ccp(-10,randomy);
    int minforce = 500;
    int maxforce = 3000;
    int rangeforce = maxforce - minforce;
    int randomforce = (arc4random() % rangeforce) + minforce;
    CGPoint force = ccpMult(launchDirection, randomforce);
    [egg.physicsBody applyForce:force];
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Egg:(CCNode *)nodeA Bullet:(CCNode *)nodeB {
    float energy = [pair totalKineticEnergy];
    if (energy > .00001f) {
        [[_physicsNode space] addPostStepBlock:^{
            [self eggRemoved:nodeA];
        } key:nodeA];
    }
}
- (void)eggRemoved:(CCNode *)egg {
    CCNode *explosion = (CCNode *)[CCBReader load:@"LeftShot"];
    killCount++;
    CCLOG(@"Score: %d", killCount);
    [_scoreLabel setString:[NSString stringWithFormat:@"Score: %d", killCount]];
    explosion.scale = 0.6f;
    explosion.position = egg.position;
    [egg.parent addChild:explosion];
    CCActionRemove *actionRemove = [CCActionRemove action];
    id delay = [CCActionDelay actionWithDuration:2.5f];
    [explosion runAction:[CCActionSequence actionWithArray:@[delay, actionRemove]]];
    [egg removeFromParent];
    
    if (killCount == 2){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
        [self rewardMedal:spree andLabel:@"Spree"];
    }
    else if (killCount == 4){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/40.png"];
        [self rewardMedal:spree andLabel:@"frenzy"];
    }
    else if (killCount == 6){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/60.png"];
        [self rewardMedal:spree andLabel:@"Running Riot"];
    }
    else if (killCount == 8){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/80.png"];
        [self rewardMedal:spree andLabel:@"Psycho"];
    }
    else if (killCount == 10){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/100.png"];
        [self rewardMedal:spree andLabel:@"Unstoppable"];
    }
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Bullet:(CCNode *)nodeA Chicken:(CCNode *)nodeB {
    CCLOG(@"YAY");
}


-(void)rewardMedal:(CCSprite *)medalType andLabel:(CCLabelTTF*)label {
    medalCount+=1;
    CCLOG(@"%d", medalCount);
    //medalType = [CCSprite spriteWithImageNamed:@"Assets/2.png"];
    medalType.positionType = CCPositionTypeNormalized;
    if(medalCount == 1){
        medalType.position = ccp(.5f, .03f);
    }else if (medalCount==2){
        medalType.position = ccp(.5f, .2f);
    }else if (medalCount==3){
        medalType.position = ccp(.5f, .35f);
    }else if (medalCount==4){
        medalType.position = ccp(.1f, .05f);
    }else if (medalCount==5){
        medalType.position = ccp(.1f, .2f);
    }else if (medalCount==6){
        medalType.position = ccp(.1f, .35f);
    }
    
    medalType.anchorPoint = ccp(.5f, .001f);
    [self runAction:[CCActionFadeIn actionWithDuration:0.4]];
    [self addChild:medalType];
    
    label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",label] fontName:@"Verdana-Bold" fontSize:16.0f];
    label.positionType = CCPositionTypeNormalized;
    if(medalCount == 1){
        label.position = ccp(.6f, .1f);
    }else if (medalCount==2){
        label.position = ccp(.6f, .25f);
    }else if (medalCount==3){
        label.position = ccp(.6f, .4f);
    }else if (medalCount==4){
        label.position = ccp(.2f, .1f);
    }else if (medalCount==5){
        label.position = ccp(.2f, .25f);
    }else if (medalCount==6){
        label.position = ccp(.2f, .4f);
    }
    [self addChild:label];
    
    CCActionDelay *delay =  [CCActionDelay actionWithDuration:1];
    CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
        [self removeChild:medalType];
        [self removeChild:label];
        medalCount-=1;
    }];
    [self runAction:[CCActionSequence actions:delay, block, nil]];
}
-(void)pauseScene{
    CCScene *pauseScene = [CCBReader loadAsScene:@"PauseScene"];
    [[CCDirector sharedDirector] pushScene:pauseScene];
}


// -----------------------------------------------------------------

@end





