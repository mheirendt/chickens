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
#import "GameData.h"
// -----------------------------------------------------------------

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;
    CCNode *_canon;
    CCLabelTTF *_scoreLabel;
    CCNode *_barn;
    //CCNode *chicken;
    CCTime _timeSinceLastCollision;
    int roundCount;
    int killCount;
    int shotCount;
    int medalId;
    float _health;
    
    CCProgressNode *_progressNode;
    CCNode *overlay;
    CCLabelTTF *complete;
    CCButton *_nextRoundButton;
    CCButton *_buyBombsButton;
    CCButton *_repairButton;
    
    CCLabelTTF *_upgradesLabel;
    CCLabelTTF *_costLabel;
    CCSprite *_costRepair1;
    CCSprite *_costRepair2;
    CCSprite *_costBomb;
    CCButton *_pauseButton;
    CCButton *_bomb;
    CCLabelTTF *_bombCount;
    CCSprite *bomb;
    CCLabelTTF *_nukes;
    CCLabelTTF *_repairs;
    CCSprite *_gold;
    CCLabelTTF *_goldCount;
    
    
    
    CCLabelTTF *rank;
    CCLabelTTF *user;
    CCSprite *icon;
    CCSprite *base;
    CCProgressNode *_progress;
    CCLabelTTF *nextRound;
    
    int gameCurrency;
    
    int exp;
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
    _timeSinceLastCollision= 0.0;
    return self;
}

- (void)didLoadFromCCB {
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    _health = 100.f;
    roundCount=1;
    [self newRound:[NSString stringWithFormat:@"Round %d",roundCount]];
    [self initRound:roundCount];
    [self addChicken:(self.contentSize.width + 150) y:104.f androtation:0.f andMoveToX:self.contentSize.width - 100 andMoveToY:104.f];
    //int minTime = 2.0f;
    //int maxTime = 4.0f;
    //int rangeTime = maxTime - minTime;
    //int randomTime = (arc4random() % rangeTime) + minTime;
    
    overlay.visible = false;
    
    _physicsNode.positionType=CCPositionTypeNormalized;
    _physicsNode.position = ccp(.5f,.5f);
    
    _barn.physicsBody.collisionType=@"Barn";
    
    [_bombCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bombCount]];
    
    CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Assets/_100.png"];
    _progressNode = [CCProgressNode progressWithSprite:sprite];
    _progressNode.type = CCProgressNodeTypeBar;
    _progressNode.midpoint = ccp(0.0f, 0.0f);
    _progressNode.barChangeRate = ccp(1.0f, 0.0f);
    _progressNode.percentage = 100.0f;
    _progressNode.zOrder = 100001;
    
    _progressNode.positionType = CCPositionTypeNormalized;
    _progressNode.position = ccp(0.12f, 0.1f);
    [self addChild:_progressNode];

}
//x:526.000000(568), y:104.000000
////Automate addition of a canon to be added at later rounds

-(void)addChicken:(float)x y:(float)y androtation:(float)rotation andMoveToX:(float)movex andMoveToY:(float)movey{
    CCNode* chicken = [CCBReader load:@"Canon"];
    CGPoint point =  CGPointMake(x,y);
    chicken.position = point;
    chicken.rotation = rotation;
    id moveCk=[CCActionMoveTo actionWithDuration:2.0f position:ccp(movex,movey)];
    id delay = [CCActionDelay actionWithDuration: .5f];
    [self addChild:chicken];
    [chicken runAction:[CCActionSequence actions: delay, moveCk, nil]];
    //int minTime = 2.0f;
    //int maxTime = 4.0f;
    //int rangeTime = maxTime - minTime;
    //int randomTime = (arc4random() % rangeTime) + minTime;
    //[self schedule:@selector(launchEgg) interval:randomTime repeat:9 delay:.2f];
    
    
}
-(void)flyingChicken{
    CCNode* flying = [CCBReader load:@"Flying"];
    flying.positionType = CCPositionTypeNormalized;
    flying.position = ccp(.95f,1.2f);
    [self addChild:flying];
    ccBezierConfig bez;
    bez.controlPoint_1 = ccp(.7f,.3f);
    bez.controlPoint_2 = ccp(.4f,.5f);
    bez.endPosition = ccp(0.f, 1.3f);
    CCActionBezierTo *bezier = [CCActionBezierTo actionWithDuration:2.5f bezier:bez];
    [flying runAction:bezier];
    
    int minTime = .7 * 1000;
    int maxTime = 1.8 * 1000;
    int rangeTime = maxTime - minTime;
    int a = (arc4random() % rangeTime) + minTime;
    float randomTime = a/1000.f;
        CCLOG(@"%f", randomTime);
    CCActionDelay *delay = [CCActionDelay actionWithDuration:randomTime];
    CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
        [self dropEgg:flying];
    }];
    [self runAction:[CCActionSequence actions:delay,block,nil]];
}
-(void)dropEgg:(CCNode*)flying{
    CCNode *gold = [CCBReader load:@"Gold"];
    gold.physicsBody.collisionType = @"Gold";
    gold.positionType = CCPositionTypeNormalized;
    gold.scale = .5f;
    gold.position = flying.position;
    
    CGPoint launchDirection = ccp(gold.position.x-10,gold.position.y-10);
    int minforce = 500;
    int maxforce = 2000;
    int rangeforce = maxforce - minforce;
    int randomforce = (arc4random() % rangeforce) + minforce;
    CGPoint force = ccpMult(launchDirection, randomforce);
    [_physicsNode addChild:gold];
    [gold.physicsBody applyForce:force];

}
-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Bullet:(CCNode *)nodeA Gold:(CCNode *)nodeB{
        [[_physicsNode space] addPostStepBlock:^{
            gameCurrency++;
            nodeB.positionType = CCPositionTypeNormalized;
            nodeB.physicsBody.sensor = true;
            CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.5f position:ccp(nodeB.position.x, 1.1f)];
            CCActionRemove *actionRemove = [CCActionRemove action];
            [nodeB runAction:[CCActionSequence actionWithArray:@[lift, actionRemove]]];
            //[nodeB removeFromParent];
    } key:nodeB];
}



- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    if (self.userInteractionEnabled){
        shotCount ++;
        CGPoint touchLocation = [touch locationInNode:self];
        CCNode* bullet = [CCBReader load:@"Bullet"];
        bullet.visible = false;
        bullet.scale = .6;
        bullet.position = touchLocation;
        [_physicsNode addChild:bullet];
        CCActionRemove *actionRemove = [CCActionRemove action];
        id delay = [CCActionDelay actionWithDuration:.000001f];
        [bullet runAction:[CCActionSequence actionWithArray:@[delay, actionRemove]]];
    }

}
-(void)bombPurchased{
    if (gameCurrency>=1){
        [GameData sharedGameData].bombCount++;
        gameCurrency-=1;
        [_bombCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bombCount]];
    }
    else{
        CCLOG(@"NEED MORE MONEY");
    }
}
-(void)repairPurchased{
    
}
- (void)launchEggTopRight {
    CCNode* egg = [CCBReader load:@"Egg"];
    egg.positionType = CCPositionTypePoints;
    egg.position = ccp(540.f,300.f);
    [_physicsNode addChild:egg];
    egg.scale = 0.6f;
    egg.rotation = -45.0f;
    int miny = 0;
    int maxy = 1;
    int rangey = maxy - miny;
    int randomy = (arc4random() % rangey) + miny;
    CGPoint launchDirection = ccp(-10,randomy);
    int minforce = 3000;
    int maxforce = 5000;
    int rangeforce = maxforce - minforce;
    int randomforce = (arc4random() % rangeforce) + minforce;
    CGPoint force = ccpMult(launchDirection, randomforce);
    [egg.physicsBody applyForce:force];

}

-(void)newRound:(NSString*)round{
    CCLabelTTF *label = [CCLabelTTF labelWithString:(round) fontName:(nil) fontSize:(100)];
    label.positionType = CCPositionTypeNormalized;
    label.position = ccp(.5f,0.5f);
    label.opacity = 0.f;
    [self addChild:label];
    CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.4f];
    CCActionDelay *delay2 = [CCActionDelay actionWithDuration:2.5f];
    CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:1.2f position:ccp(.5f,1.5f)];
    CCActionRemove *remove = [CCActionRemove action];
    int miny = 1;
    int maxy = 3;
    int rangey = maxy - miny;
    int randomy = (arc4random() % rangey) + miny;
    if (randomy == 2){
        CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
            [self flyingChicken];
        }];
        int min = 5;
        int max = 15;
        int range = max - min;
        int random = (arc4random() % range) + min;
        CCActionDelay *delay = [CCActionDelay actionWithDuration:random];
        [self runAction:[CCActionSequence actions:delay, block, nil]];
    }
    
    [label runAction:[CCActionSequence actions:fade,delay2,lift,remove, nil]];
}

-(void)initRound:(int)number{
    switch (number){
case 1:
        [self schedule:@selector(launchEgg) interval:2.f repeat:9 delay:5.f];
        break;

case 2:
        [self schedule:@selector(launchEgg) interval:1.0f repeat:9 delay:5.f];
        break;
case 3:
        [self schedule:@selector(launchEgg) interval:.7f repeat:19 delay:5.f];
        [self addChicken:self.contentSize.width+50 y:self.contentSize.height-100 androtation:-45 andMoveToX:self.contentSize.width andMoveToY:self.contentSize.height-100];
        [self schedule:@selector(launchEggTopRight) interval:.7f repeat:19 delay:7.5f];
        break;
case 4:
        [self schedule:@selector(launchEgg) interval:.5f repeat:49 delay:5.f];
            [self schedule:@selector(launchEggTopRight) interval:.5f repeat:49 delay:6.f];
        break;
case 5:
        [self schedule:@selector(launchEgg) interval:.4f repeat:99 delay:5.f];
            [self schedule:@selector(launchEggTopRight) interval:.4f repeat:99 delay:6.5f];
        break;
case 6:
        [self schedule:@selector(launchEgg) interval:.3f repeat:99 delay:5.f];
            [self schedule:@selector(launchEggTopRight) interval:.3f repeat:99 delay:7.f];
        break;
case 7:
        [self schedule:@selector(launchEgg) interval:.2f repeat:99 delay:5.f];
            [self schedule:@selector(launchEggTopRight) interval:.2f repeat:99 delay:7.f];
        break;
case 8:
        [self schedule:@selector(launchEgg) interval:.1f repeat:114 delay:5.f];
            [self schedule:@selector(launchEggTopRight) interval:.1f repeat:114 delay:7.f];
        break;
    }
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Egg:(CCNode *)nodeA Bullet:(CCNode *)nodeB {
    _timeSinceLastCollision = 0.0;
    medalId++;
    [GameData sharedGameData].score++;
        [[_physicsNode space] addPostStepBlock:^{
            [self eggRemoved:nodeA];
        } key:nodeA];
    if(medalId==3){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/2.png"];
        [self rewardMedal:spree andLabel:@"Double Kill" andExp:5];    }
    else if(medalId==5){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/3.png"];
        [self rewardMedal:triple andLabel:@"Triple Kill" andExp:5];
    }
    else if(medalId==7){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/4.png"];
        [self rewardMedal:triple andLabel:@"Over Kill" andExp:5];
    }
    else if(medalId==9){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/5.png"];
        [self rewardMedal:triple andLabel:@"KillTacular" andExp:5];
    }
    else if(medalId==11){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/6.png"];
        [self rewardMedal:triple andLabel:@"Killpocalypse" andExp:5];
    }
    else if(medalId==13){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/7.png"];
        [self rewardMedal:triple andLabel:@"7" andExp:10];
    }
    else if(medalId==15){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/8.png"];
        [self rewardMedal:triple andLabel:@"8" andExp:10];
    }
    else if(medalId==17){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/9.png"];
        [self rewardMedal:triple andLabel:@"9" andExp:10];
    }
    else if((medalId%19) == 0){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/10.png"];
        [self rewardMedal:triple andLabel:@"10" andExp:10];
    }
    if (killCount == 9){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
        [self rewardMedal:spree andLabel:@"Killing Spree" andExp:5];
    }
    else if (killCount == 19){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/40.png"];
        [self rewardMedal:spree andLabel:@"Killing Frenzy" andExp:5];
    }
    else if (killCount ==29){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/60.png"];
        [self rewardMedal:spree andLabel:@"Running Riot" andExp:10];
    }
    else if (killCount == 39){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/80.png"];
        [self rewardMedal:spree andLabel:@"Psycho" andExp:10];
    }
    else if (killCount == 49 || ((killCount%49) == 0 && killCount !=0)){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/100.png"];
        [self rewardMedal:spree andLabel:@"Unstoppable" andExp:10];
    }

}
-(void)bombPressed{
    if ([GameData sharedGameData].bombCount){
        [GameData sharedGameData].bombCount--;
        [_bombCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bombCount]];
        bomb = [CCSprite spriteWithImageNamed:@"Assets/BombOverlay.png"];
        bomb.anchorPoint = ccp(.5f,.5f);
        CCSprite *show = [CCSprite spriteWithImageNamed:@"Assets/BombOverlay.png"];
        show.positionType = CCPositionTypeNormalized;
        show.scale = 200;
        show.position = ccp(.5f,.5f);
        show.opacity = .5f;
        show.zOrder = 20000000;
        [self addChild:show];
        bomb.positionType = CCPositionTypeNormalized;
        bomb.scale = 200;
        bomb.position = ccp(.5f,.5f);
        bomb.zOrder = 20000000;
        bomb.physicsBody = [CCPhysicsBody bodyWithCircleOfRadius:2000.f andCenter:ccp(.5f,.5f)];
        [_physicsNode addChild:bomb];
        bomb.physicsBody.collisionType=@"Bomb";
        CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.05f];
        CCActionDelay *delay2 = [CCActionDelay actionWithDuration:.05f];
        CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:.5f];
        CCActionRemove *remove = [CCActionRemove action];
        CCActionCallBlock *disable = [CCActionCallBlock actionWithBlock:^(void){
            _bomb.enabled = false;
        }];
        CCActionCallBlock *enable = [CCActionCallBlock actionWithBlock:^(void){
            _bomb.enabled = true;
            if(exp > 0){
                CCLabelTTF *expLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+ %d", exp]     fontName:@"Helvetica" fontSize:22];
                expLabel.positionType = CCPositionTypeNormalized;
                expLabel.position = ccp(.5f,.7f);
                CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.4f];
                CCActionDelay *delay2 = [CCActionDelay actionWithDuration:.3f];
                CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.5f position:ccp(.5f,1.5f)];
                CCActionRemove *remove = [CCActionRemove action];
                [self addChild:expLabel];
                [expLabel runAction:[CCActionSequence actions:fade, delay2, lift,remove,nil]];
                [GameData sharedGameData].score+=exp;
                [_scoreLabel setString:[NSString stringWithFormat:@"%ld",[GameData sharedGameData].score]];
                exp = 0;
            }
        }];
        [show runAction:[CCActionSequence actions:fade,delay2,fadeOut, remove, nil]];
        [bomb runAction:[CCActionSequence actions:disable, delay2, remove, enable, nil]];
    }
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Egg:(CCNode *)nodeA Bomb:(CCNode *)nodeB {
    [[_physicsNode space] addPostStepBlock:^{
        exp++;
        CCNode *explosion = (CCNode *)[CCBReader load:@"LeftShot"];
        [_scoreLabel setString:[NSString stringWithFormat:@"%li", [GameData sharedGameData].score]];
        explosion.scale = 0.6f;
        explosion.position = nodeA.position;
        explosion.rotation = nodeA.rotation;
        [nodeA.parent addChild:explosion];
        CCActionRemove *actionRemove = [CCActionRemove action];
        id delay = [CCActionDelay actionWithDuration:0.3f];
        [explosion runAction:[CCActionSequence actionWithArray:@[delay, actionRemove]]];
        [nodeA removeFromParent];
    } key:nodeA];
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Egg:(CCNode *)nodeA Barn:(CCNode *)nodeB {
    [[_physicsNode space] addPostStepBlock:^{
        _progressNode.percentage -= 10.0f;
        [self eggHit:nodeA];
        if(_progressNode.percentage==0){
            [self barnExp:nodeB];
        }
    } key:nodeA];
}
- (void)eggHit:(CCNode *)egg {
    _health-=10;
    //_progressNode.percentage -= 10.0f;
    if(_health==0){
        self.userInteractionEnabled = false;
        //Create an NSNumber and add it to the hiScores array to be used by core data
        NSNumber *highScore = [NSNumber numberWithLong:[GameData sharedGameData].score];
        [[GameData sharedGameData].hiScores addObject: highScore];
        CCActionDelay *delay =  [CCActionDelay actionWithDuration:4.5f];
        CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
            CCScene *gameOver = [CCBReader loadAsScene:@"GameOver"];
            [[CCDirector sharedDirector] replaceScene:gameOver];
        }];
        
        [self runAction:[CCActionSequence actions: delay, block, nil]];
        //CCScene *gameOver = [CCBReader loadAsScene:@"GameOver"];
        //[[CCDirector sharedDirector] replaceScene:gameOver];
    }
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"EggHit"];
    explosion.scale = .5f;
    explosion.autoRemoveOnFinish = TRUE;
    // place the particle effect on the seals position
    explosion.position = egg.position;
    // add the particle effect to the same node the seal is on
    [self addChild:explosion];
    //CCActionDelay *delay =  [CCActionDelay actionWithDuration:2.5f];
    //CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
        //[self removeChild:explosion];
    //}];
    //[self runAction:[CCActionSequence actions:delay, block, nil]];
    
    // finally, remove the destroyed seal
    [egg removeFromParent];
}
- (void)barnExp:(CCNode *)barn {
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"EggHit"];
    explosion.scale = 2.f;
    explosion.autoRemoveOnFinish = TRUE;
    // place the particle effect on the seals position
    explosion.position = barn.position;
    // add the particle effect to the same node the seal is on
    [self addChild:explosion];
    //CCActionDelay *delay =  [CCActionDelay actionWithDuration:2.5f];
    //CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
    //[self removeChild:explosion];
    //}];
    //[self runAction:[CCActionSequence actions:delay, block, nil]];
    
    // finally, remove the destroyed seal
    [barn removeFromParent];
}

- (void)update:(CCTime)delta {
    _timeSinceLastCollision += delta;
    if (killCount < shotCount){
        killCount = 0;
        shotCount = 0;
    }
    if ( _timeSinceLastCollision > .21f ) {
        medalId = 0;
    }
}
- (void)eggRemoved:(CCNode *)egg {
    CCNode *explosion = (CCNode *)[CCBReader load:@"LeftShot"];
    killCount++;
    [_scoreLabel setString:[NSString stringWithFormat:@"%li", [GameData sharedGameData].score]];
    explosion.scale = 0.6f;
    explosion.position = egg.position;
    explosion.rotation = egg.rotation;
    [egg.parent addChild:explosion];
    CCActionRemove *actionRemove = [CCActionRemove action];
    id delay = [CCActionDelay actionWithDuration:0.3f];
    [explosion runAction:[CCActionSequence actionWithArray:@[delay, actionRemove]]];
    [egg removeFromParent];
}


-(void)rewardMedal:(CCSprite *)medalType andLabel:(NSString*)input andExp:(int)points {
    medalCount+=1;
    [GameData sharedGameData].doubleKills += 1;
    [GameData sharedGameData].score+=points;
    
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
    CCLabelTTF *expLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+ %d", points] fontName:@"Helvetica" fontSize:22];
    expLabel.positionType = CCPositionTypeNormalized;
    expLabel.position = ccp(.5f,.7f);
    CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.4f];
    CCActionDelay *delay2 = [CCActionDelay actionWithDuration:.3f];
    CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.5f position:ccp(.5f,1.5f)];
    CCActionRemove *remove = [CCActionRemove action];
    [self addChild:expLabel];
    [expLabel runAction:[CCActionSequence actions:fade, delay2, lift,remove,nil]];
    
    
    medalType.anchorPoint = ccp(.5f, .001f);
    [self runAction:[CCActionFadeIn actionWithDuration:0.4]];
    [self addChild:medalType];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",input] fontName:@"Verdana-Bold" fontSize:16.0f];
    label.positionType = CCPositionTypeNormalized;
    if(medalCount == 1){
        label.position = ccp(.7f, .1f);
    }else if (medalCount==2){
        label.position = ccp(.7f, .25f);
    }else if (medalCount==3){
        label.position = ccp(.7f, .4f);
    }else if (medalCount==4){
        label.position = ccp(.3f, .1f);
    }else if (medalCount==5){
        label.position = ccp(.3f, .25f);
    }else if (medalCount==6){
        label.position = ccp(.3f, .4f);
    }
    [self addChild:label];
    
    CCActionDelay *delay =  [CCActionDelay actionWithDuration:.4f];
    CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
        [self removeChild:medalType];
        [self removeChild:label];
        medalCount-=1;
    }];
    [self runAction:[CCActionSequence actions:delay, block, nil]];
    
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    if([input isEqualToString:@"Double Kill"]){

        int doubleCount = person.two.intValue;
        doubleCount++;
        [person setValue:[NSNumber numberWithInt:doubleCount] forKey:@"two"];
    }
    else if ([input isEqualToString:@"Triple Kill"]){

        int tripleCount = person.three.intValue;
        tripleCount++;
        [person setValue:[NSNumber numberWithInt:tripleCount] forKey:@"three"];
    }
    else if ([input isEqualToString:@"Over Kill"]){
        CCLOG(@"double kill awarded");
        int fourCount = person.four.intValue;
        fourCount++;
        [person setValue:[NSNumber numberWithInt:fourCount] forKey:@"four"];
    }
    else if ([input isEqualToString:@"KillTacular"]){
        CCLOG(@"killTacular awarded");
        int fiveCount = person.five.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"five"];
    }
    else if ([input isEqualToString:@"Killing Spree"]){
        CCLOG(@"killing spree awarded");
        int twentyCount = person.twenty.intValue;
        twentyCount++;
        NSNumber *conv = [NSNumber numberWithInt:twentyCount];
        [person setValue:conv forKey:@"twenty"];
    }
    else if ([input isEqualToString:@"Killing Frenzy"]){
        CCLOG(@"killing frenzy awarded");
        int fortyCount = person.forty.intValue;
        fortyCount++;
        [person setValue:[NSNumber numberWithInt:fortyCount] forKey:@"forty"];
    }
    else if ([input isEqualToString:@"Running Riot"]){
        CCLOG(@"double kill awarded");
        int sixtyCount = person.sixty.intValue;
        sixtyCount++;
        [person setValue:[NSNumber numberWithInt:sixtyCount] forKey:@"sixty"];
    }
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
}
-(void)pauseScene{
    CCScene *pauseScene = [CCBReader loadAsScene:@"PauseScene"];
    [[CCDirector sharedDirector] pushScene:pauseScene];
}


- (void)launchEgg {
    targetsLaunched++;
    CCNode* egg = [CCBReader load:@"Egg"];
    //egg.position = ccpAdd(_canon.position, ccp(-27, 50));
    egg.positionType = CCPositionTypePoints;
    egg.position = ccp(440.f,160.f);
    //egg.position =
    [_physicsNode addChild:egg];
    egg.scale = 0.6f;
    egg.rotation = -45.0f;
    int miny = 5;
    int maxy = 15;
    int rangey = maxy - miny;
    //int randomx = (arc4random() % rangex) + minx;
    int randomy = (arc4random() % rangey) + miny;
    CGPoint launchDirection = ccp(-10,randomy);
    int minforce = 500;
    int maxforce = 3000;
    int rangeforce = maxforce - minforce;
    int randomforce = (arc4random() % rangeforce) + minforce;
    CGPoint force = ccpMult(launchDirection, randomforce);
    [egg.physicsBody applyForce:force];
    
    if(targetsLaunched == 10){
        [self roundComplete];
    }
    else if(targetsLaunched == 20){
        [self roundComplete];
    }
    else if(targetsLaunched == 40){
        [self roundComplete];
    }
    else if(targetsLaunched == 90){
        [self roundComplete];
    }
    else if(targetsLaunched == 190){
        [self roundComplete];
    }
    else if(targetsLaunched == 290){
        [self roundComplete];
    }
    else if(targetsLaunched == 385){
        [self roundComplete];
    }
}
-(void)roundComplete{
    _pauseButton.visible = false;
    [GameData sharedGameData].bombCount++;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    NSNumber *expSum = [NSNumber numberWithLong:(person.experience.intValue + [GameData sharedGameData].score)];
    [person setValue:expSum forKey:@"experience"];
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
    CCActionDelay *delay =  [CCActionDelay actionWithDuration:6.f];
    CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
        overlay = [CCBReader load:@"overlay"];
        overlay.anchorPoint = ccp(.5f,.5f);
        overlay.positionType = CCPositionTypeNormalized;
        overlay.position = ccp(.5f,.5f);
        [self addChild:overlay];
        self.userInteractionEnabled = FALSE;
        
        NSString *string = [NSString stringWithFormat:@"Round %d Complete!", roundCount];
        complete = [CCLabelTTF labelWithString:string fontName:nil fontSize:48];
        complete.positionType = CCPositionTypeNormalized;
        complete.position = ccp(.5f,.5f);
        [overlay addChild:complete];
        
        CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.4f];
        CCActionDelay *delay2 = [CCActionDelay actionWithDuration:1.2f];
        CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:1.2f position:ccp(.5f,1.5f)];
        CCActionRemove *remove = [CCActionRemove action];
        [complete runAction:[CCActionSequence actions:fade, delay2, lift,remove,nil]];
        
        
        
        CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
            [_bombCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bombCount]];
            rank = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"temp"] fontName:@"Helvetica" fontSize:18];
            [overlay addChild:rank];
            user = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"temp"] fontName:@"Helvetica" fontSize:22];
            [overlay addChild:user];
            icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
            [overlay addChild:icon];
            
            [[GameData sharedGameData] summarizeRank:rank andUser:user andRankIcon:icon];
            
            
            
            base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
            //sprite = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
            base.anchorPoint = ccp(0,1);
            base.positionType = CCPositionTypeNormalized;
            base.position = ccp(.2f,.65f);
            [overlay addChild:base];
            
            NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
            [fetchRequest setEntity:entity];
            
            NSError *error2 = nil;
            Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:fetchRequest error:&error2] objectAtIndex:0];
            
            CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
            _progress = [CCProgressNode progressWithSprite:progress];
            _progress.type = CCProgressNodeTypeBar;
            _progress.midpoint = ccp(0.0f, 0.0f);
            _progress.anchorPoint = ccp(0,1);
            _progress.barChangeRate = ccp(1.0f, 0.5f);
            _progress.zOrder = 2500000;
            
            int rank1 = person.rank.intValue;
            if(rank1 ==0){
                CCLOG(@"OKAY");
                int experience = person.experience.intValue;
                long diff = person.experience.intValue-[GameData sharedGameData].score;
                
                int currentRank = [GameData sharedGameData].rank1.intValue;
                CCLOG(@"diff %li exp: %d", diff, experience);
                float preTemp = (float)experience/(float)currentRank *100;
                float temp = (float)diff/(float)currentRank *100;
                CCLOG(@"temp: %f experience %d, preTemp: %f", temp, experience, preTemp);
                _progress.percentage=preTemp;
            }
            else if (rank1 == 1){
                CCLOG(@"OKAY");
                int experience = person.experience.intValue;
                long diff = person.experience.intValue-[GameData sharedGameData].score;
                
                int currentRank = [GameData sharedGameData].rank2.intValue;
                int nextRank = [GameData sharedGameData].rank1.intValue;
                long diffRankExp = diff - nextRank;
                int currentRankExp = experience - nextRank;
                
                float preTemp = (float)currentRankExp/(float)currentRank *100;
                float temp = (float)diffRankExp/(float)currentRank *100;
                CCLOG(@"temp: %f experience %d currentRankExp %d", temp, experience, currentRankExp);
                _progress.percentage=preTemp;
            }
            else if (rank1 == 2){
                CCLOG(@"2");
                int experience = person.experience.intValue;
                long diff = person.experience.intValue-[GameData sharedGameData].score;
                
                int currentRank = [GameData sharedGameData].rank3.intValue;
                int nextRank = [GameData sharedGameData].rank2.intValue;
                long diffRankExp = diff - nextRank;
                int currentRankExp = experience - nextRank;
                
                float preTemp = (float)currentRankExp/(float)currentRank *100;
                float temp = (float)diffRankExp/(float)currentRank *100;
                CCLOG(@"temp: %f experience %d currentRankExp %d", temp, experience, currentRankExp);
                _progress.percentage=preTemp;            }
            else if (rank1 == 3){
                CCLOG(@"OKAY");
                int experience = person.experience.intValue;
                long diff = person.experience.intValue-[GameData sharedGameData].score;
                
                int currentRank = [GameData sharedGameData].rank4.intValue;
                int nextRank = [GameData sharedGameData].rank3.intValue;
                long diffRankExp = diff - nextRank;
                int currentRankExp = experience - nextRank;
                
                float preTemp = (float)currentRankExp/(float)currentRank *100;
                float temp = (float)diffRankExp/(float)currentRank *100;
                CCLOG(@"temp: %f experience %d currentRankExp %d", temp, experience, currentRankExp);
                _progress.percentage=preTemp;
            }
            else if (rank1 == 4){
                int experience = person.experience.intValue;
                int currentRank = [GameData sharedGameData].rank5.intValue;
                int nextRank = [GameData sharedGameData].rank4.intValue;
                int currentRankExp = experience - nextRank;
                
                float temp = (float)currentRankExp/(float)currentRank *100;
                CCLOG(@"temp: %f experience %d currentRankExp %d", temp, experience, currentRankExp);
                _progress.percentage=temp;
            }
            _progress.positionType = CCPositionTypeNormalized;
            _progress.position = ccp(.2f,.65f);
            [overlay addChild:_progress];
            
            
            
            
            _nextRoundButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
            _nextRoundButton.positionType = CCPositionTypeNormalized;
            _nextRoundButton.position = ccp(.5f,.1f);
            [_nextRoundButton setTarget:self selector:@selector(_continuePressed)];
            [overlay addChild:_nextRoundButton];
            
            nextRound = [CCLabelTTF labelWithString:@"Ready" fontName:@"Helvetica" fontSize:32];
            nextRound.positionType = CCPositionTypeNormalized;
            nextRound.anchorPoint = ccp(0.0f,.5f);
            nextRound.position = ccp(.58f,.1f);
            [overlay addChild:nextRound];
            
            _repairButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/Repair.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/RepairPressed.png"] disabledSpriteFrame:nil];
            _repairButton.positionType = CCPositionTypeNormalized;
            _repairButton.position = ccp(.65f,.5f);
            [_repairButton setTarget:self selector:@selector(bombPurchased)];
            [overlay addChild:_repairButton];
            
            _repairs = [CCLabelTTF labelWithString:@"Repairs" fontName:@"Helvetica" fontSize:14];
            _repairs.positionType = CCPositionTypeNormalized;
            _repairs.position = ccp(.65f,.42f);
            [overlay addChild:_repairs];
            
            
            _buyBombsButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/Bomb.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/BombPressed.png"] disabledSpriteFrame:nil];
            _buyBombsButton.positionType = CCPositionTypeNormalized;
            _buyBombsButton.position = ccp(.65f,.3f);
            [_buyBombsButton setTarget:self selector:@selector(bombPurchased)];
            [overlay addChild:_buyBombsButton];
            
            _nukes = [CCLabelTTF labelWithString:@"Nukes" fontName:@"Helvetica" fontSize:14];
            _nukes.positionType = CCPositionTypeNormalized;
            _nukes.position = ccp(.65f,.22f);
            [overlay addChild:_nukes];
            
            _upgradesLabel = [CCLabelTTF labelWithString:@"Upgrades" fontName:@"Helvetica" fontSize:28];
            _upgradesLabel.positionType = CCPositionTypeNormalized;
            _upgradesLabel.position = ccp(.65f,.7f);
            [overlay addChild:_upgradesLabel];
            
            _costLabel = [CCLabelTTF labelWithString:@"Cost" fontName:@"Helvetica" fontSize:28];
            _costLabel.positionType = CCPositionTypeNormalized;
            _costLabel.position = ccp(.85f,.7f);
            [overlay addChild:_costLabel];
            
            _costBomb = [CCSprite spriteWithImageNamed:@"Assets/GoldEgg.png"];
            _costBomb.scale = .65f;
             _costBomb.positionType = CCPositionTypeNormalized;
             _costBomb.position = ccp(.85f, .3f);
             [overlay addChild:_costBomb];
            
            _costRepair1 = [CCSprite spriteWithImageNamed:@"Assets/GoldEgg.png"];
            _costRepair1.scale = .65f;
            _costRepair1.positionType = CCPositionTypeNormalized;
            _costRepair1.position = ccp(.833f, .5f);
            [overlay addChild:_costRepair1];
            
            _costRepair2 = [CCSprite spriteWithImageNamed:@"Assets/GoldEgg.png"];
            _costRepair2.scale = .65f;
            _costRepair2.positionType = CCPositionTypeNormalized;
            _costRepair2.position = ccp(.867f, .5f);
            [overlay addChild:_costRepair2];
            
            _gold = [CCSprite spriteWithImageNamed:@"Assets/GoldEgg.png"];
            _gold.positionType = CCPositionTypeNormalized;
            _gold.position = ccp(.1f,.4f);
            [overlay addChild:_gold];
            
            
            _goldCount = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %d", gameCurrency ] fontName:@"Helvetica" fontSize:28];
            _goldCount.positionType = CCPositionTypeNormalized;
            _goldCount.position = ccp(.8f,.7f);
            [overlay addChild:_goldCount];
            
            
        }];
        CCActionDelay *delay3 = [CCActionDelay actionWithDuration:2.2f];
        [overlay runAction:[CCActionSequence actions:delay3, block, nil]];
        roundCount++;
        overlay.visible = true;
    }];
    [self runAction:[CCActionSequence actions:delay, block, nil]];
}
-(void)_continuePressed{
    self.userInteractionEnabled = true;
    [overlay removeChild:rank];
    [overlay removeChild:user];
    [overlay removeChild:icon];
    [overlay removeChild:nextRound];
    [overlay removeChild:_progress];
    [overlay removeChild:base];
    [overlay removeChild:_nextRoundButton];
    [overlay removeChild:_buyBombsButton];
    [overlay removeChild:_nukes];
    [overlay removeChild:_upgradesLabel];
    [overlay removeChild:_repairButton];
    [overlay removeChild:_repairs];
    [overlay removeChild:_costBomb];
    [overlay removeChild:_costRepair1];
    [overlay removeChild:_costRepair2];
    [overlay removeChild:_gold];
    [overlay removeChild:_goldCount];
    overlay.visible = false;
    _pauseButton.visible = true;
    NSString *text = [NSString stringWithFormat:@"Round %d", roundCount];
    [self newRound:text];
    [self initRound:roundCount];
}



// -----------------------------------------------------------------

@end





