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
#import "TableView.h"
#import "AlertView.h"
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
    CCLabelTTF *roundLabel;
    
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
    CCButton *_shopping;
    CCLabelTTF *_shoppingLabel;
    CCSprite *_gold;
    CCLabelTTF *_goldCount;
    CCButton *buyBlades;
    CCSprite *bladeCost1;
    CCSprite *bladeCost2;
    CCLabelTTF *bladeCostLabel;
    
    CCLabelTTF *rank;
    CCLabelTTF *user;
    CCSprite *icon;
    CCSprite *base;
    CCProgressNode *_progress;
    CCLabelTTF *nextRound;
    
    CGPoint _startPoint;
    CGPoint _endPoint;
    
    CCNode *blade;
    CCMotionStreak *streak;
    int timeRemain;
    int bladeActive;
    CCButton *bladeButton;
    CCLabelTTF *timer;
    CCLabelTTF *bladeCount;
    
    int gameCurrency;
    
    int exp;
    
    //randomization vars
    float minLaunch;
    float maxLaunch;
    float randomLaunch;
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
    [self newRound:[NSString stringWithFormat:@"%d",roundCount]];
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
    [bladeCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bladeCount]];
    
    CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Assets/progressBarn.png"];
    _progressNode = [CCProgressNode progressWithSprite:sprite];
    _progressNode.type = CCProgressNodeTypeBar;
    _progressNode.midpoint = ccp(0.0f, 0.0f);
    _progressNode.barChangeRate = ccp(1.0f, 0.0f);
    _progressNode.percentage = 100.0f;
    //_progressNode.zOrder = 100001;
    
    CCSprite *base1 = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
    base1.positionType = CCPositionTypeNormalized;
    base1.position = ccp(0.12f, 0.05f);
    [self addChild:base1];
    
    _progressNode.positionType = CCPositionTypeNormalized;
    _progressNode.position = ccp(0.12f, 0.05f);
    [self addChild:_progressNode];

    
    CCTexture *texture = [CCTexture textureWithFile:@"Back.png"];
    streak = [CCMotionStreak streakWithFade:.5f minSeg:.5f width:10.f color:[CCColor colorWithCcColor3b:ccYELLOW] texture:texture];
    //CCMotionStreak *streak = [CCMotionStreak streakWithFade:.5f minSeg:5.f width:10.f color: [CCColor colorWithCcColor3b:ccYELLOW] textureFilename:@"Assets/2.png"];
     [self addChild:streak];
    streak.position = _endPoint;
    
    blade = [CCBReader load:@"Bullet"];
    blade.visible = false;
    blade.scale = .6;

}


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
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            [request setEntity:entity];
            NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                                     stringForKey:@"defaultUser"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
            [request setPredicate:predicate];
            NSError *error2 = nil;
            Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
            int newAmount = person.gold.intValue + 1;
            [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
            if (![person.managedObjectContext save:&error2]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", error2, error2.localizedDescription);
            }
            
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
        _startPoint = [touch locationInNode:self];
        _endPoint = [touch locationInNode:self];;
        CCNode* bullet = [CCBReader load:@"Bullet"];
        bullet.visible = false;
        bullet.scale = .6;
        bullet.position = _startPoint;
        [_physicsNode addChild:bullet];
        CCActionRemove *actionRemove = [CCActionRemove action];
        id delay = [CCActionDelay actionWithDuration:.000001f];
        [bullet runAction:[CCActionSequence actionWithArray:@[delay, actionRemove]]];
        [_physicsNode addChild:blade];
    }
}
-(void)timerUpdate:(CCTime)delta
{
    timeRemain--;
    [timer setString:[NSString stringWithFormat:@"%d",timeRemain]];
    if (timeRemain <=3){
        timer.color = [CCColor colorWithCcColor3b:ccRED];
        CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:.5f];
        [timer runAction:[CCActionSequence actions:fade,fadeOut,nil]];
    }
    if(timeRemain == 0){
        bladeActive = 0;
        [self removeChild:timer];
        [self unschedule:@selector(timerUpdate:)];
        [bladeButton setEnabled:true];
}
    // update timer here, using numSeconds
}
-(void)bladePressed{
    if([GameData sharedGameData].bladeCount >=1){
    bladeActive = 1;
    [bladeButton setEnabled:false];
    timeRemain = 15;
    
    timer = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",timeRemain] fontName:@"Helvetica" fontSize:14];
    timer.positionType = CCPositionTypeUIPoints;
    timer.position = ccp(289.f,46.f);
    [self addChild:timer];
    [GameData sharedGameData].bladeCount--;
    [bladeCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bladeCount]];
    [self schedule:@selector(timerUpdate:) interval:1];
    }else{
        CCLOG(@"NEED MO MONEY");
    }
}

-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if(bladeActive == 1){
        CGPoint location = [touch locationInNode:self];
        _endPoint = location;
        CCLOG(@"%f, %f",_endPoint.x, _endPoint.y);
        //blade = [CCBReader load:@"Bullet"];
       // blade.visible = true;
       // blade.scale = .6;
        //blade.position = _endPoint;
        //[_physicsNode addChild:blade];
        [self doStep:.001f];
    }
}
-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    //if(blade.parent == _physicsNode){
    if (blade){
        [_physicsNode removeChild:blade];
    }
        //[_physicsNode removeChild:blade];
    //}
}
-(void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    //if(blade.parent == _physicsNode){
    if (blade){
        [_physicsNode removeChild:blade];
    }
    //}
}
- (void)doStep:(CCTime)delta
{
    //update the position
    blade.position = _endPoint;
    [streak setPosition:_endPoint];
}
/*
// Add this method
- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches){
        CGPoint location = [touch locationInView:[touch view]];
        location = [[CCDirector sharedDirector] convertToGL:location];
        _endPoint = location;
        CCLOG(@"%f, %f",_endPoint.x, _endPoint.y);
    }
}
 */
-(void)bombPurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                                 stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    if(person.gold.intValue>=1){
        [GameData sharedGameData].bombCount++;
        int newAmount = person.gold.intValue - 1;
        [_nukes setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bombCount]];
        [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
        [_bombCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bombCount]];
        [_goldCount setString:[NSString stringWithFormat:@"X %d", person.gold.intValue]];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
    }
    else{
        CCLOG(@"NEED MO MONEY");
    }
}
-(void)repairPurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    if(person.gold.intValue >=2){
        int newAmount = person.gold.intValue - 2;
        [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
        _progressNode.percentage = 100.f;
        _health = 100.f;
        [_goldCount setString:[NSString stringWithFormat:@"X %d", person.gold.intValue]];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
    }
    else{
        CCLOG(@"NEED MORE MONEY");
    }
    
}
-(void)bladePurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    if(person.gold.intValue >=2){
        int newAmount = person.gold.intValue - 2;
        [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
        [GameData sharedGameData].bladeCount++;
        [bladeCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
        [bladeCostLabel setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
        [_goldCount setString:[NSString stringWithFormat:@"X %d", person.gold.intValue]];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
    }
    else{
        id block = ^(void){
            CCLOG(@"OKAY");
        };
        //AlertView *alert = [AlertView ];
        [AlertView ShowAlert:@"You do not have enough gold!" onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
    }
    
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
    if (!roundLabel){
    roundLabel = [CCLabelTTF labelWithString:(round) fontName:(nil) fontSize:(48)];
    roundLabel.positionType = CCPositionTypeNormalized;
    roundLabel.position = ccp(.07f,0.77f);
    roundLabel.opacity = 0.f;
    [self addChild:roundLabel];
    CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:1.f];
    CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:1.f];
    //CCActionDelay *delay2 = [CCActionDelay actionWithDuration:2.5f];
    //CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:1.2f position:ccp(.5f,1.5f)];
    //CCActionRemove *remove = [CCActionRemove action];
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
    
    [roundLabel runAction:[CCActionSequence actions:fade,fadeOut,fade,fadeOut, fade, nil]];
    }
    else{
        CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:1.f];
        CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:1.f];
        [roundLabel setString:round];
        [roundLabel runAction:[CCActionSequence actions:fade,fadeOut,fade,fadeOut, fade, nil]];
    }
}

-(void)initRound:(int)number{
        switch (number){
            case 1:{
                int minTime = .9f * 1000;
                int maxTime = 1.2f * 1000;
                int rangeTime = maxTime - minTime;
                int a = (arc4random() % rangeTime) + minTime;
                float randomTime = a/1000.f;
                CCLOG(@"%f", randomTime);
                [self schedule:@selector(launchEgg) interval:randomTime repeat:9 delay:5.f];
        }
        break;

        case 2:{
            int minTime = .5f * 1000;
            int maxTime = .8f * 1000;
            int rangeTime = maxTime - minTime;
            int a = (arc4random() % rangeTime) + minTime;
            float randomTime = a/1000.f;
            CCLOG(@"%f", randomTime);
            [self schedule:@selector(launchEgg) interval:randomTime repeat:9 delay:5.f];
            break;
        }
            case 3:{
                int minTime = .8f * 1000;
                int maxTime = 1.2f * 1000;
                int rangeTime = maxTime - minTime;
                int a = (arc4random() % rangeTime) + minTime;
                float randomTime = a/1000.f;
                CCLOG(@"%f", randomTime);
                [self schedule:@selector(launchEgg) interval:randomTime repeat:19 delay:5.f];
                [self addChicken:self.contentSize.width+50 y:self.contentSize.height-100 androtation:-45    andMoveToX:self.contentSize.width andMoveToY:self.contentSize.height-100];
                [self schedule:@selector(launchEggTopRight) interval:randomTime repeat:19 delay:7.5f];
                break;
            }
            case 4:{
                int minTime = .5f * 1000;
                int maxTime = 1.f * 1000;
                int rangeTime = maxTime - minTime;
                int a = (arc4random() % rangeTime) + minTime;
                float randomTime = a/1000.f;
                CCLOG(@"%f", randomTime);
                [self schedule:@selector(launchEgg) interval:randomTime repeat:49 delay:5.f];
                [self schedule:@selector(launchEggTopRight) interval:randomTime repeat:49 delay:6.f];
                break;
            }
            case 5:{
                int minTime = .4f * 1000;
                int maxTime = .6f * 1000;
                int rangeTime = maxTime - minTime;
                int a = (arc4random() % rangeTime) + minTime;
                float randomTime = a/1000.f;
                CCLOG(@"%f", randomTime);
            
                [self schedule:@selector(launchEgg) interval:randomTime repeat:99 delay:5.f];
                [self schedule:@selector(launchEggTopRight) interval:randomTime repeat:99 delay:6.5f];
                break;
            }
            case 6:{
                int minTime = .3f * 1000;
                int maxTime = .6f * 1000;
                int rangeTime = maxTime - minTime;
                int a = (arc4random() % rangeTime) + minTime;
                float randomTime = a/1000.f;
                CCLOG(@"%f", randomTime);
                
                [self schedule:@selector(launchEgg) interval:randomTime repeat:99 delay:5.f];
                [self schedule:@selector(launchEggTopRight) interval:randomTime repeat:99 delay:7.f];
                break;
            }
            case 7:{
                int minTime = .2f * 1000;
                int maxTime = .5f * 1000;
                int rangeTime = maxTime - minTime;
                int a = (arc4random() % rangeTime) + minTime;
                float randomTime = a/1000.f;
                CCLOG(@"%f", randomTime);
                
                [self schedule:@selector(launchEgg) interval:randomTime repeat:99 delay:5.f];
                [self schedule:@selector(launchEggTopRight) interval:randomTime repeat:99 delay:7.f];
                break;
            }
            case 8:{
                int minTime = .2f * 1000;
                int maxTime = .4f * 1000;
                int rangeTime = maxTime - minTime;
                int a = (arc4random() % rangeTime) + minTime;
                float randomTime = a/1000.f;
                CCLOG(@"%f", randomTime);
                
                [self schedule:@selector(launchEgg) interval:randomTime repeat:114 delay:5.f];
                [self schedule:@selector(launchEggTopRight) interval:randomTime repeat:114 delay:7.f];
                break;
            }
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
    if (killCount == 19){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
        [self rewardMedal:spree andLabel:@"Killing Spree" andExp:5];
    }
    else if (killCount == 39){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/40.png"];
        [self rewardMedal:spree andLabel:@"Killing Frenzy" andExp:5];
    }
    else if (killCount ==59){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/60.png"];
        [self rewardMedal:spree andLabel:@"Running Riot" andExp:10];
    }
    else if (killCount == 79){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/80.png"];
        [self rewardMedal:spree andLabel:@"Psycho" andExp:10];
    }
    else if (killCount == 99 || ((killCount%19) == 0 && killCount!= 0)){
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
-(void)armoryPressed{
    CCLOG(@"Armory");
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
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
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
    else if ([input isEqualToString:@"Killpocalypse"]){
        CCLOG(@"6 awarded");
        int fiveCount = person.six.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"six"];
    }
    else if ([input isEqualToString:@"7"]){
        CCLOG(@"7 awarded");
        int fiveCount = person.seven.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"seven"];
    }
    else if ([input isEqualToString:@"8"]){
        CCLOG(@"8 awarded");
        int fiveCount = person.eight.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"eight"];
    }
    else if ([input isEqualToString:@"9"]){
        CCLOG(@"9 awarded");
        int fiveCount = person.nine.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"nine"];
    }
    else if ([input isEqualToString:@"10"]){
        CCLOG(@"10 awarded");
        int fiveCount = person.ten.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"ten"];
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
    else if ([input isEqualToString:@"Psycho"]){
        CCLOG(@"80 spree");
        int sixtyCount = person.eighty.intValue;
        sixtyCount++;
        [person setValue:[NSNumber numberWithInt:sixtyCount] forKey:@"eighty"];
    }
    else if ([input isEqualToString:@"Unstoppable"]){
        CCLOG(@"100 spree");
        int sixtyCount = person.hundred.intValue;
        sixtyCount++;
        [person setValue:[NSNumber numberWithInt:sixtyCount] forKey:@"hundred"];
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
    CCLOG(@"%d",targetsLaunched);
    if (arc4random() % 2 == 1 || arc4random() % 2 == 1) {
    //targetsLaunched++;
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
    //**
    }
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
    //[self scheduleOnce:@selector(launchEgg) delay:randomLaunch];
}
    /*
     CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
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
     }];
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
     if (roundCount == 0){
     int minTime = .9f * 1000;
     int maxTime = 2.1f * 1000;
     int rangeTime = maxTime - minTime;
     int a = (arc4random() % rangeTime) + minTime;
     float randomTime = a/1000.f;
     CCLOG(@"%f", randomTime);
    minLaunch = .9f * 1000;
    maxLaunch = 2.1f*1000;
}
else if (roundCount == 1){
     int minTime = .9f * 1000;
     int maxTime = 2.1f * 1000;
     int rangeTime = maxTime - minTime;
     int a = (arc4random() % rangeTime) + minTime;
     float randomTime = a/1000.f;
     CCLOG(@"%f", randomTime);
    minLaunch = .9f * 1000;
    maxLaunch = 2.1f*1000;
}
int rangeLaunch = maxLaunch-minLaunch;
int a = (arc4random() % rangeLaunch) + minLaunch;
float randomLaunch = a/1000.f;
CCLOG(@"%f",randomLaunch);
CCActionDelay *delay = [CCActionDelay actionWithDuration:randomLaunch];
[self runAction:[CCActionSequence actions:delay,block,nil]];
     */
-(void)roundComplete{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
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
        
        _pauseButton.visible = false;
        _bomb.visible = false;
        roundLabel.visible = false;
        _bombCount.visible = false;
        bladeCount.visible = false;
        timer.visible = false;
        bladeButton.visible = false;
        
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
            icon.scale = .8f;
            [overlay addChild:icon];
            
            [[GameData sharedGameData] summarizeRank:rank andUser:user andRankIcon:icon];
            
            
            
            base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
            //sprite = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
            base.anchorPoint = ccp(0,1);
            base.positionType = CCPositionTypeNormalized;
            base.position = ccp(.2f,.65f);
            [overlay addChild:base];
            
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
            NSFetchRequest *request = [[NSFetchRequest alloc] init];
            [request setEntity:entity];
            NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                                     stringForKey:@"defaultUser"];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
            [request setPredicate:predicate];
            NSError *error2 = nil;
            Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
            
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
            _nextRoundButton.position = ccp(.1f,.1f);
            [_nextRoundButton setTarget:self selector:@selector(_continuePressed)];
            [overlay addChild:_nextRoundButton];
            
            nextRound = [CCLabelTTF labelWithString:@"Ready" fontName:@"Helvetica" fontSize:32];
            nextRound.positionType = CCPositionTypeNormalized;
            nextRound.anchorPoint = ccp(0.0f,.5f);
            nextRound.position = ccp(.18f,.1f);
            [overlay addChild:nextRound];
            
            _upgradesLabel = [CCLabelTTF labelWithString:@"Upgrades" fontName:@"Helvetica" fontSize:28];
            _upgradesLabel.positionType = CCPositionTypeNormalized;
            _upgradesLabel.position = ccp(.65f,.7f);
            [overlay addChild:_upgradesLabel];
            
            _costLabel = [CCLabelTTF labelWithString:@"Cost" fontName:@"Helvetica" fontSize:28];
            _costLabel.positionType = CCPositionTypeNormalized;
            _costLabel.position = ccp(.85f,.7f);
            [overlay addChild:_costLabel];
            

            _repairButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/Repair.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/RepairPressed.png"] disabledSpriteFrame:nil];
            _repairButton.positionType = CCPositionTypeNormalized;
            _repairButton.position = ccp(.65f,.5f);
            [_repairButton setTarget:self selector:@selector(repairPurchased)];
            [overlay addChild:_repairButton];
            
            _repairs = [CCLabelTTF labelWithString:@"Repairs" fontName:@"Helvetica" fontSize:14];
            _repairs.positionType = CCPositionTypeNormalized;
            _repairs.position = ccp(.65f,.42f);
            [overlay addChild:_repairs];
            
            
            _buyBombsButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/nuke.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/nukeNil.png"] disabledSpriteFrame:nil];
            _buyBombsButton.positionType = CCPositionTypeNormalized;
            _buyBombsButton.position = ccp(.65f,.3f);
            [_buyBombsButton setTarget:self selector:@selector(bombPurchased)];
            [overlay addChild:_buyBombsButton];
            
            _nukes = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount] fontName:@"Helvetica" fontSize:10];
            _nukes.positionType = CCPositionTypeNormalized;
            _nukes.position = ccp(.679f,.343f);
            [overlay addChild:_nukes];

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
            
            buyBlades = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/blade.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/bladeNil.png"] disabledSpriteFrame:nil];
            buyBlades.positionType = CCPositionTypeNormalized;
            buyBlades.position = ccp(.65f,.1f);
            buyBlades.scale = 1.1f;
            [buyBlades setTarget:self selector:@selector(bladePurchased)];
            [overlay addChild:buyBlades];
            
            bladeCostLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount] fontName:@"Helvetica" fontSize:10];
            bladeCostLabel.positionType = CCPositionTypeNormalized;
            bladeCostLabel.position = ccp(.682f,.142f);
            [overlay addChild:bladeCostLabel];
            
            bladeCost1 = [CCSprite spriteWithImageNamed:@"Assets/GoldEgg.png"];
            bladeCost1.scale = .65f;
            bladeCost1.positionType = CCPositionTypeNormalized;
            bladeCost1.position = ccp(.833f, .1f);
            [overlay addChild:bladeCost1];
            
            bladeCost2 = [CCSprite spriteWithImageNamed:@"Assets/GoldEgg.png"];
            bladeCost2.scale = .65f;
            bladeCost2.positionType = CCPositionTypeNormalized;
            bladeCost2.position = ccp(.867f, .1f);
            [overlay addChild:bladeCost2];
            /*
            [GameData sharedGameData].tableID=4;
            table = [TableView node];
            table.contentSizeType = CCSizeTypeNormalized;
            table.positionType = CCPositionTypeNormalized;
            table.position = ccp(.6f,-.5f);
            table.contentSize = CGSizeMake(1, 1);
            table.zOrder = 1000;
            [overlay addChild:table];
             */

            _gold = [CCSprite spriteWithImageNamed:@"Assets/GoldEgg.png"];
            _gold.positionType = CCPositionTypeNormalized;
            _gold.position = ccp(.1f,.4f);
            [overlay addChild:_gold];
            
            
            _goldCount = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %d", person.gold.intValue ] fontName:@"Helvetica" fontSize:28];
            _goldCount.positionType = CCPositionTypeNormalized;
            _goldCount.position = ccp(.2f,.4f);
            [overlay addChild:_goldCount];
            
            _shopping = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/Shop.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/ShopPressed.png"] disabledSpriteFrame:nil];
            _shopping.positionType = CCPositionTypeNormalized;
            _shopping.position = ccp(.5f,.1f);
            [_shopping setTarget:self selector:@selector(armoryPressed)];
            [overlay addChild:_shopping];
            
            _shoppingLabel = [CCLabelTTF labelWithString:@"Armory" fontName:@"Helvetica" fontSize:14];
            _shoppingLabel.positionType = CCPositionTypeNormalized;
            _shoppingLabel.position = ccp(.5f,.025f);
            [overlay addChild:_shoppingLabel];
             
            
        }];
        CCActionDelay *delay3 = [CCActionDelay actionWithDuration:2.2f];
        [overlay runAction:[CCActionSequence actions:delay3, block, nil]];
        roundCount++;
        overlay.visible = true;
    }];
    CCActionCallBlock *awardBlock = [CCActionCallBlock actionWithBlock:^{
        int min = 1;
        int max = 3;
        int range = max - min;
        int random = (arc4random() % range) + min;
        CCLOG(@"%d",random);
        switch (random){
            case 1:{
                [GameData sharedGameData].bladeCount++;
                [bladeCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bladeCount]];
                CCSprite *bonus = [CCSprite spriteWithImageNamed:@"Assets/blade.png"];
                bonus.positionType = CCPositionTypeNormalized;
                bonus.position = ccp(.5f,.5f);
                [self addChild:bonus];
                CCActionFadeIn *fadeIn =[CCActionFadeIn actionWithDuration:.5f];
                CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:.5f];
                CCActionDelay *delay = [CCActionDelay actionWithDuration:.5f];
                CCActionRemove *actionRemove = [CCActionRemove action];
                
                CCLabelTTF *label = [CCLabelTTF labelWithString:@"+1" fontName:@"Helvetica" fontSize:10];
                label.positionType = CCPositionTypePoints;
                label.position = ccp(300,208.3f);
                label.opacity = 0.f;
                [self addChild: label];
                [label runAction:[CCActionSequence actions:delay,fadeIn, fadeOut, actionRemove, nil]];
                [bonus runAction:[CCActionSequence actions:fadeIn,delay,fadeOut, actionRemove, nil]];
                break;
            }
            case 2:{
            }
                break;
            case 3:{
                [GameData sharedGameData].bombCount++;
                [_bombCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bombCount]];
                CCSprite *bonus = [CCSprite spriteWithImageNamed:@"Assets/nuke.png"];
                bonus.positionType = CCPositionTypePoints;
                bonus.position = ccp(284,191.8f);
                bonus.opacity = 0.f;
                [self addChild:bonus];
                CCActionFadeIn *fadeIn =[CCActionFadeIn actionWithDuration:.5f];
                CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:.5f];
                CCActionDelay *delay = [CCActionDelay actionWithDuration:.5f];
                CCActionRemove *actionRemove = [CCActionRemove action];
                CCLabelTTF *label = [CCLabelTTF labelWithString:@"+1" fontName:@"Helvetica" fontSize:10];
                label.positionType = CCPositionTypePoints;
                label.position = ccp(300,208.3f);
                label.opacity = 0.f;
                [self addChild:label];
                [label runAction:[CCActionSequence actions:delay,fadeIn, fadeOut, actionRemove, nil]];
                [bonus runAction:[CCActionSequence actions:fadeIn,delay,fadeOut, actionRemove, nil]];
                
                break;
            }
            case 4:{
                break;
            }
        }
    }];
    CCActionDelay *shortDelay = [CCActionDelay actionWithDuration:1.6f];
    [self runAction:[CCActionSequence actions:delay, awardBlock, shortDelay, block, nil]];
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
    [overlay removeChild:bladeCost1];
    [overlay removeChild:bladeCost2];
    [overlay removeChild:buyBlades];
    [overlay removeChild:bladeCostLabel];
    [overlay removeChild:_gold];
    [overlay removeChild:_goldCount];
    [overlay removeChild: _shopping];
    [overlay removeChild: _shoppingLabel];
    overlay.visible = false;
    _pauseButton.visible = true;
    _bomb.visible = true;
    roundLabel.visible = true;
    _bombCount.visible = true;
    bladeCount.visible = true;
    bladeButton.visible = true;
    timer.visible = true;

    NSString *text = [NSString stringWithFormat:@"%d", roundCount];
    [self newRound:text];
    [self initRound:roundCount];
}



// -----------------------------------------------------------------

@end





