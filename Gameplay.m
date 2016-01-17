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
    int doubleKillCount;
    CCProgressNode *_progressNode;
    long gameScore;
    
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
    [self newRound:@"Round 1"];

    /*_chicken.position = CGPointMake(self.contentSize.width+_chicken.contentSize.width, _chicken.position.y);
    _canon.position = CGPointMake(self.contentSize.width+_chicken.contentSize.width, _chicken.position.y);
    id moveCk=[CCActionMoveTo actionWithDuration:2.0f position:ccp(self.contentSize.width-40,_chicken.position.y)];
    id moveCanon=[CCActionMoveTo actionWithDuration:2.0f position:ccp(self.contentSize.width-90,_chicken.position.y)];
    id delay = [CCActionDelay actionWithDuration: .5f];
    [_canon runAction:[CCActionSequence actions: moveCanon, nil]];
    [_chicken runAction:[CCActionSequence actions: delay, moveCk, nil]];
     */
    [self addChicken:(self.contentSize.width + 150) y:104.f androtation:0.f andMoveToX:self.contentSize.width - 100 andMoveToY:104.f];
    int minTime = 2.0f;
    int maxTime = 4.0f;
    int rangeTime = maxTime - minTime;
    int randomTime = (arc4random() % rangeTime) + minTime;
    [self schedule:@selector(launchEgg) interval:randomTime repeat:9 delay:5.3f];
    /*CCNode* chicken = [CCBReader load:@"barn"];
    CGPoint point =  CGPointMake(300,300);
    chicken.position = point;
    [self addChild:chicken];
     */
    _barn.physicsBody.collisionType=@"Barn";
    
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



- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event {
    shotCount ++;
    CGPoint touchLocation = [touch locationInNode:self];
    CCNode* bullet = [CCBReader load:@"Bullet"];
    bullet.scale = .6;
    bullet.position = touchLocation;
    [_physicsNode addChild:bullet];
    CCActionRemove *actionRemove = [CCActionRemove action];
    id delay = [CCActionDelay actionWithDuration:.000001f];
    [bullet runAction:[CCActionSequence actionWithArray:@[delay, actionRemove]]];
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
     if(targetsLaunched == 5){
        [self newRound:@"Round 2"];
        [self initRound:roundCount];
    }
    else if(targetsLaunched == 15){
        [self newRound:@"Round 3"];
        [self initRound:roundCount];
    }
    else if(targetsLaunched == 35){
        [self newRound:@"Round 4"];
        [self initRound:roundCount];
    }
    else if(targetsLaunched == 85){
        [self newRound:@"Round 5"];
        [self initRound:roundCount];
    }
    else if(targetsLaunched == 185){
        [self newRound:@"Round 6"];
        [self initRound:roundCount];
    }
    else if(targetsLaunched == 285){
        [self newRound:@"Round 7"];
        [self initRound:roundCount];
    }
    else if(targetsLaunched == 385){
        [self newRound:@"Round 8"];
        [self initRound:roundCount];
    }
}
- (void)launchEggTopRight {
    //targetsLaunched++;
    CCNode* egg = [CCBReader load:@"Egg"];
    //egg.position = ccpAdd(_canon.position, ccp(-27, 50));
    egg.positionType = CCPositionTypePoints;
    egg.position = ccp(540.f,300.f);
    //egg.position =
    [_physicsNode addChild:egg];
    egg.scale = 0.6f;
    egg.rotation = -45.0f;
    //int minx = -11;
    int miny = 0;
    //int maxx = -12;
    int maxy = 1;
    //int rangex = maxx - minx;
    int rangey = maxy - miny;
    //int randomx = (arc4random() % rangex) + minx;
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
    
    CCActionDelay *delay =  [CCActionDelay actionWithDuration:2.5];
    CCActionCallBlock *blockAdd = [CCActionCallBlock actionWithBlock:^{
        [self addChild:label];
    }];
    CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
        [self removeChild:label];
    }];
    
    [self runAction:[CCActionSequence actions:delay, blockAdd, delay, block, delay, nil]];
    roundCount++;
}

-(void)initRound:(int)number{
    switch (number){

case 2:
        [self schedule:@selector(launchEgg) interval:1.0f repeat:9 delay:4.f];
        break;
case 3:
        [self schedule:@selector(launchEgg) interval:.7f repeat:19 delay:5.f];
        [self addChicken:self.contentSize.width+50 y:self.contentSize.height-100 androtation:-45 andMoveToX:self.contentSize.width andMoveToY:self.contentSize.height-100];
        [self schedule:@selector(launchEggTopRight) interval:.7f repeat:19 delay:6.5f];
        break;
case 4:
        [self schedule:@selector(launchEgg) interval:.5f repeat:49 delay:5.f];
            [self schedule:@selector(launchEggTopRight) interval:.5f repeat:49 delay:6.5f];
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
        [[_physicsNode space] addPostStepBlock:^{
            [self eggRemoved:nodeA];
        } key:nodeA];
    if(medalId==3){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/2.png"];
        [self rewardMedal:spree andLabel:@"Double Kill"];    }
    else if(medalId==5){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/3.png"];
        [self rewardMedal:triple andLabel:@"Triple Kill"];
    }
    else if(medalId==7){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/4.png"];
        [self rewardMedal:triple andLabel:@"Over Kill"];
    }
    else if(medalId==9){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/5.png"];
        [self rewardMedal:triple andLabel:@"KillTacular"];
    }
    else if(medalId==11){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/6.png"];
        [self rewardMedal:triple andLabel:@"Killpocalypse"];
    }
    else if(medalId==13){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/7.png"];
        [self rewardMedal:triple andLabel:@"7"];
    }
    else if(medalId==15){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/8.png"];
        [self rewardMedal:triple andLabel:@"8"];
    }
    else if(medalId==17){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/9.png"];
        [self rewardMedal:triple andLabel:@"9"];
    }
    else if(medalId==19 || (medalId%10) == 0){
        CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/10.png"];
        [self rewardMedal:triple andLabel:@"10"];
    }

    
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
    if (killCount !=shotCount){
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
    [GameData sharedGameData].score++;
    CCLOG(@"Score: %d", killCount);
    [_scoreLabel setString:[NSString stringWithFormat:@"%li", [GameData sharedGameData].score]];
    explosion.scale = 0.6f;
    explosion.position = egg.position;
    explosion.rotation = egg.rotation;
    [egg.parent addChild:explosion];
    CCActionRemove *actionRemove = [CCActionRemove action];
    id delay = [CCActionDelay actionWithDuration:0.3f];
    [explosion runAction:[CCActionSequence actionWithArray:@[delay, actionRemove]]];
    [egg removeFromParent];
    
    if (killCount == 20){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
        [self rewardMedal:spree andLabel:@"Killing Spree"];
    }
    else if (killCount == 40){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/40.png"];
        [self rewardMedal:spree andLabel:@"Killing Frenzy"];
    }
    else if (killCount == 60){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/60.png"];
        [self rewardMedal:spree andLabel:@"Running Riot"];
    }
    else if (killCount == 80){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/80.png"];
        [self rewardMedal:spree andLabel:@"Psycho"];
    }
    else if (killCount == 100){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/100.png"];
        [self rewardMedal:spree andLabel:@"Unstoppable"];
    }
}


-(void)rewardMedal:(CCSprite *)medalType andLabel:(NSString*)input {
    medalCount+=1;
    CCLOG(@"%d", medalCount);
    doubleKillCount++;
    
    [GameData sharedGameData].doubleKills += 1;
    
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
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",input] fontName:@"Verdana-Bold" fontSize:16.0f];
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
        CCLOG(@"double kill awarded");
        int doubleCount = person.two.intValue;
        doubleCount++;
        [person setValue:[NSNumber numberWithInt:doubleCount] forKey:@"two"];
    }
    else if ([input isEqualToString:@"Triple Kill"]){
        CCLOG(@"Triple kill awarded");
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


// -----------------------------------------------------------------

@end





