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
#import "LowAlert.h"
// -----------------------------------------------------------------

@implementation Gameplay{
    CCPhysicsNode *_physicsNode;//Physics node for all objects to be included to be added to
    CCLabelTTF *_scoreLabel;    //Label to store the score during gameplay
    CCLabelTTF *roundLabel;     //Top left label that flashes during the start of a new round showing the current round number
    CCNode *_barn;              //Node to store the barn to be added to the physiscs node and removed after being destroyed
    CCNode* horse;              //Node to store the horse to be added at initialization and moved after running has began
    CCNode* _tractor;           //Node to store the tractor from CCB file and have it pick up the house before running has began
    CCNode* chicken;            //Node to store the chicken from CCB file so it can be moved to horses wagon after running has began
    CCTime _timeSinceLastCollision; //Flag to store time between egg kills for multikill medals
    int roundCount;             //Variable used as a parameter in initRound() to customize each round progressively
    int killCount;              //Used to store accuracy of eggs crushed. Reset if ratio is above 1:1
    int totalTargetsLaunched;   //USed to track cumulative amount of targets launched to track perfect round medals
    int targetsDestroyed;       //USed to track cumulative amount of targets destoryed to track perfect round medals
    int shotCount;              //Used to calculate killcount ratio
    int medalId;                //Flag to store amount of medals user is rewarded at any point. Allows for cusomization of sprite location
    float _health;              //Variable to store the health of the barn during gameplay
    CCButton *_pauseButton;     //Button available during gameplay to pause the game
    CCButton *_bomb;            //Nuke button available during gameplay to nuke eggs
    CCLabelTTF *_bombCount;     //Label to display amount of bombs available during gameplay
    CCLabelTTF *bladeCount;     //Label to display amount of blades available during gameplay
    CCProgressNode *_progressNode;  //Progress node beneath barn during gameplay to display _health variable
    CCNode *overlay;            //Overlay that is added after each round and in turn all following variables are added to
    CCLabelTTF *complete;       //Label that shows round number is complete then lifted away
    CCLabelTTF *rank;           //Rank label shown in the top left corner on overlay screen
    CCLabelTTF *user;           //User name from NSUserDefaults and core data displayed in the top left corner
    CCSprite *icon;             //User rank icon shown in the top left corner
    CCSprite *base;             //Base for the rank progress node to next level for a dark halo
    CCProgressNode *_progress;  //Progress bar for progress to next rank placed directly above base
    CCLabelTTF *_upgradesLabel; //Label "Upgrades" above the purchasing buttons
    CCLabelTTF *_costLabel;     //Label "Cost" above the golden eggs for each purchaseable item
    CCSprite *_costRepair1;     //1st Sprite to display the cost of barn repairs
    CCSprite *_costRepair2;     //2nd Sprite to display the cost of barn repairs
    CCSprite *_costBomb;        //Sprite to display 1 Gold Egg for the price of nukes
    CCSprite *bomb;             //White overlay that is added then removed when nuke is pressed
    CCButton *_buyBombsButton;  //Button to purchase nukes
    CCLabelTTF *_nukes;         //Label attached to _buyBombsButton in overlay that shows amount of nukes player has
    CCButton *_repairButton;    //Button to purchase barn repairs
    CCLabelTTF *_repairs;       //Label that is attached to _repairButton that labels button
    CCButton *_shopping;        //Button to bring users to in app purchases
    CCLabelTTF *_shoppingLabel; //Label underneath the armory button
    CCSprite *_gold;            //Image next to gold count label
    CCLabelTTF *_goldCount;     //Label showing the amount of gold user has
    CCButton *buyBlades;        //Button with pitchfork sprite to purchase blades
    CCSprite *bladeCost1;       //1st Golden Egg for cost of blades
    CCSprite *bladeCost2;       //2nd Golden Egg for cost of blades
    CCLabelTTF *bladeCostLabel; //Label attached to the blade to show the amount of blades user has
    CCButton *_nextRoundButton; //Button to remove overlay and all children, then initiate the next round
    CCLabelTTF *nextRound;      //Label added and removed from overlay to label the next round button
    CGPoint _startPoint;        //Tracks where the  user's touch moved start point is. Updated through the update method every hundredth of a second
    CGPoint _endPoint;          //Tracks where the  user's touch moved end point is. Updated through the update method every hundredth of a second
    CCNode *blade;              //Blade for CCMotionStreak. Need this to access across multiple methods.
    CCMotionStreak *streak;     //CCMotionStreak for pitchfork. Need this to access accross multiple methods
    int timeRemain;             //CCTimer subtracts from this variable to track pitchfork time remaining
    int bladeActive;            //Flag to check if the pitchfork is currently active
    CCButton *bladeButton;      //Button to activate pitchforks during gameplay
    CCLabelTTF *timer;          //Timer label that shows how much time is left for pitchforks
    int exp;                    //Varaible to hold amount of eggs crushed with nuke to be awarded after
    float minLaunch;            //Minimum time for launch for round. Changed after each round
    float maxLaunch;            //Maximum time for launch for round. Changed after each round
    float randomLaunch;         //Random Time for launch calculated from minLaunch and MaxLaunch
    CCLabelTTF *instructions;   //Instructions for tutorial. Changed after each tutorial sequence
    CCButton *continueButton;   //ContinueButton that is added and removed during tutorial
    CCNode *_background;
    CCNode *_background1;
    CCNode *_background2;
    CCNode *_backgroundTop1;
    CCNode *_backgroundTop2;
    CCNode *_backgroundBack1;
    CCNode *_backgroundBack2;
    bool running;
    bool isLow;
    bool isSlower;
    CCSprite *lowGas;
    CCNode* _ground;
    int currentSequence;
    int seq1;
    int seq2;
    int seq3;
    int seq4;
    int min;
    int max;
    int range;
    int random;
    
    CCLabelTTF *upLab1;
    CCLabelTTF *rightLab1;
    CCLabelTTF *downLab1;
    CCLabelTTF *leftLab1;
    
    CCLabelTTF *upLab2;
    CCLabelTTF *rightLab2;
    CCLabelTTF *downLab2;
    CCLabelTTF *leftLab2;
    
    CCLabelTTF *upLab3;
    CCLabelTTF *rightLab3;
    CCLabelTTF *downLab3;
    CCLabelTTF *leftLab3;
    
    CCLabelTTF *upLab4;
    CCLabelTTF *rightLab4;
    CCLabelTTF *downLab4;
    CCLabelTTF *leftLab4;
    
    UISwipeGestureRecognizer * swipeUp;
    UISwipeGestureRecognizer * swipeRight;
    UISwipeGestureRecognizer * swipeDown;
    UISwipeGestureRecognizer * swipeLeft;
    
    CCSprite *alert;
    
    
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    self.userInteractionEnabled = TRUE;
    _physicsNode.collisionDelegate = self;
    _health = 100.f;
    roundCount=1;
    [self addChicken:(self.contentSize.width + 150) y:87.f androtation:0.f andMoveToX:self.contentSize.width - 100 andMoveToY:87.f];
    horse.position = ccp(650,94.5f);
    _tractor.position = ccp(750, _tractor.position.y);
    overlay.visible = false;
    _physicsNode.positionType=CCPositionTypeNormalized;
    _physicsNode.position = ccp(.5f,.5f);
    _barn.zOrder = 1000;
    _barn.physicsBody.collisionType=@"Barn";
    _ground.physicsBody.collisionType = @"Ground";
    CCSprite *sprite = [CCSprite spriteWithImageNamed:@"Assets/progressBarn.png"];
    _progressNode = [CCProgressNode progressWithSprite:sprite];
    _progressNode.type = CCProgressNodeTypeBar;
    _progressNode.midpoint = ccp(0.0f, 0.0f);
    _progressNode.barChangeRate = ccp(1.0f, 0.0f);
    _progressNode.percentage = 100.0f;
    CCSprite *base1 = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
    base1.positionType = CCPositionTypeNormalized;
    base1.position = ccp(0.12f, 0.05f);
    [self addChild:base1];
    _progressNode.positionType = CCPositionTypeNormalized;
    _progressNode.position = ccp(0.12f, 0.05f);
    [self addChild:_progressNode];
    CCTexture *texture = [CCTexture textureWithFile:@"Back.png"];
    streak = [CCMotionStreak streakWithFade:.5f minSeg:.5f width:10.f color:[CCColor colorWithCcColor3b:ccYELLOW] texture:texture];
    [self addChild:streak];
    streak.position = _endPoint;
    blade = [CCBReader load:@"Bullet"];
    blade.visible = false;
    blade.scale = .6;
    if([GameData sharedGameData].newPlayerFlag){
        [GameData sharedGameData].bombCount = 1;
        [GameData sharedGameData].bladeCount = 1;
        _bomb.visible = false;
        bladeButton.visible = false;
        bladeCount.visible = false;
        _bombCount.visible = false;
    }
    _backgroundBack2.anchorPoint = ccp(0, 0);
    _backgroundBack2.position = ccp([_backgroundBack1 boundingBox].size.width - 1, 0);
    _backgroundTop2.anchorPoint = ccp(0, 0);
    _backgroundTop2.position    = ccp([_backgroundTop1 boundingBox].size.width- 15, 0);
    _background2.anchorPoint = ccp(0, 0);
    _background2.position    = ccp([_background1 boundingBox].size.width - 5, 0);
    running = false;
    currentSequence = 1;
    [_bombCount setString:[NSString stringWithFormat:@"%@",[person valueForKey:@"nukes"]]];
    [bladeCount setString:[NSString stringWithFormat:@"%d",[GameData sharedGameData].bladeCount]];
    if(![GameData sharedGameData].newPlayerFlag){
        [self newRound:[NSString stringWithFormat:@"%d",roundCount]];
        [self initRound:roundCount];
    }
    else{
        [self scheduleOnce:@selector(launchEgg)delay:4.5f];
    }
}

- (void)scrollBackground:(CCTime)dt
{
    _background1.position = ccp( _background1.position.x + 1, _background1.position.y );
    _background2.position = ccp( _background2.position.x + 1, _background2.position.y );
    if ( _background1.position.x > [_background1 boundingBox].size.width){
        _background1.position = ccp(_background2.position.x - [_background2 boundingBox].size.width, _background1.position.y );
    }
    if ( _background2.position.x > [_background2 boundingBox].size.width ){
        _background2.position = ccp(_background1.position.x - [_background1 boundingBox].size.width, _background2.position.y );
    }
}
- (void)scrollMid:(CCTime)dt
{
    _backgroundTop1.position = ccp( _backgroundTop1.position.x + 1, _backgroundTop1.position.y );
    _backgroundTop2.position = ccp( _backgroundTop2.position.x + 1, _backgroundTop2.position.y );
    if ( _backgroundTop1.position.x > [_backgroundTop1 boundingBox].size.width){
        _backgroundTop1.position = ccp(_backgroundTop2.position.x - [_backgroundTop2 boundingBox].size.width, _backgroundTop1.position.y );
    }
    if ( _backgroundTop2.position.x > [_backgroundTop2 boundingBox].size.width ){
        _backgroundTop2.position = ccp(_backgroundTop1.position.x - [_backgroundTop1 boundingBox].size.width, _backgroundTop2.position.y );
    }
}
- (void) scrollBack:(CCTime)dt
{
    _backgroundBack1.position = ccp( _backgroundBack1.position.x + 1, _backgroundBack1.position.y );
    _backgroundBack2.position = ccp( _backgroundBack2.position.x + 1, _backgroundBack2.position.y );
    if ( _backgroundBack1.position.x > [_backgroundBack1 boundingBox].size.width){
        _backgroundBack1.position = ccp(_backgroundBack2.position.x - [_backgroundBack2 boundingBox].size.width, _backgroundBack1.position.y );
    }
    if ( _backgroundBack2.position.x > [_backgroundBack2 boundingBox].size.width ){
        _backgroundBack2.position = ccp(_backgroundBack1.position.x - [_backgroundBack1 boundingBox].size.width, _backgroundBack2.position.y );
    }
}

-(void)startRunning{
    horse.position = ccp(700,94.5f);
    horse.scale = .7f;
    CCActionMoveTo *move = [CCActionMoveTo actionWithDuration:1.5f position:ccp(382,94.5)];
    CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.1f position:ccp(700,107)];
    CCActionDelay *delay = [CCActionDelay actionWithDuration:1.1f];
    CCActionCallBlock *blockRun = [CCActionCallBlock actionWithBlock:^(void){
        [self schedule:@selector(scrollBackground:) interval:0.005f];
        [self schedule:@selector(scrollMid:) interval:.08f];
        [self schedule:@selector(scrollBack:) interval:.15f];
        running = true;
    }];
    CCActionDelay *globalDelay = [CCActionDelay actionWithDuration:2.f];
    CCActionMoveTo *passCanon = [CCActionMoveTo actionWithDuration:1.f position:ccp(700,chicken.position.y)];
    CCActionMoveTo *catchUp = [CCActionMoveTo actionWithDuration: 1.5f position:ccp(self.contentSize.width - 80,107)];
    [horse runAction:[CCActionSequence actions:globalDelay,blockRun, delay, move, nil]];
    [chicken runAction:[CCActionSequence actions:globalDelay, passCanon, catchUp,nil]];
    [_tractor runAction:[CCActionMoveTo actionWithDuration:2.f position:ccp(-20.f,_tractor.position.y)]];
    CCActionMoveTo *liftBarn = [CCActionMoveTo actionWithDuration:.5f position:ccp(_barn.position.x,_barn.position.y+20)];
    CCActionDelay *barnDelay = [CCActionDelay actionWithDuration:1.f];
    [_barn runAction:[CCActionSequence actions:barnDelay, liftBarn,nil]];
    [chicken runAction:[CCActionSequence actions:globalDelay, passCanon, lift, catchUp, nil]];
}
-(void)continuePressed{
    [self removeChild:continueButton];
    [self removeChild:instructions];
    [[CCDirector sharedDirector] resume];
}
- (void)swipeLeft {
    if (currentSequence == 1){
        if ([GameData sharedGameData].seq1 == 4){
            currentSequence++;
            [leftLab1 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 2){
        if([GameData sharedGameData].seq2 == 4){
            currentSequence++;
            [leftLab2 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 3){
        if([GameData sharedGameData].seq3 == 4){
            currentSequence++;
            [leftLab3 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 4){
        if([GameData sharedGameData].seq4 == 4){
            currentSequence = 1;
            [leftLab4 setColor:[CCColor greenColor]];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeUp];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeRight];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeDown];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeLeft];
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [leftLab4 setColor:[CCColor greenColor]];
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.3f];
            CCActionFadeOut *fade = [CCActionFadeOut actionWithDuration:.2f];
            CCActionRemove *remove = [CCActionRemove action];
            [leftLab4 runAction:[CCActionSequence actions:block,delay, fade, remove, nil]];
            [alert setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/lowGasComplete.png"]];
            [alert runAction:[CCActionSequence actions:delay, fade, remove, nil]];
        }
    }
}
- (void)swipeRight {
    if (currentSequence == 1){
        if ([GameData sharedGameData].seq1 == 2){
            currentSequence++;
            [rightLab1 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 2){
        if([GameData sharedGameData].seq2 == 2){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [rightLab2 setColor:[CCColor greenColor]];
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:1.f];
            CCActionFadeOut *fade = [CCActionFadeOut actionWithDuration:.2f];
            CCActionRemove *remove = [CCActionRemove action];
            [rightLab2 runAction:[CCActionSequence actions:block,delay, fade, remove, nil]];
        }
    }
    else if (currentSequence == 3){
        if([GameData sharedGameData].seq3 == 2){
            currentSequence++;
            [rightLab3 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 4){
        if([GameData sharedGameData].seq4 == 2){
            currentSequence = 1;
            [rightLab4 setColor:[CCColor greenColor]];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeUp];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeRight];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeDown];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeLeft];
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [rightLab4 setColor:[CCColor greenColor]];
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.3f];
            CCActionFadeOut *fade = [CCActionFadeOut actionWithDuration:.2f];
            CCActionRemove *remove = [CCActionRemove action];
            [rightLab4 runAction:[CCActionSequence actions:block,delay, fade, remove, nil]];
            [alert setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/lowGasComplete.png"]];
            [alert runAction:[CCActionSequence actions:delay, fade, remove, nil]];

        }
    }
}
- (void)swipeDown {
    if (currentSequence == 1){
        if ([GameData sharedGameData].seq1 == 3){
            currentSequence++;
            [downLab1 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 2){
        if([GameData sharedGameData].seq2 == 3){
            currentSequence++;
            [downLab2 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 3){
        if([GameData sharedGameData].seq3 == 3){
            currentSequence++;
            [downLab3 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 4){
        if([GameData sharedGameData].seq4 == 3){
            currentSequence = 1;
            [downLab4 setColor:[CCColor greenColor]];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeUp];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeRight];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeDown];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeLeft];
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [downLab4 setColor:[CCColor greenColor]];
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.3f];
            CCActionFadeOut *fade = [CCActionFadeOut actionWithDuration:.2f];
            CCActionRemove *remove = [CCActionRemove action];
            [downLab4 runAction:[CCActionSequence actions:block,delay, fade, remove, nil]];
            [alert setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/lowGasComplete.png"]];
            [alert runAction:[CCActionSequence actions:delay, fade, remove, nil]];
        }
    }
}
- (void)swipeUp {
    if (currentSequence == 1){
        if ([GameData sharedGameData].seq1 == 1){
            currentSequence++;
            [upLab1 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 2){
        if([GameData sharedGameData].seq2 == 1){
            currentSequence++;
            [upLab2 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 3){
        if([GameData sharedGameData].seq3 == 1){
            currentSequence++;
            [upLab3 setColor:[CCColor greenColor]];
        }
    }
    else if (currentSequence == 4){
        if([GameData sharedGameData].seq4 == 1){
            currentSequence = 1;
            [upLab4 setColor:[CCColor greenColor]];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeUp];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeRight];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeDown];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeLeft];
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [upLab4 setColor:[CCColor greenColor]];
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.3f];
            CCActionFadeOut *fade = [CCActionFadeOut actionWithDuration:.2f];
            CCActionRemove *remove = [CCActionRemove action];
            [upLab4 runAction:[CCActionSequence actions:block,delay, fade, remove, nil]];
            [alert setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/lowGasComplete.png"]];
            [alert runAction:[CCActionSequence actions:delay, fade, remove, nil]];
        }
    }
}

-(void)onEnter{
    [super onEnter];
    [self ShowAlertOnLayer:self];
    if([GameData sharedGameData].newPlayerFlag){
        bladeButton.visible = false;
        bladeCount.visible = false;
        CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
            [[CCDirector sharedDirector] pause];
            instructions = [CCLabelTTF labelWithString:@"Tap on an egg to crack it before it hits the barn." fontName:@"Helvetica" fontSize:32 dimensions:CGSizeMake(300, 200)];
            instructions.positionType = CCPositionTypeNormalized;
            instructions.position = ccp(.5f,.3f);
            [self addChild:instructions];
            continueButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
            continueButton.positionType = CCPositionTypeNormalized;
            continueButton.position = ccp(.5f, .1f);
            [continueButton setTarget:self selector:@selector(continuePressed)];
            [self addChild:continueButton];
        }];
        CCActionDelay *delay1 = [CCActionDelay actionWithDuration:.01f];
        CCActionDelay *delay = [CCActionDelay actionWithDuration:5.f];
        
        CCActionCallBlock *block2 = [CCActionCallBlock actionWithBlock:^(void){
            [[CCDirector sharedDirector] pause];
            [self addChild:continueButton];
            [self addChild:instructions];
            _bomb.visible = true;
            _bombCount.visible = true;
            _bomb.enabled = false;
            [instructions setString:@"Nukes blow up all eggs on the screen."];
        }];
        CCActionCallBlock *block3 = [CCActionCallBlock actionWithBlock:^(void){
            [[CCDirector sharedDirector] pause];
            [self addChild:continueButton];
            [self addChild:instructions];
            [instructions setString:@"You can purchase nukes with gold eggs or get rewarded with one after completing a round"];
        }];
        CCActionCallBlock *block4 = [CCActionCallBlock actionWithBlock:^(void){
            [self addChild:instructions];
            _bomb.enabled = true;
            [instructions setString:@"Nuke em to continue."];
            [[CCDirector sharedDirector] pause];
        }];
        [self runAction:[CCActionSequence actions:delay,block, delay, block2, delay1, block3, delay1, block4,  nil]];
    }
}
-(void)addChicken:(float)x y:(float)y androtation:(float)rotation andMoveToX:(float)movex andMoveToY:(float)movey{
    if (roundCount == 1){
    CGPoint point =  CGPointMake(x,y);
    chicken.position = point;
    chicken.rotation = rotation;
    id moveCk=[CCActionMoveTo actionWithDuration:2.0f position:ccp(movex,movey)];
    id delay = [CCActionDelay actionWithDuration: .5f];
    [chicken runAction:[CCActionSequence actions: delay, moveCk, nil]];
    }
    else{
        chicken = [CCBReader load:@"Canon"];
        CGPoint point =  CGPointMake(x,y);
        chicken.position = point;
        chicken.rotation = rotation;
        id moveCk=[CCActionMoveTo actionWithDuration:2.0f position:ccp(movex,movey)];
        id delay = [CCActionDelay actionWithDuration: .5f];
        [self addChild:chicken];
        [chicken runAction:[CCActionSequence actions: delay, moveCk, nil]];
    }
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
    if([GameData sharedGameData].newPlayerFlag){
        CCActionDelay *delay1 = [CCActionDelay actionWithDuration:.01f];
        CCActionCallBlock *block2 = [CCActionCallBlock actionWithBlock:^(void){
            [[CCDirector sharedDirector] pause];
            [self addChild:continueButton];
            [self addChild:instructions];
            _bomb.visible = true;
            _bombCount.visible = true;
            [instructions setString:@"If you are lucky, a chicken will drop you a golden egg."];
        }];
        CCActionCallBlock *block3 = [CCActionCallBlock actionWithBlock:^(void){
            [[CCDirector sharedDirector] pause];
            [self addChild:continueButton];
            [self addChild:instructions];
            [instructions setString:@"Golden eggs are your currency, they buy you pitch forks, nukes, and repair your barn."];
        }];
        CCActionCallBlock *block4 = [CCActionCallBlock actionWithBlock:^(void){
            [[CCDirector sharedDirector] pause];
            [self addChild:continueButton];
            [self addChild:instructions];
            [instructions setString:@"collect golden eggs by tapping on them."];
        }];
        [self runAction:[CCActionSequence actions:block2, delay1, block3, delay1,block4, nil]];
    }
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
            if([GameData sharedGameData].newPlayerFlag){
                [[CCDirector sharedDirector] resume];
                CCActionDelay *delay = [CCActionDelay actionWithDuration:5.f];
                CCActionDelay *delay1 = [CCActionDelay actionWithDuration:.01f];
                CCActionCallBlock *block2 = [CCActionCallBlock actionWithBlock:^(void){
                    [[CCDirector sharedDirector] pause];
                    [self addChild:continueButton];
                    [self addChild:instructions];
                    bladeButton.visible = true;
                    bladeCount.visible = true;
                    bladeButton.enabled = false;
                    [instructions setString:@"Pitchforks allow you to slice eggs by sliding across the screen."];
                }];
                CCActionCallBlock *block3 = [CCActionCallBlock actionWithBlock:^(void){
                    [[CCDirector sharedDirector] pause];
                    [self addChild:continueButton];
                    [self addChild:instructions];
                    [instructions setString:@"Pitchforks last for 15 seconds."];
                }];
                CCActionCallBlock *block4 = [CCActionCallBlock actionWithBlock:^(void){
                    [[CCDirector sharedDirector] pause];
                    [self addChild:instructions];
                    bladeButton.enabled = true;
                    [instructions setString:@"Use your pitchfork to continue"];
                }];
                
                [self runAction:[CCActionSequence actions:delay,block2,delay1,block3,delay1,block4, nil]];
            }
            nodeB.positionType = CCPositionTypeNormalized;
            nodeB.physicsBody.sensor = true;
            CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.5f position:ccp(nodeB.position.x, 1.1f)];
            CCActionRemove *actionRemove = [CCActionRemove action];
            [nodeB runAction:[CCActionSequence actionWithArray:@[lift, actionRemove]]];
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
    }
    if([GameData sharedGameData].newPlayerFlag){
        [[CCDirector sharedDirector] resume];
        [self removeChild:instructions];
        CCActionDelay *delay = [CCActionDelay actionWithDuration:1.5f];
        CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
            [self addChild:instructions];
            [instructions setString:@"You're all caught up, good luck!"];
            [[CCDirector sharedDirector]pause];
            [self addChild:continueButton];
        }];
        CCActionDelay *delay1 = [CCActionDelay actionWithDuration:15.f];
        CCActionCallBlock *block1 = [CCActionCallBlock actionWithBlock:^(void){
            [self removeChild:instructions];
            [GameData sharedGameData].score = 0;
            [_scoreLabel setString:@"0"];
            [GameData sharedGameData].newPlayerFlag = false;
            [self unschedule:@selector(launchEgg)];
            [self newRound:[NSString stringWithFormat:@"%d",roundCount]];
            [self initRound:roundCount];
        }];
        [self runAction:[CCActionSequence actions:delay1,block, delay, block1, nil]];
    }
}
-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if(bladeActive == 1){
        CGPoint location = [touch locationInNode:self];
        _endPoint = location;
        [self doStep:.001f];
    }
}
-(void)touchEnded:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if (blade){
        [_physicsNode removeChild:blade];
    }
}
-(void)touchCancelled:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if (blade){
        [_physicsNode removeChild:blade];
    }
}
- (void)doStep:(CCTime)delta
{
    //update the blades position
    blade.position = _endPoint;
    [streak setPosition:_endPoint];
}
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
        int newBombCount = person.nukes.intValue;
        newBombCount++;
        NSNumber *coreBombs = [NSNumber numberWithInt:newBombCount];
        [person setValue:coreBombs forKey:@"nukes"];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
        int newAmount = person.gold.intValue - 1;
        [_nukes setString:[NSString stringWithFormat:@"%@",[person valueForKey:@"nukes"]]];
        [_bombCount setString:[NSString stringWithFormat:@"%@",[person valueForKey:@"nukes"]]];
        [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
        [_goldCount setString:[NSString stringWithFormat:@"X %d", person.gold.intValue]];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
    }
    else{
        id block = ^(void){
            buyBlades.enabled = true;
            _buyBombsButton.enabled = true;
            _repairButton.enabled = true;
            _shopping.enabled = true;
            _nextRoundButton.enabled = true;
        };
        buyBlades.enabled = false;
        _buyBombsButton.enabled = false;
        _repairButton.enabled = false;
        _shopping.enabled = false;
        _nextRoundButton.enabled = false;
        [AlertView ShowAlert:@"You do not have enough gold!" onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
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
        id block = ^(void){
            buyBlades.enabled = true;
            _buyBombsButton.enabled = true;
            _repairButton.enabled = true;
            _shopping.enabled = true;
            _nextRoundButton.enabled = true;
        };
        buyBlades.enabled = false;
        _buyBombsButton.enabled = false;
        _repairButton.enabled = false;
        _shopping.enabled = false;
        _nextRoundButton.enabled = false;
        
        [AlertView ShowAlert:@"You do not have enough gold!" onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
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
            buyBlades.enabled = true;
            _buyBombsButton.enabled = true;
            _repairButton.enabled = true;
            _shopping.enabled = true;
            _nextRoundButton.enabled = true;
        };
        buyBlades.enabled = false;
        _buyBombsButton.enabled = false;
        _repairButton.enabled = false;
        _shopping.enabled = false;
        _nextRoundButton.enabled = false;
        [AlertView ShowAlert:@"You do not have enough gold!" onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
    }
}
- (void)launchEggTopRight {
    totalTargetsLaunched++;
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
    int miny = 1;
    int maxy = 3;
    int rangey = maxy - miny;
    int randomy = (arc4random() % rangey) + miny;
    if(![GameData sharedGameData].newPlayerFlag){
        if (randomy == 2){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [self flyingChicken];
            }];
            int min1 = 5;
            int max1 = 15;
            int range1 = max1 - min1;
            int random1 = (arc4random() % range1) + min;
            CCActionDelay *delay = [CCActionDelay actionWithDuration:random1];
            [self runAction:[CCActionSequence actions:delay, block, nil]];
        }
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
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
            }
                break;
            case 2:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self startRunning];
                break;
            }
            case 3:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self addChicken:self.contentSize.width+50 y:self.contentSize.height-100 androtation:-45 andMoveToX:self.contentSize.width andMoveToY:self.contentSize.height-100];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                break;
            }
            case 4:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                break;
            }
            case 5:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                break;
            }
            case 6:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                break;
            }
            case 7:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                break;
            }
            case 8:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                break;
            }
    }
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Egg:(CCNode *)nodeA Bullet:(CCNode *)nodeB {
    _timeSinceLastCollision = 0.0;
    medalId++;
    targetsDestroyed++;
    if (![GameData sharedGameData].newPlayerFlag){
        [GameData sharedGameData].score++;
    }
        [[_physicsNode space] addPostStepBlock:^{
            [self eggRemoved:nodeA];
        } key:nodeA];
    if (bladeActive == 0){
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
        else if (killCount == 99 || ((killCount%99) == 0 && killCount!= 0)){
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/100.png"];
            [self rewardMedal:spree andLabel:@"Unstoppable" andExp:10];
        }
    }
}

- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Egg:(CCNode *)nodeA Ground:(CCNode *)nodeB {
    [[_physicsNode space] addPostStepBlock:^{
        if(running){
            [self eggReflected:nodeA];
        }
    } key:nodeA];
}
-(void)eggReflected:(CCNode*)egg{
    int minforce = 1000;
    int maxforce = 1500;
    int rangeforce = maxforce - minforce;
    int randomforce = (arc4random() % rangeforce) + minforce;
    CGPoint launchDirection = ccp(20,-10);
    CGPoint force = ccpMult(launchDirection, randomforce);
    [egg.physicsBody applyForce:force];
    CCActionDelay *delay = [CCActionDelay actionWithDuration:2.f];
    CCActionRemove *remove = [CCActionRemove action];
    [egg runAction:[CCActionSequence actions:delay,remove, nil]];
}

-(void)bombPressed{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    if (person.nukes.intValue > 0){
        int bombs = person.nukes.intValue;
        bombs--;
        NSNumber *coreNukes = [NSNumber numberWithInt:bombs];
        [person setValue:coreNukes forKey:@"nukes"];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
        [_bombCount setString:[NSString stringWithFormat:@"%@",[person valueForKey:@"nukes"]]];
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
        if([GameData sharedGameData].newPlayerFlag){
            [[CCDirector sharedDirector] resume];
            [self removeChild:instructions];
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [self flyingChicken];
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:5.f];
            
            [self runAction:[CCActionSequence actions:delay,block, nil]];
        }
    }
}
-(void)armoryPressed{

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
    }
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"EggHit"];
    explosion.scale = .5f;
    explosion.autoRemoveOnFinish = TRUE;
    explosion.position = egg.position;
    [self addChild:explosion];
    [egg removeFromParent];
}
- (void)barnExp:(CCNode *)barn {
    [self unschedule:@selector(launchEgg)];
    if (roundCount >= 3){
        [self unschedule:@selector(launchEggTopRight)];
    }
    [GameData sharedGameData].round = roundCount;
    CCParticleSystem *explosion = (CCParticleSystem *)[CCBReader load:@"EggHit"];
    explosion.scale = 2.f;
    explosion.autoRemoveOnFinish = TRUE;
    explosion.position = barn.position;
    [self addChild:explosion];
    [barn removeFromParent];
}

- (void)update:(CCTime)delta {
    _timeSinceLastCollision += delta;
    if (killCount < shotCount){
        killCount = 0;
        shotCount = 0;
    }
    if ( _timeSinceLastCollision > .21f ) {
            if(medalId==2){
                CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/2.png"];
                [self rewardMedal:spree andLabel:@"Double Kill" andExp:5];    }
            else if(medalId==4){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/3.png"];
                [self rewardMedal:triple andLabel:@"Triple Kill" andExp:5];
            }
            else if(medalId==6){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/4.png"];
                [self rewardMedal:triple andLabel:@"Over Kill" andExp:5];
            }
            else if(medalId==8){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/5.png"];
                [self rewardMedal:triple andLabel:@"KillTacular" andExp:5];
            }
            else if(medalId==10){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/6.png"];
                [self rewardMedal:triple andLabel:@"Killpocalypse" andExp:5];
            }
            else if(medalId==12){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/7.png"];
                [self rewardMedal:triple andLabel:@"7" andExp:10];
            }
            else if(medalId==14){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/8.png"];
                [self rewardMedal:triple andLabel:@"8" andExp:10];
            }
            else if(medalId==16){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/9.png"];
                [self rewardMedal:triple andLabel:@"9" andExp:10];
            }
            else if((medalId%18) == 0 && medalId !=0){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/10.png"];
                [self rewardMedal:triple andLabel:@"10" andExp:10];
            }
            medalId = 0;
    }
}
- (void)eggRemoved:(CCNode *)egg {
    CCNode *explosion = (CCNode *)[CCBReader load:@"LeftShot"];
    killCount++;
    if(![GameData sharedGameData].newPlayerFlag){
        [_scoreLabel setString:[NSString stringWithFormat:@"%li", [GameData sharedGameData].score]];
    }
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
    CCActionDelay *delay =  [CCActionDelay actionWithDuration:.6f];
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
        int fourCount = person.four.intValue;
        fourCount++;
        [person setValue:[NSNumber numberWithInt:fourCount] forKey:@"four"];
    }
    else if ([input isEqualToString:@"KillTacular"]){
        int fiveCount = person.five.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"five"];
    }
    else if ([input isEqualToString:@"Killpocalypse"]){
        int fiveCount = person.six.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"six"];
    }
    else if ([input isEqualToString:@"7"]){
        int fiveCount = person.seven.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"seven"];
    }
    else if ([input isEqualToString:@"8"]){
        int fiveCount = person.eight.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"eight"];
    }
    else if ([input isEqualToString:@"9"]){
        int fiveCount = person.nine.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"nine"];
    }
    else if ([input isEqualToString:@"10"]){
        int fiveCount = person.ten.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"ten"];
    }
    else if ([input isEqualToString:@"Killing Spree"]){
        int twentyCount = person.twenty.intValue;
        twentyCount++;
        NSNumber *conv = [NSNumber numberWithInt:twentyCount];
        [person setValue:conv forKey:@"twenty"];
    }
    else if ([input isEqualToString:@"Killing Frenzy"]){
        int fortyCount = person.forty.intValue;
        fortyCount++;
        [person setValue:[NSNumber numberWithInt:fortyCount] forKey:@"forty"];
    }
    else if ([input isEqualToString:@"Running Riot"]){
        int sixtyCount = person.sixty.intValue;
        sixtyCount++;
        [person setValue:[NSNumber numberWithInt:sixtyCount] forKey:@"sixty"];
    }
    else if ([input isEqualToString:@"Psycho"]){
        int sixtyCount = person.eighty.intValue;
        sixtyCount++;
        [person setValue:[NSNumber numberWithInt:sixtyCount] forKey:@"eighty"];
    }
    else if ([input isEqualToString:@"Unstoppable"]){
        int sixtyCount = person.hundred.intValue;
        sixtyCount++;
        [person setValue:[NSNumber numberWithInt:sixtyCount] forKey:@"hundred"];
    }
    else if ([input isEqualToString:@"Perfect Round"]){
        int perfect = person.perfect.intValue;
        perfect++;
        [person setValue:[NSNumber numberWithInt:perfect] forKey:@"perfect"];
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
    totalTargetsLaunched++;
    CCNode* egg = [CCBReader load:@"Egg"];
    egg.positionType = CCPositionTypePoints;
    if(!running){
        egg.position = ccp(440.f,120.f);
    }else{
        egg.position = ccp(470.f,150.f);
    }
    egg.scale = 0.6f;
    egg.rotation = -45.0f;
    int miny = 5;
    int maxy = 15;
    int rangey = maxy - miny;
    int randomy = (arc4random() % rangey) + miny;
    CGPoint launchDirection = ccp(-10,randomy);
    int minforce = 500;
    int maxforce = 3000;
    int rangeforce = maxforce - minforce;
    int randomforce = (arc4random() % rangeforce) + minforce;
    CGPoint force = ccpMult(launchDirection, randomforce);
    [_physicsNode addChild:egg];
    [egg.physicsBody applyForce:force];
    if(roundCount ==1){
            int minTime = .9f * 1000;
            int maxTime = 1.2f * 1000;
            int rangeTime = maxTime - minTime;
            int a = (arc4random() % rangeTime) + minTime;
            float randomTime = a/1000.f;
            [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        //Check if tutorial is running. If it isnt, finish round 1. Only needed for round 1
        if(![GameData sharedGameData].newPlayerFlag){
        if (targetsLaunched == 10){
                CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                    if (totalTargetsLaunched == targetsDestroyed){
                        totalTargetsLaunched = 0;
                        targetsDestroyed = 0;
                        [self rewardMedal:[CCSprite spriteWithImageNamed:@"Assets/Perfect.png"] andLabel:@"Perfect Round" andExp:10];
                    }
                }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:3.f];
            [self runAction:[CCActionSequence actions:delay,block,nil]];
            [self unschedule:@selector(launchEgg)];
            }
        }
    }
    if(roundCount ==2){
        int minTime = .5f * 1000;
        int maxTime = .8f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        if (targetsLaunched == 20){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                if (totalTargetsLaunched == targetsDestroyed){
                    totalTargetsLaunched = 0;
                    targetsDestroyed = 0;
                    CCLOG(@"PERFECT");
                    [self rewardMedal:[CCSprite spriteWithImageNamed:@"Assets/Perfect.png"] andLabel:@"Perfect Round" andExp:10];
                }
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:3.f];
            [self runAction:[CCActionSequence actions:delay,block,nil]];
            [self unschedule:@selector(launchEgg)];
        }
    }
    if (roundCount == 3){
        int minTime = .8f * 1000;
        int maxTime = 1.2f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (targetsLaunched == 40){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                if (totalTargetsLaunched == targetsDestroyed){
                    totalTargetsLaunched = 0;
                    targetsDestroyed = 0;
                    [self rewardMedal:[CCSprite spriteWithImageNamed:@"Assets/Perfect.png"] andLabel:@"Perfect Round" andExp:10];
                }
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:3.f];
            [self runAction:[CCActionSequence actions:delay,block,nil]];
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
        }
    }
    if (roundCount == 4){
        int minTime = .5f * 1000;
        int maxTime = 1.f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (targetsLaunched == 90){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                if (totalTargetsLaunched == targetsDestroyed){
                    totalTargetsLaunched = 0;
                    targetsDestroyed = 0;
                    [self rewardMedal:[CCSprite spriteWithImageNamed:@"Assets/Perfect.png"] andLabel:@"Perfect Round" andExp:10];
                }
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:3.f];
            [self runAction:[CCActionSequence actions:delay,block,nil]];
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
        }
    }
    if (roundCount == 5){
        int minTime = .4f * 1000;
        int maxTime = .6f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (targetsLaunched == 190){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                if (totalTargetsLaunched == targetsDestroyed){
                    totalTargetsLaunched = 0;
                    targetsDestroyed = 0;
                    [self rewardMedal:[CCSprite spriteWithImageNamed:@"Assets/Perfect.png"] andLabel:@"Perfect Round" andExp:10];
                }
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:3.f];
            [self runAction:[CCActionSequence actions:delay,block,nil]];
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
        }
    }
    if (roundCount == 6){
        int minTime = .3f * 1000;
        int maxTime = .6f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (targetsLaunched == 290){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                if (totalTargetsLaunched == targetsDestroyed){
                    totalTargetsLaunched = 0;
                    targetsDestroyed = 0;
                    [self rewardMedal:[CCSprite spriteWithImageNamed:@"Assets/Perfect.png"] andLabel:@"Perfect Round" andExp:10];
                }
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:3.f];
            [self runAction:[CCActionSequence actions:delay,block,nil]];
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
        }
    }
    if (roundCount == 7){
        int minTime = .2f * 1000;
        int maxTime = .5f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (targetsLaunched == 385){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                if (totalTargetsLaunched == targetsDestroyed){
                    totalTargetsLaunched = 0;
                    targetsDestroyed = 0;
                    [self rewardMedal:[CCSprite spriteWithImageNamed:@"Assets/Perfect.png"] andLabel:@"Perfect Round" andExp:10];
                }
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:3.f];
            [self runAction:[CCActionSequence actions:delay,block,nil]];
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
        }
    }
    if (roundCount == 8){
        int minTime = .2f * 1000;
        int maxTime = .4f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (targetsLaunched == 385){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                if (totalTargetsLaunched == targetsDestroyed){
                    totalTargetsLaunched = 0;
                    targetsDestroyed = 0;
                    [self rewardMedal:[CCSprite spriteWithImageNamed:@"Assets/Perfect.png"] andLabel:@"Perfect Round" andExp:10];
                }
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:3.f];
            [self runAction:[CCActionSequence actions:delay,block,nil]];
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
        }
    }
    if(![GameData sharedGameData].newPlayerFlag){
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
}
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
        [_bombCount setString:[NSString stringWithFormat:@"%@",[person valueForKey:@"nukes"]]];
        [_nukes setString:[NSString stringWithFormat:@"%@",[person valueForKey:@"nukes"]]];
        rank = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"temp"] fontName:@"Helvetica" fontSize:18];
        [overlay addChild:rank];
        user = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"temp"] fontName:@"Helvetica" fontSize:22];
        [overlay addChild:user];
        icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
        icon.scale = .8f;
        [overlay addChild:icon];
        [[GameData sharedGameData] summarizeRank:rank andUser:user andRankIcon:icon];
        base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
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
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank1.intValue;
            float preTemp = (float)experience/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 1){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank2.intValue;
            int nextRank = [GameData sharedGameData].rank1.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 2){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank3.intValue;
            int nextRank = [GameData sharedGameData].rank2.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;            }
        else if (rank1 == 3){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank4.intValue;
            int nextRank = [GameData sharedGameData].rank3.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 4){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank5.intValue;
            int nextRank = [GameData sharedGameData].rank4.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 5){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank6.intValue;
            int nextRank = [GameData sharedGameData].rank5.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 6){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank7.intValue;
            int nextRank = [GameData sharedGameData].rank6.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 7){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank8.intValue;
            int nextRank = [GameData sharedGameData].rank7.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 8){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank9.intValue;
            int nextRank = [GameData sharedGameData].rank8.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 9){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank10.intValue;
            int nextRank = [GameData sharedGameData].rank9.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 10){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank11.intValue;
            int nextRank = [GameData sharedGameData].rank10.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 11){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank12.intValue;
            int nextRank = [GameData sharedGameData].rank11.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 12){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank13.intValue;
            int nextRank = [GameData sharedGameData].rank12.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 13){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank14.intValue;
            int nextRank = [GameData sharedGameData].rank13.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 14){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank15.intValue;
            int nextRank = [GameData sharedGameData].rank14.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 15){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank16.intValue;
            int nextRank = [GameData sharedGameData].rank15.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 16){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank17.intValue;
            int nextRank = [GameData sharedGameData].rank16.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 17){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank18.intValue;
            int nextRank = [GameData sharedGameData].rank17.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 18){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank19.intValue;
            int nextRank = [GameData sharedGameData].rank18.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 19){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank20.intValue;
            int nextRank = [GameData sharedGameData].rank19.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 20){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank21.intValue;
            int nextRank = [GameData sharedGameData].rank20.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 21){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank22.intValue;
            int nextRank = [GameData sharedGameData].rank21.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 22){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank23.intValue;
            int nextRank = [GameData sharedGameData].rank22.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 23){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank24.intValue;
            int nextRank = [GameData sharedGameData].rank23.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        else if (rank1 == 24){
            int experience = person.experience.intValue;
            int currentRank = [GameData sharedGameData].rank25.intValue;
            int nextRank = [GameData sharedGameData].rank24.intValue;
            int currentRankExp = experience - nextRank;
            float preTemp = (float)currentRankExp/(float)currentRank *100;
            _progress.percentage=preTemp;
        }
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.2f,.65f);
        [overlay addChild:_progress];
        
        _nextRoundButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"]];
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
        
        _repairButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/Repair.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/RepairPressed.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/Repair.png"]];
        _repairButton.positionType = CCPositionTypeNormalized;
        _repairButton.position = ccp(.65f,.5f);
        [_repairButton setTarget:self selector:@selector(repairPurchased)];
        [overlay addChild:_repairButton];
        
        _repairs = [CCLabelTTF labelWithString:@"Repairs" fontName:@"Helvetica" fontSize:14];
        _repairs.positionType = CCPositionTypeNormalized;
        _repairs.position = ccp(.65f,.42f);
        [overlay addChild:_repairs];
        
            
        _buyBombsButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/nuke.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/nukeNil.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/nuke.png"]];
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
        
        buyBlades = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/blade.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/bladeNil.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/blade.png"]];
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
        _gold = [CCSprite spriteWithImageNamed:@"Assets/GoldEgg.png"];
        _gold.positionType = CCPositionTypeNormalized;
        _gold.position = ccp(.1f,.4f);
        [overlay addChild:_gold];
            
            
        _goldCount = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %d", person.gold.intValue ] fontName:@"Helvetica" fontSize:28];
        _goldCount.positionType = CCPositionTypeNormalized;
        _goldCount.position = ccp(.2f,.4f);
        [overlay addChild:_goldCount];
        
        _shopping = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/Shop.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/ShopPressed.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/Shop.png"]];
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
        int min1 = 1;
        int max1 = 4;
        int range1 = max1 - min1;
        int random1 = (arc4random() % range1) + min1;
        switch (random1){
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
                int bombs = person.nukes.intValue;
                bombs++;
                [person setValue:[NSNumber numberWithInt:bombs] forKey:@"nukes"];
                NSError *error2 = nil;
                if (![person.managedObjectContext save:&error2]) {
                    NSLog(@"Unable to save managed object context.");
                    NSLog(@"%@, %@", error2, error2.localizedDescription);
                }
                [_bombCount setString:[NSString stringWithFormat:@"%@",[person valueForKey:@"nukes"]]];
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






- (void)ShowAlertOnLayer: (CCNode *) layer{
    //[self alertStarted];
    static int one;
    static int two;
    static int three;
    static int four;
    
    alert = [CCSprite spriteWithImageNamed:@"Assets/lowGas.png"];
    alert.name = @"1234";
    alert.positionType = CCPositionTypeUIPoints;
    alert.scaleType = CCScaleTypeScaled;
    alert.anchorPoint  = ccp(.5f,.5f);
    alert.position = ccp(120,160);
    
    float fontSize = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?30:18;
    for (int i = 0; i<4; i++){
        min = 1;
        max = 5;
        range = max - min;
        random = (arc4random() % range) + min;
        if (i==0){
            one = random;
            seq1 = one;
            if (seq1 == 1){
                NSString *up = [NSString stringWithFormat:@"↑"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 1;
                    upLab1 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    upLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 1;
                    upLab2 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    upLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 1;
                    upLab3 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    upLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 1;
                    upLab4 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    upLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab4];
                }
            }
            if (seq1 == 2){
                NSString *right = [NSString stringWithFormat:@"→"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 2;
                    rightLab1 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab1.position = ccp(alert.contentSize.width - alert.contentSize.width+ 10, alert.contentSize.height + 10);
                    rightLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 2;
                    rightLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    rightLab2 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 2;
                    rightLab3 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    rightLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 2;
                    rightLab4 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    rightLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab4];
                }
            }
            if (seq1 == 3){
                NSString *down = [NSString stringWithFormat:@"↓"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 3;
                    downLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    downLab1 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 3;
                    downLab2 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab2.position = ccp(alert.contentSize.width - alert.contentSize.width+ 35, alert.contentSize.height + 10);
                    downLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 3;
                    downLab3 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    downLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 3;
                    downLab4 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    downLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab4];
                }
            }
            if (seq1 == 4){
                NSString *left = [NSString stringWithFormat:@"←"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 4;
                    leftLab1 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    leftLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 4;
                    leftLab2 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    leftLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 4;
                    leftLab3 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab3.position = ccp(alert.contentSize.width - alert.contentSize.width + 60, alert.contentSize.height + 10);
                    leftLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 4;
                    leftLab4 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    leftLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab4];
                }
            }
        }
        else if (i == 1){
            two = random;
            seq2 = two;
            if (seq2 == 1){
                NSString *up = [NSString stringWithFormat:@"↑"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 1;
                    upLab1 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    upLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 1;
                    upLab2 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    upLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 1;
                    upLab3 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    upLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 1;
                    upLab4 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    upLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab4];
                }
            }
            if (seq2 == 2){
                NSString *right = [NSString stringWithFormat:@"→"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 2;
                    rightLab1 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab1.position = ccp(alert.contentSize.width - alert.contentSize.width+ 10, alert.contentSize.height + 10);
                    rightLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 2;
                    rightLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    rightLab2 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 2;
                    rightLab3 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    rightLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 2;
                    rightLab4 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    rightLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab4];
                }
            }
            if (seq2 == 3){
                NSString *down = [NSString stringWithFormat:@"↓"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 3;
                    downLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    downLab1 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 3;
                    downLab2 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab2.position = ccp(alert.contentSize.width - alert.contentSize.width+ 35, alert.contentSize.height + 10);
                    downLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 3;
                    downLab3 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    downLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 3;
                    downLab4 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    downLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab4];
                }
            }
            if (seq2 == 4){
                NSString *left = [NSString stringWithFormat:@"←"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 4;
                    leftLab1 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    leftLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 4;
                    leftLab2 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    leftLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 4;
                    leftLab3 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab3.position = ccp(alert.contentSize.width - alert.contentSize.width + 60, alert.contentSize.height + 10);
                    leftLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 4;
                    leftLab4 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    leftLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab4];
                }
            }
        }
        else if (i==2){
            three = random;
            seq3 = three;
            [GameData sharedGameData].seq3 = seq3;
            if (seq3 == 1){
                NSString *up = [NSString stringWithFormat:@"↑"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 1;
                    upLab1 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    upLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 1;
                    upLab2 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    upLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 1;
                    upLab3 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    upLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 1;
                    upLab4 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    upLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab4];
                }
            }
            if (seq3 == 2){
                NSString *right = [NSString stringWithFormat:@"→"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 2;
                    rightLab1 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab1.position = ccp(alert.contentSize.width - alert.contentSize.width+ 10, alert.contentSize.height + 10);
                    rightLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 2;
                    rightLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    rightLab2 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 2;
                    rightLab3 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    rightLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 2;
                    rightLab4 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    rightLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab4];
                }
            }
            if (seq3 == 3){
                NSString *down = [NSString stringWithFormat:@"↓"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 3;
                    downLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    downLab1 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 3;
                    downLab2 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab2.position = ccp(alert.contentSize.width - alert.contentSize.width+ 35, alert.contentSize.height + 10);
                    downLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 3;
                    downLab3 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    downLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 3;
                    downLab4 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    downLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab4];
                }
            }
            if (seq3 == 4){
                NSString *left = [NSString stringWithFormat:@"←"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 4;
                    leftLab1 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    leftLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 4;
                    leftLab2 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    leftLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 4;
                    leftLab3 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab3.position = ccp(alert.contentSize.width - alert.contentSize.width + 60, alert.contentSize.height + 10);
                    leftLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 4;
                    leftLab4 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    leftLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab4];
                }
            }
        }
        if (i==3){
            four = random;
            seq4 = four;
            [GameData sharedGameData].seq4 = seq4;
            if (seq4 == 1){
                NSString *up = [NSString stringWithFormat:@"↑"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 1;
                    upLab1 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    upLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 1;
                    upLab2 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    upLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 1;
                    upLab3 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    upLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 1;
                    upLab4 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    upLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:upLab4];
                }
            }
            if (seq4 == 2){
                NSString *right = [NSString stringWithFormat:@"→"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 2;
                    rightLab1 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab1.position = ccp(alert.contentSize.width - alert.contentSize.width+ 10, alert.contentSize.height + 10);
                    rightLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 2;
                    rightLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    rightLab2 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 2;
                    rightLab3 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    rightLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 2;
                    rightLab4 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    rightLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:rightLab4];
                }
            }
            if (seq4 == 3){
                NSString *down = [NSString stringWithFormat:@"↓"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 3;
                    downLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    downLab1 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 3;
                    downLab2 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab2.position = ccp(alert.contentSize.width - alert.contentSize.width+ 35, alert.contentSize.height + 10);
                    downLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 3;
                    downLab3 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab3.position = ccp(alert.contentSize.width - alert.contentSize.width +60, alert.contentSize.height + 10);
                    downLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 3;
                    downLab4 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    downLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:downLab4];
                }
            }
            if (seq4 == 4){
                NSString *left = [NSString stringWithFormat:@"←"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 4;
                    leftLab1 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab1.position = ccp(alert.contentSize.width - alert.contentSize.width + 10, alert.contentSize.height + 10);
                    leftLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 4;
                    leftLab2 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab2.position = ccp(alert.contentSize.width - alert.contentSize.width +35, alert.contentSize.height + 10);
                    leftLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 4;
                    leftLab3 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab3.position = ccp(alert.contentSize.width - alert.contentSize.width + 60, alert.contentSize.height + 10);
                    leftLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 4;
                    leftLab4 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab4.position = ccp(alert.contentSize.width - alert.contentSize.width +85, alert.contentSize.height + 10);
                    leftLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    [alert addChild:leftLab4];
                }
            }
        }
    }
    [layer addChild:alert];
    
    swipeLeft= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeLeft];
    // listen for swipes to the right
    swipeRight= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRight];
    // listen for swipes up
    swipeUp= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeUp];
    // listen for swipes down
    swipeDown= [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeDown];
    
    
    alert.opacity = 0;
    CCActionFadeTo *fadeIn = [CCActionFadeTo actionWithDuration:.5f opacity:1.f];
    CCActionFadeTo *fadeOut = [CCActionFadeTo actionWithDuration:.5f opacity:.3f];
    CCActionRemove *remove = [CCActionRemove action];
    CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
        [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeUp];
        [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeRight];
        [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeDown];
        [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeLeft];
        currentSequence = 1;
        [alert setSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/lowGasFail.png"]];
    }];
    CCActionDelay *shortDelay = [CCActionDelay actionWithDuration:.05f];
    [alert runAction:[CCActionSequence actions: fadeIn,fadeOut,fadeIn,fadeOut, fadeIn, fadeOut, block, shortDelay, remove, nil]];
    
}

// -----------------------------------------------------------------

@end

