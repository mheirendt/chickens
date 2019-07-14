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
    /*
     *******TODO
     
    * In app Purchases
     -set up iTunes Connect account and App ID
     -set up variable for flags with if/else statement for when the user buys upgrades
    * Game Center
     - Set up achievements and link game center button to interface
     - Create fake users and beta test
     
     
    * Create setttings page
     
    * Tutorial how to process
     
    * show level up at game over not showing all the time
     
    * integrate audio
     
    * make buttons for choosing user easier to press
     
    * add animation for purchases in store interface
     
    * add wallet, odds, flyer, and egg count to profile summary
     
    * gap and mismatch in parallax scrolling
     
    * modify all images in resources to adhere to apple hui guidelines
     
    * test gameplay through level 20, eggs continuing to launch after round 9
     
     
     **********IDEAS
     * Custom shaders for barn. Shaders range from standard to legendary.
        - shaders will give various talents (higher chance at rewards, better xp accumulation, better health)
        - shaders have a specialty power (hold on the screen for .5 seconds) 3 different powers?
        - Category ideas? Defense, offense, bonus
     */
    CCPhysicsNode *_physicsNode;//Physics node for all objects to be included to be added to
    CCLabelTTF *_scoreText;     //Label to store the text labeled "Score" to be hidden during tutorial
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
    bool perfectRound;          //Flag to store if the player has lost any eggs for the round to the boundaries or the barn
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
    CCNode *tutorialOverlay;
    CCNode *_background;
    CCNode *_background1;
    CCNode *_background2;
    CCNode *_backgroundTop1;
    CCNode *_backgroundTop2;
    CCNode *_backgroundBack1;
    CCNode *_backgroundBack2;
    bool running;
    CCSprite *lowGas;
    CCNode* _ground;            //instance variable pulled in from spritebuilder to stop sprites from falling through and push while running
    CCNode* _roof;              //Phsyics node to capture all eggs that hit the roof and remove them
    CCNode* _left;              //Physics node to capture all eggs that fly beyond the barn and remove them
    CCNode* _right;             //Physics node to capture all egs launched behind the chicken while running
    int currentSequence;        //Current sequence in gas alert. Can be 1 (starting) through 4 (finished)
    int failedOnce;             //Flag used to track if user has failed 0, 1 or 2 gas alerts
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
    
    CCParticleSystem *emitter;
    int rankBefore;
    int rankAfter;
    
    int tutorialCounter;
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
    self.multipleTouchEnabled = YES;
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
    _roof.physicsBody.collisionType = @"Boundary";
    _left.physicsBody.collisionType = @"Boundary";
    _right.physicsBody.collisionType = @"Boundary";
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
    perfectRound = true; //set the flag to true. If an egg leaves the screen or hits the barn, will be set to false
    if([GameData sharedGameData].newPlayerFlag == true){
        if (person.nukes.intValue == 0)
        {
            [person setValue:[NSNumber numberWithInt:1] forKey:@"nukes"];
            if (![person.managedObjectContext save:&error2]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", error2, error2.localizedDescription);
            }
        }
        if (person.blades.intValue == 0)
        {
            [person setValue:[NSNumber numberWithInt:1] forKey:@"blades"];
            if (![person.managedObjectContext save:&error2]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", error2, error2.localizedDescription);
            }
        }
        _scoreText.visible = false;
        _scoreLabel.visible = false;
        base1.visible = false;
        _progressNode.visible = false;
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
    [GameData sharedGameData].bombCount = person.nukes.intValue;
    [_bombCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
    [_nukes setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
    [GameData sharedGameData].bladeCount = person.blades.intValue;
    [bladeCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
    [bladeCostLabel setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
    if(![GameData sharedGameData].newPlayerFlag == true){
        [self newRound:[NSString stringWithFormat:@"%d",roundCount]];
        [self initRound:roundCount];
    }
    else{
        [self scheduleOnce:@selector(launchEgg)delay:4.5f];
    }
    if([GameData sharedGameData].newPlayerFlag == true){
        bladeButton.visible = false;
        bladeCount.visible = false;
        //*Tutorial 1
        CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
            [[CCDirector sharedDirector] pause];
            if (![self getChildByName:@"overlay" recursively:YES]){
                tutorialOverlay = [CCBReader load:@"overlay"];
                tutorialOverlay.anchorPoint = ccp(.5f,.5f);
                tutorialOverlay.positionType = CCPositionTypeNormalized;
                tutorialOverlay.position = ccp(.5f,.5f);
                [self addChild:tutorialOverlay];
                tutorialOverlay.name = @"overlay";
            }
            instructions = [CCLabelTTF labelWithString:@"Tap on an egg to crack it before it hits the barn." fontName:@"Helvetica" fontSize:32 dimensions:CGSizeMake(300, 200)];
            instructions.positionType = CCPositionTypeNormalized;
            instructions.name = @"instructions";
            instructions.position = ccp(.5f,.5f);
            [tutorialOverlay addChild:instructions];
            continueButton = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
            continueButton.positionType = CCPositionTypeNormalized;
            continueButton.position = ccp(.5f, .1f);
            continueButton.name = @"continueButton";
            [continueButton setTarget:self selector:@selector(continuePressed)];
            [tutorialOverlay addChild:continueButton];
        }];
        CCActionDelay *delay1 = [CCActionDelay actionWithDuration:.000001f];
        CCActionDelay *delay = [CCActionDelay actionWithDuration:4.3f];
        
        CCActionCallBlock *block2 = [CCActionCallBlock actionWithBlock:^(void){
            if (![self getChildByName:@"overlay" recursively:YES]){
                [self addChild:tutorialOverlay];
                tutorialOverlay.name = @"overlay";
            }
            if (![tutorialOverlay getChildByName:@"instructions" recursively:YES]){
                [tutorialOverlay addChild:instructions];
                instructions.name = @"instructions";
            }
            if (![tutorialOverlay getChildByName:@"continue" recursively:YES]){
                [tutorialOverlay addChild:continueButton];
                continueButton.name = @"continue";
            }
            [_bomb removeFromParentAndCleanup:NO];
            [_bombCount removeFromParentAndCleanup:NO];
            [tutorialOverlay addChild:_bomb];
            [tutorialOverlay addChild:_bombCount];
            _bomb.visible = true;
            _bombCount.visible = true;
            _bomb.enabled = false;
            [continueButton setTarget:self selector:@selector(changeContinue)];
            [instructions setString:@"Nukes blow up all eggs on the screen."];
            [[CCDirector sharedDirector] pause];
        }];
        CCActionCallBlock *block3 = [CCActionCallBlock actionWithBlock:^(void){
            if (![self getChildByName:@"overlay" recursively:YES]){
                [self addChild:tutorialOverlay];
                tutorialOverlay.name = @"overlay";
            }
            if (![tutorialOverlay getChildByName:@"instructions" recursively:YES]){
                [tutorialOverlay addChild:instructions];
                instructions.name = @"instructions";
            }
            if (![tutorialOverlay getChildByName:@"continue" recursively:YES]){
                [tutorialOverlay addChild:continueButton];
                continueButton.name = @"continue";
            }
            [continueButton setTarget:self selector:@selector(changeContinue)];
            [[CCDirector sharedDirector] pause];
        }];
        CCActionCallBlock *block4 = [CCActionCallBlock actionWithBlock:^(void){
            if (![self getChildByName:@"overlay" recursively:YES]){
                [self addChild:tutorialOverlay];
                tutorialOverlay.name = @"overlay";
            }
            if (![tutorialOverlay getChildByName:@"instructions" recursively:YES]){
                [tutorialOverlay addChild:instructions];
                instructions.name = @"instructions";
            }
            [[CCDirector sharedDirector] pause];
        }];
        [self runAction:[CCActionSequence actions:delay,block, delay, block2,delay1, block3, delay1, block4, nil]];
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
    CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.8f position:ccp(700,107)];
    CCActionDelay *delay = [CCActionDelay actionWithDuration:1.1f];
    CCActionCallBlock *blockRun = [CCActionCallBlock actionWithBlock:^(void){
        [self schedule:@selector(scrollBackground:) interval:0.005f];
        [self schedule:@selector(scrollMid:) interval:.08f];
        [self schedule:@selector(scrollBack:) interval:.15f];
        running = true;
    }];
    CCActionDelay *globalDelay = [CCActionDelay actionWithDuration:2.f];
    CCActionMoveTo *passCanon = [CCActionMoveTo actionWithDuration:1.f position:ccp(700,chicken.position.y)];
    CCActionMoveTo *catchUp = [CCActionMoveTo actionWithDuration: .8f position:ccp(self.contentSize.width - 80,107)];
    [horse runAction:[CCActionSequence actions:globalDelay,blockRun, delay, move, nil]];
    [chicken runAction:[CCActionSequence actions:globalDelay, passCanon, lift, catchUp,nil]];
    [_tractor runAction:[CCActionMoveTo actionWithDuration:2.f position:ccp(-20.f,_tractor.position.y)]];
    CCActionMoveTo *liftBarn = [CCActionMoveTo actionWithDuration:.5f position:ccp(_barn.position.x,_barn.position.y+20)];
    CCActionDelay *barnDelay = [CCActionDelay actionWithDuration:1.f];
    [_barn runAction:[CCActionSequence actions:barnDelay, liftBarn,nil]];
    
    if ([GameData sharedGameData].newPlayerFlag){
        [self scheduleOnce:@selector(nextTutorial) delay:3.f];
    }
    

}
-(void)nextTutorial{
    /*
    if (running){
        [self scheduleOnce:@selector(showGasAlert)delay:3.f];
    }
     */
    CCActionCallBlock *launch = [CCActionCallBlock actionWithBlock:^(void){
        int minTime = .8f * 1000;
        int maxTime = 1.2f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
    }];
    CCActionDelay *delay = [CCActionDelay actionWithDuration:4.3f];
    
    CCActionCallBlock *showTutorial = [CCActionCallBlock actionWithBlock:^(void){
        if (![self getChildByName:@"overlay" recursively:YES]){
            [self addChild:tutorialOverlay];
            tutorialOverlay.name = @"overlay";
        }
        if (![tutorialOverlay getChildByName:@"instructions" recursively:YES]){
            [tutorialOverlay addChild:instructions];
            instructions.name = @"instructions";
        }
        if (![tutorialOverlay getChildByName:@"continue" recursively:YES]){
            [tutorialOverlay addChild:continueButton];
            continueButton.name = @"continue";
        }
        [self showGasAlert];
     }];
    
    /*
     CGPoint seq1Size = CGPointMake(10, alert.contentSize.height + 10);
     CGPoint seq2Size = CGPointMake(35, alert.contentSize.height + 10);
     CGPoint seq3Size = CGPointMake(60, alert.contentSize.height + 10);
     CGPoint seq4Size = CGPointMake(85, alert.contentSize.height + 10);
     
     
     CGPoint seq1Size = CGPointMake(.42f, .7f);
     CGPoint seq2Size = CGPointMake(.47f, .7f);
     CGPoint seq3Size = CGPointMake(.52f, .7f);
     CGPoint seq4Size = CGPointMake(.57f, .7f);
     
     */

    
    [self runAction:[CCActionSequence actions:delay,launch, [CCActionDelay actionWithDuration:1.5f], showTutorial, nil]];
}
-(void)continuePressed{
    if ([tutorialOverlay getChildByName:@"continueButton" recursively:YES]){
        [tutorialOverlay removeChild:continueButton];
    }
    if ([tutorialOverlay getChildByName:@"instructions" recursively:YES]){
        [tutorialOverlay removeChild:instructions];
    }
    if ([self getChildByName:@"overlay" recursively:YES]){
        [self removeChild:tutorialOverlay];
    }
    [[CCDirector sharedDirector] resume];
}
-(void)changeContinue{
    tutorialCounter++;
    if(tutorialCounter == 1){
        [instructions setString:@"You can purchase nukes with gold eggs or get rewarded with one after completing a round"];
    }
    if(tutorialCounter == 2){
        [instructions setString:@"Nuke em to continue."];
        [tutorialOverlay removeChild:continueButton];
        _bomb.enabled = true;
    }
    if(tutorialCounter == 3){
        [bladeButton removeFromParentAndCleanup:NO];
        [bladeCount removeFromParentAndCleanup:NO];
        [tutorialOverlay addChild:bladeButton];
        [tutorialOverlay addChild:bladeCount];
        [instructions setString:@"Pitchforks allow you to slice eggs by sliding across the screen."];
        bladeButton.visible = true;
        bladeCount.visible = true;
        bladeButton.enabled = false;
    }
    if(tutorialCounter == 4){
        [instructions setString:@"Pitchforks last for 15 seconds."];
    }
    if(tutorialCounter == 5){
        bladeButton.enabled = true;
        [tutorialOverlay removeChild:continueButton];
        [instructions setString:@"Use your pitchfork to continue"];
    }
    if(tutorialCounter == 6){
        [instructions setString:@"If you are lucky, a chicken will drop you a golden egg."];
    }
    if(tutorialCounter == 7){
        [instructions setString:@"Golden eggs are your currency."];
    }
    if(tutorialCounter == 8){
        [instructions setString:@"Use them to buy upgrades and weapons between rounds."];
    }
    if(tutorialCounter == 9){
        [instructions setString:@"collect golden eggs by tapping on them."];
        [continueButton setTarget:self selector:@selector(continuePressed)];
    }
    if(tutorialCounter == 10){
        [instructions setString:@"Eventually you will be mobile. Still, protect the barn at all cost."];
    }
    if(tutorialCounter == 11){
        //up
        if ([self getChildByName:@"upLab1" recursively:YES]){
            [upLab1 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"upLab2" recursively:YES]){
            [upLab2 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"upLab3" recursively:YES]){
            [upLab3 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"upLab4" recursively:YES]){
            [upLab4 removeFromParentAndCleanup:NO];
        }
        //right
        if ([self getChildByName:@"rightLab1" recursively:YES]){
            [rightLab1 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"rightLab2" recursively:YES]){
            [rightLab2 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"rightLab3" recursively:YES]){
            [rightLab3 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"rightLab4" recursively:YES]){
            [rightLab4 removeFromParentAndCleanup:NO];
        }
        //down
        if ([self getChildByName:@"downLab1" recursively:YES]){
            [downLab1 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"downLab2" recursively:YES]){
            [downLab2 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"downLab3" recursively:YES]){
            [downLab3 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"downLab4" recursively:YES]){
            [downLab4 removeFromParentAndCleanup:NO];
        }
        //left
        if ([self getChildByName:@"leftLab1" recursively:YES]){
            [leftLab1 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"leftLab2" recursively:YES]){
            [leftLab2 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"leftLab3" recursively:YES]){
            [leftLab3 removeFromParentAndCleanup:NO];
        }
        if ([self getChildByName:@"leftLab4" recursively:YES]){
            [leftLab4 removeFromParentAndCleanup:NO];
        }
        [alert removeFromParentAndCleanup:NO];
        /*
        [tutorialOverlay addChild: rightLab1];
        [tutorialOverlay addChild: rightLab2];
        [tutorialOverlay addChild: downLab3];
        [tutorialOverlay addChild: upLab4];
         */
        [tutorialOverlay addChild: alert];

        [instructions setString:@"To keep the tractor going, you will need to refuel."];
        [continueButton setTarget:self selector:@selector(changeContinue)];
    }
    if(tutorialCounter == 12){
        [instructions setString:@"Swipe in the direction of the arrows on the alert to keep moving."];
        [continueButton setTarget:self selector:@selector(continuePressed)];
    }
    if(tutorialCounter == 13){
        emitter.visible = false;
        [instructions setString:@"If you fail once, your tractor will fall behind. Fail twice and the barn is left behind."];
    }
    if(tutorialCounter == 14){
        [instructions setString:@"At the start of the next round, two additional cannons are added."];
        [continueButton setTarget:self selector:@selector(changeContinue)];
    }
    if(tutorialCounter == 15){
        [instructions setString:@"At this point, you'd better hope you're all stocked up on nukes and pitchforks!"];
        [continueButton setTarget:self selector:@selector(changeContinue)];
    }
    if(tutorialCounter == 16){
        [instructions setString:@"You're all set to go, get to crackin'!"];
        [continueButton setTarget:self selector:@selector(quitTutorial)];
    }
}
- (void)swipeLeft {
    if (currentSequence == 1){
        if ([GameData sharedGameData].seq1 == 4){
            currentSequence++;
            [leftLab1 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [leftLab1 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 2){
        if([GameData sharedGameData].seq2 == 4){
            currentSequence++;
            [leftLab2 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [leftLab2 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 3){
        if([GameData sharedGameData].seq3 == 4){
            currentSequence++;
            [leftLab3 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [leftLab3 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 4){
        if([GameData sharedGameData].seq4 == 4){
            currentSequence = 1;
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeUp];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeRight];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeDown];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeLeft];
            [self removeChild: leftLab4];
            [self removeChild:alert];
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
            [self rewardMedal:spree andLabel:@"Refueled" andExp:5];
        }
    }
}
- (void)swipeRight {
    if (currentSequence == 1){
        if ([GameData sharedGameData].seq1 == 2){
            currentSequence++;
            [rightLab1 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [rightLab1 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 2){
        if([GameData sharedGameData].seq2 == 2){
            currentSequence++;
            [rightLab2 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [rightLab2 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 3){
        if([GameData sharedGameData].seq3 == 2){
            currentSequence++;
            [rightLab3 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [rightLab3 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 4){
        if([GameData sharedGameData].seq4 == 2){
            currentSequence = 1;
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeUp];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeRight];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeDown];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeLeft];
            [self removeChild:rightLab4];
            [self removeChild:alert];
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
            [self rewardMedal:spree andLabel:@"Refueled" andExp:5];
        }
    }
}
- (void)swipeDown {
    if (currentSequence == 1){
        if ([GameData sharedGameData].seq1 == 3){
            currentSequence++;
            [downLab1 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [downLab1 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 2){
        if([GameData sharedGameData].seq2 == 3){
            currentSequence++;
            [downLab2 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [downLab2 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 3){
        if([GameData sharedGameData].seq3 == 3){
            currentSequence++;
            [downLab3 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [downLab3 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 4){
        if([GameData sharedGameData].seq4 == 3){
            currentSequence = 1;
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeUp];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeRight];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeDown];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeLeft];
            [self removeChild:downLab4];
            [self removeChild:alert];
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
            [self rewardMedal:spree andLabel:@"Refueled" andExp:5];
        }
    }
}
- (void)swipeUp {
    if (currentSequence == 1){
        if ([GameData sharedGameData].seq1 == 1){
            currentSequence++;
            [upLab1 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [upLab1 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 2){
        if([GameData sharedGameData].seq2 == 1){
            currentSequence++;
            [upLab2 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [upLab2 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 3){
        if([GameData sharedGameData].seq3 == 1){
            currentSequence++;
            [upLab3 setColor:[CCColor greenColor]];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:.1f];
            [upLab3 runAction:[CCActionSequence actions:delay,[CCActionRemove action], nil]];
        }
    }
    else if (currentSequence == 4){
        if([GameData sharedGameData].seq4 == 1){
            currentSequence = 1;
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeUp];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeRight];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeDown];
            [[[CCDirector sharedDirector] view] removeGestureRecognizer:swipeLeft];
            [self removeChild:upLab4];
            [self removeChild:alert];
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
            [self rewardMedal:spree andLabel:@"Refueled" andExp:5];
        }
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
    else if (roundCount == 3){
        CCNode *chicken2 = [CCBReader load:@"Canon"];
        CGPoint point =  CGPointMake(x,y);
        chicken2.position = point;
        chicken2.rotation = rotation;
        id moveCk=[CCActionMoveTo actionWithDuration:2.0f position:ccp(movex,movey)];
        id delay = [CCActionDelay actionWithDuration: .5f];
        [self addChild:chicken2];
        [chicken2 runAction:[CCActionSequence actions: delay, moveCk, nil]];
    }
    else{
        CCNode *chicken3 = [CCBReader load:@"Canon"];
        CGPoint point =  CGPointMake(x,y);
        chicken3.position = point;
        chicken3.rotation = rotation;
        chicken3.scaleX *= -1;
        id moveCk=[CCActionMoveTo actionWithDuration:2.0f position:ccp(movex,movey)];
        id delay = [CCActionDelay actionWithDuration: .5f];
        [self addChild:chicken3];
        [chicken3 runAction:[CCActionSequence actions: delay, moveCk, nil]];
        
        CCNode *chicken4 = [CCBReader load:@"Canon"];
        CGPoint point4 =  CGPointMake(x,y+190);
        chicken4.position = point4;
        chicken4.rotation = 50.f;
        chicken4.scaleX *=-1;
        id moveCk4=[CCActionMoveTo actionWithDuration:2.0f position:ccp(movex,movey+190)];
        id delay4 = [CCActionDelay actionWithDuration: .5f];
        [self addChild:chicken4];
        [chicken4 runAction:[CCActionSequence actions: delay4, moveCk4, nil]];
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
    if([GameData sharedGameData].newPlayerFlag == true){
        CCActionCallBlock *block2 = [CCActionCallBlock actionWithBlock:^(void){
            [[CCDirector sharedDirector] pause];
            if (![self getChildByName:@"overlay" recursively:YES]){
                [self addChild:tutorialOverlay];
                tutorialOverlay.name = @"overlay";
            }
            if (![tutorialOverlay getChildByName:@"instructions" recursively:YES]){
                instructions.name = @"instructions";
                [tutorialOverlay addChild:instructions];
            };
            if (![tutorialOverlay getChildByName:@"continueButton" recursively:YES]){
                continueButton.name = @"continueButton";
                [tutorialOverlay addChild:continueButton];
            };
        }];
        [self runAction:block2];
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
            if([GameData sharedGameData].newPlayerFlag == true){
                [[CCDirector sharedDirector] resume];
                [self changeContinue];
                CCActionDelay *delay = [CCActionDelay actionWithDuration:5.f];
                CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                    [self startRunning];
                    [self unschedule:@selector(launchEgg)];
                }];
                CCActionCallBlock *block2 = [CCActionCallBlock actionWithBlock:^(void){
                    [[CCDirector sharedDirector] pause];
                    if (![self getChildByName:@"overlay" recursively:YES]){
                        [self addChild:tutorialOverlay];
                        tutorialOverlay.name = @"overlay";
                    }
                    if (![tutorialOverlay getChildByName:@"instructions" recursively:YES]){
                        instructions.name = @"instructions";
                        [tutorialOverlay addChild:instructions];
                    };
                    if (![tutorialOverlay getChildByName:@"continueButton" recursively:YES]){
                        continueButton.name = @"continueButton";
                        [tutorialOverlay addChild:continueButton];
                    };
                    //tutorialCounter++;
                }];
                [self runAction:[CCActionSequence actions:delay,block, [CCActionDelay actionWithDuration:.5f], block2, nil]];
            }

            nodeB.positionType = CCPositionTypeNormalized;
            nodeB.physicsBody.sensor = true;
            CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.5f position:ccp(nodeB.position.x, 1.1f)];
            CCActionRemove *actionRemove = [CCActionRemove action];
            [nodeB runAction:[CCActionSequence actionWithArray:@[lift, actionRemove]]];
    } key:nodeB];
}
-(void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Egg:(CCNode *)nodeA Boundary:(CCNode *)nodeB{
    [nodeA removeFromParentAndCleanup:YES];
    killCount = 0;
    perfectRound = false;
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
        //[_physicsNode addChild:blade];
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
        [_physicsNode removeChild:blade];
        [self removeChild:timer];
        [self unschedule:@selector(timerUpdate:)];
        [bladeButton setEnabled:true];
        if ([GameData sharedGameData].newPlayerFlag){
            bladeButton.visible = false;
            bladeCount.visible = false;
        }
    }
}
-(void)bladePressed{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    if(person.blades.intValue >=1){
        bladeActive = 1;
        [_physicsNode addChild:blade];
        [bladeButton setEnabled:false];
        timeRemain = 15;
        timer = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d",timeRemain] fontName:@"Helvetica" fontSize:14];
        timer.positionType = CCPositionTypeUIPoints;
        timer.position = ccp(289.f,46.f);
        [self addChild:timer];
        [GameData sharedGameData].bladeCount--;
        int blades = person.blades.intValue;
        blades--;
        [person setValue:[NSNumber numberWithInt:blades] forKey:@"blades"];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
        [self schedule:@selector(timerUpdate:) interval:1];
        [GameData sharedGameData].bladeCount = person.blades.intValue;
        [bladeCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
        [bladeCostLabel setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
        if ([GameData sharedGameData].newPlayerFlag){
            [bladeButton removeFromParentAndCleanup:NO];
            [bladeCount removeFromParentAndCleanup:NO];
            [self addChild:bladeButton];
            [self addChild:bladeCount];
            [self changeContinue];
            tutorialCounter++;
            bladeButton.enabled = false;
            [self continuePressed];
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [self flyingChicken];
            }];
            [self runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:3.f], block, nil]];
        }
    }
}
-(void)touchMoved:(CCTouch *)touch withEvent:(CCTouchEvent *)event{
    if(bladeActive == 1){
        CGPoint location = [touch locationInNode:self];
        _endPoint = location;
        [self doStep:.001f];
    }
}
- (void)doStep:(CCTime)delta
{
    //update the blades position
    blade.position = _endPoint;
    [streak setPosition:_endPoint];
}
-(void)bombPurchased
{
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
        int wallet;
        if (person.nukewallet){
            wallet = 20;
        }else{
            wallet = 10;
        }
        if (person.nukes.intValue < wallet){
            int newBombCount = person.nukes.intValue;
            newBombCount++;
            [person setValue:[NSNumber numberWithInt:newBombCount] forKey:@"nukes"];
            if (![person.managedObjectContext save:&error2]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", error2, error2.localizedDescription);
            }
            int newAmount = person.gold.intValue - 1;
            [GameData sharedGameData].bombCount = person.nukes.intValue;
            [_bombCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
            [_nukes setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
            [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
            [_goldCount setString:[NSString stringWithFormat:@"X %d", person.gold.intValue]];
            if (![person.managedObjectContext save:&error2]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", error2, error2.localizedDescription);
            }
        }
        //If they are at their maximium, warn them and direct them to in app purchases
        else{
            buyBlades.enabled = false;
            _buyBombsButton.enabled = false;
            _repairButton.enabled = false;
            _shopping.enabled = false;
            _nextRoundButton.enabled = false;
            id block = ^(void){
                buyBlades.enabled = true;
                _buyBombsButton.enabled = true;
                _repairButton.enabled = true;
                _shopping.enabled = true;
                _nextRoundButton.enabled = true;
            };
            id storeBlock = ^(void){
                buyBlades.enabled = true;
                _buyBombsButton.enabled = true;
                _repairButton.enabled = true;
                _shopping.enabled = true;
                _nextRoundButton.enabled = true;
                [[CCDirector sharedDirector] pushScene:[CCBReader loadAsScene:@"Store"]];
            };
            if (!person.nukewallet){
                [AlertView ShowAlert:@"You are maxed out! You may purchase a larger wallet to hold two times the amount." onLayer:self withOpt1:@"Store" withOpt1Block:storeBlock andOpt2:@"Cancel" withOpt2Block:block];
            } else {
                [AlertView ShowAlert:@"You have the maximum amount of nukes allowed!" onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
            }
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
        id store = ^(void){
            buyBlades.enabled = true;
            _buyBombsButton.enabled = true;
            _repairButton.enabled = true;
            _shopping.enabled = true;
            _nextRoundButton.enabled = true;
            [[CCDirector sharedDirector] pushScene:[CCBReader loadAsScene:@"Store"]];
        };
        buyBlades.enabled = false;
        _buyBombsButton.enabled = false;
        _repairButton.enabled = false;
        _shopping.enabled = false;
        _nextRoundButton.enabled = false;
        [AlertView ShowAlert:@"You do not have enough gold!" onLayer:self withOpt1:@"Take me to the Store" withOpt1Block:store andOpt2:@"Okay" withOpt2Block:block];
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
        if (_health < 100.f){
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
            [AlertView ShowAlert:@"Your barn is already in perfect condition." onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
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
        id store = ^(void){
            buyBlades.enabled = true;
            _buyBombsButton.enabled = true;
            _repairButton.enabled = true;
            _shopping.enabled = true;
            _nextRoundButton.enabled = true;
            [[CCDirector sharedDirector] pushScene:[CCBReader loadAsScene:@"Store"]];
        };
        buyBlades.enabled = false;
        _buyBombsButton.enabled = false;
        _repairButton.enabled = false;
        _shopping.enabled = false;
        _nextRoundButton.enabled = false;
        
        [AlertView ShowAlert:@"You do not have enough gold!" onLayer:self withOpt1:@"Take me to the Store" withOpt1Block:store andOpt2:@"Okay" withOpt2Block:block];
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
        int wallet;
        if (person.bladewallet){
            wallet = 20;
        }
        else{
            wallet = 10;
        }
        if (person.blades.intValue < wallet){
            int newAmount = person.gold.intValue - 2;
            [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
            int blades = person.blades.intValue;
            blades++;
            [person setValue:[NSNumber numberWithInt:blades] forKey:@"blades"];
            [GameData sharedGameData].bladeCount = person.blades.intValue;
            [bladeCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
            [bladeCostLabel setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
            [_goldCount setString:[NSString stringWithFormat:@"X %d", person.gold.intValue]];
            if (![person.managedObjectContext save:&error2]) {
                NSLog(@"Unable to save managed object context.");
                NSLog(@"%@, %@", error2, error2.localizedDescription);
            }
        }
        //If they are at their maximium, warn them and direct them to in app purchases
        else{
            buyBlades.enabled = false;
            _buyBombsButton.enabled = false;
            _repairButton.enabled = false;
            _shopping.enabled = false;
            _nextRoundButton.enabled = false;
            id block = ^(void){
                buyBlades.enabled = true;
                _buyBombsButton.enabled = true;
                _repairButton.enabled = true;
                _shopping.enabled = true;
                _nextRoundButton.enabled = true;
            };
            id storeBlock = ^(void){
                buyBlades.enabled = true;
                _buyBombsButton.enabled = true;
                _repairButton.enabled = true;
                _shopping.enabled = true;
                _nextRoundButton.enabled = true;
                [[CCDirector sharedDirector] pushScene:[CCBReader loadAsScene:@"Store"]];
            };
            if (!person.bladewallet){
                [AlertView ShowAlert:@"You are maxed out! You may purchase a larger wallet to hold two times the amount." onLayer:self withOpt1:@"Store" withOpt1Block:storeBlock andOpt2:@"Cancel" withOpt2Block:block];
            } else {
                [AlertView ShowAlert:@"You have the maximum amount of pitchforks allowed!" onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
            }
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
        id store = ^(void){
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
        [AlertView ShowAlert:@"You do not have enough gold!" onLayer:self withOpt1:@"Take me to the Store" withOpt1Block:store andOpt2:@"Okay" withOpt2Block:block];
    }
}
- (void)launchEggTopRight {
    totalTargetsLaunched++;
    CCNode* egg = [CCBReader load:@"Egg"];
    egg.positionType = CCPositionTypePoints;
    egg.position = ccp(555.f,300.f);
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
- (void)launchEggBottomLeft {
    totalTargetsLaunched++;
    CCNode* egg = [CCBReader load:@"Egg"];
    egg.positionType = CCPositionTypePoints;
    egg.position = ccp(25.f,120.f);
    [_physicsNode addChild:egg];
    egg.scale = 0.6f;
    egg.rotation = 45.0f;
    int miny = 7;
    int maxy = 15;
    int rangey = maxy - miny;
    int randomy = (arc4random() % rangey) + miny;
    CGPoint launchDirection = ccp(10,randomy);
    int minforce = 2000;
    int maxforce = 5000;
    int rangeforce = maxforce - minforce;
    int randomforce = (arc4random() % rangeforce) + minforce;
    CGPoint force = ccpMult(launchDirection, randomforce);
    [egg.physicsBody applyForce:force];
}
- (void)launchEggTopLeft {
    totalTargetsLaunched++;
    CCNode* egg = [CCBReader load:@"Egg"];
    egg.positionType = CCPositionTypePoints;
    egg.position = ccp(25.f,270.f);
    [_physicsNode addChild:egg];
    egg.scale = 0.6f;
    egg.rotation = 45.0f;
    CGPoint launchDirection = ccp(10,-1);
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    rankBefore = person.rank.intValue;
    perfectRound = true; //reset perfect round flag to true. Will be reset to false if egg hits the barn or leaves the screen.
    CCLOG (@"RoundCount: %d running: %s", number, running ? "true" : "false");
    if([GameData sharedGameData].newPlayerFlag == false){
        int miny;
        int maxy;
        if (person.frequentflyer.intValue == 1){
            miny = 1;
            maxy = 2;
        }else{
            miny = 1;
            maxy = 3;
        }
        int rangey = maxy - miny;
        int randomy = (arc4random() % rangey) + miny;
        if (randomy == 1){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [self flyingChicken];
            }];
            CCActionDelay *delay = [CCActionDelay actionWithDuration:5.f];
            
            [self runAction:[CCActionSequence actions:delay,block, nil]];
        }
    }
    if (number > 1 && failedOnce < 2){
        running = true;
    }
    if (number >=3){
        if (failedOnce == 0){
            [horse setPaused:false];
            [_tractor setPaused:false];
            [self schedule:@selector(scrollBackground:) interval:0.005f];
            [self schedule:@selector(scrollMid:) interval:.08f];
            [self schedule:@selector(scrollBack:) interval:.15f];
        } else if(failedOnce == 1){
            [horse setPaused:false];
            [_tractor setPaused:false];
            [self schedule:@selector(scrollBackground:) interval:0.005f];
            [self schedule:@selector(scrollMid:) interval:.08f];
            [self schedule:@selector(scrollBack:) interval:.15f];
            emitter = [CCParticleSystem particleWithFile:@"exhaust.plist"];
            [self addChild:emitter];
            emitter.position = ccp(_barn.position.x-80,_barn.position.y);
            emitter.zOrder = 2;
            running = true;
        } else if (failedOnce == 2){
            //Barn is crashed and we need to schedule two chickens
                failedOnce++;
                [self addChicken:-50 y:80 androtation:0.f andMoveToX:-22 andMoveToY:80];
        }
    }
        switch (number){
            case 1:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
            }
                break;
            case 2:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self startRunning];
                [self scheduleOnce:@selector(showGasAlert)delay:(10.f)];
                break;
            }
            case 3:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self addChicken:self.contentSize.width+80 y:self.contentSize.height-100 androtation:-45 andMoveToX:self.contentSize.width + 15 andMoveToY:self.contentSize.height-100];
                int miny = 4;
                int maxy = 6;
                int rangey = maxy - miny;
                int randomy = (arc4random() % rangey) + miny;
                [self scheduleOnce:@selector(launchEggTopRight) delay:randomy];
                if (running){
                    [self scheduleOnce:@selector(showGasAlert)delay:(randomy)];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 4:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if (running){
                    [self scheduleOnce:@selector(showGasAlert)delay:(10.f)];
                    [self scheduleOnce:@selector(showGasAlert)delay:(40.f)];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 5:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if (running){
                    [self scheduleOnce:@selector(showGasAlert)delay:(10.f)];
                    [self scheduleOnce:@selector(showGasAlert)delay:(30.f)];
                    [self scheduleOnce:@selector(showGasAlert)delay:(60.f)];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 6:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if (running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 7:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 8:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:6 delay:15.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 9:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 10:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 11:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 12:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 13:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 14:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 15:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 16:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 17:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 18:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 19:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
            case 20:{
                [self scheduleOnce:@selector(launchEgg) delay:5.f];
                [self scheduleOnce:@selector(launchEggTopRight) delay:7.f];
                if(running){
                    [self schedule:@selector(showGasAlert) interval:10.f repeat:4 delay:5.f];
                }
                if (failedOnce == 3){
                    int miny = 4;
                    int maxy = 6;
                    int rangey = maxy - miny;
                    int randomy = (arc4random() % rangey) + miny;
                    [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomy];
                    [self scheduleOnce:@selector(launchEggTopLeft) delay:randomy];
                }
                break;
            }
    }
}
- (void)ccPhysicsCollisionPostSolve:(CCPhysicsCollisionPair *)pair Egg:(CCNode *)nodeA Bullet:(CCNode *)nodeB {
    _timeSinceLastCollision = 0.0;
    medalId++;
    targetsDestroyed++;
    if (![GameData sharedGameData].newPlayerFlag == true){
        [GameData sharedGameData].score++;
        [GameData sharedGameData].roundScore++;
    }
        [[_physicsNode space] addPostStepBlock:^{
            [self eggRemoved:nodeA];
        } key:nodeA];
    CGFloat xDist = (nodeA.position.x - _barn.position.x);
    CGFloat yDist = (nodeA.position.y - _barn.position.y);
    CGFloat distance = hypotf(xDist, yDist);
    CCLOG(@"Distance: %f",distance);
    if(distance <105){
        CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/CloseCall.png"];
        [self rewardMedal:spree andLabel:@"Close" andExp:5];
    }
    if (bladeActive == 0){
        if (killCount == 19){
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/100.png"];
            [self rewardMedal:spree andLabel:@"Icosi" andExp:5];
        }
        else if (killCount == 29){
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/40.png"];
            [self rewardMedal:spree andLabel:@"Triaconta" andExp:10];
        }
        else if (killCount ==39){
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/60.png"];
            [self rewardMedal:spree andLabel:@"Tetraconta" andExp:25];
        }
        else if (killCount == 49){
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/80.png"];
            [self rewardMedal:spree andLabel:@"Pentaconta" andExp:50];
        }
        else if (killCount == 99 || ((killCount%99) == 0 && killCount!= 0)){
            CCSprite *spree = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
            [self rewardMedal:spree andLabel:@"Hecto" andExp:100];
            CCNode *gold = [CCBReader load:@"Gold"];
            gold.scale = .7f;
            gold.positionType = CCPositionTypeNormalized;
            gold.position = ccp(.5f,.7f);
            [self addChild:gold];
            CCLabelTTF *expLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+ 1"] fontName:@"Helvetica" fontSize:24];
            expLabel.position = ccp(gold.position.x + 10,gold.position.y);
            [self addChild:expLabel];
            CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.4f];
            CCActionDelay *setDelay = [CCActionDelay actionWithDuration:1.2f];
            CCActionDelay *delay2 = [CCActionDelay actionWithDuration:.3f];
            CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.5f position:ccp(expLabel.position.x,450)];
            CCActionMoveTo *liftGold = [CCActionMoveTo actionWithDuration:.5f position:ccp(gold.position.x,1.5f)];
            CCActionRemove *remove = [CCActionRemove action];
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
                NSFetchRequest *request = [[NSFetchRequest alloc] init];
                [request setEntity:entity];
                NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                                         stringForKey:@"defaultUser"];
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
                [request setPredicate:predicate];
                NSError *error2 = nil;
                Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
                int goldCount =  person.gold.intValue;
                goldCount++;
                [person setValue:[NSNumber numberWithInt:goldCount] forKey:@"gold"];
                if (![person.managedObjectContext save:&error2]) {
                    NSLog(@"Unable to save managed object context.");
                    NSLog(@"%@, %@", error2, error2.localizedDescription);
                }
            }];
            [expLabel runAction:[CCActionSequence actions:fade,delay2,lift,remove, nil]];
            [gold runAction:[CCActionSequence actions:fade,delay2,liftGold,remove,nil]];
            [self runAction:[CCActionSequence actions:setDelay, block, nil]];
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
    int minforce = 300;
    int maxforce = 700;
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
        [GameData sharedGameData].bombCount = person.nukes.intValue;
        [_bombCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
        [_nukes setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
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
            if (![GameData sharedGameData].newPlayerFlag){
                if(exp > 0){
                    CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                        [GameData sharedGameData].score+=exp;
                        [GameData sharedGameData].roundScore+=exp;
                        [_scoreLabel setString:[NSString stringWithFormat:@"%ld",[GameData sharedGameData].score]];
                        exp = 0;
                    }];
                    CCLabelTTF *expLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+ %d", exp] fontName:@"Didot" fontSize:22];
                    expLabel.position = ccp(67,225);
                    CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.4f];
                    CCActionDelay *delay2 = [CCActionDelay actionWithDuration:.3f];
                    CCActionDelay *delay = [CCActionDelay actionWithDuration:1.2f];
                    CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.5f position:ccp(67,285)];
                    CCActionRemove *remove = [CCActionRemove action];
                    [self addChild:expLabel];
                    [expLabel runAction:[CCActionSequence actions:fade, delay2, lift,remove,nil]];
                    [self runAction:[CCActionSequence actions:delay, block, nil]];
                }
            }
        }];
        [show runAction:[CCActionSequence actions:fade,delay2,fadeOut, remove, nil]];
        [bomb runAction:[CCActionSequence actions:disable, delay2, remove, enable, nil]];
        if([GameData sharedGameData].newPlayerFlag){
            //tutorialCounter++;
            _bomb.visible = false;
            _bomb.enabled = false;
            _bombCount.visible = false;
            [self changeContinue];
            [self continuePressed];
            
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                    [[CCDirector sharedDirector] resume];
                    CCActionDelay *delay = [CCActionDelay actionWithDuration:5.f];
                    CCActionCallBlock *block2 = [CCActionCallBlock actionWithBlock:^(void){
                        [[CCDirector sharedDirector] pause];
                        if (![self getChildByName:@"overlay" recursively:YES]){
                            [self addChild:tutorialOverlay];
                            tutorialOverlay.name = @"overlay";
                        }
                        if (![tutorialOverlay getChildByName:@"instructions" recursively:YES]){
                            instructions.name = @"instructions";
                            [tutorialOverlay addChild:instructions];
                        };
                        if (![tutorialOverlay getChildByName:@"continueButton" recursively:YES]){
                            continueButton.name = @"continueButton";
                            [tutorialOverlay addChild:continueButton];
                        };
                        [continueButton setTarget:self selector:@selector(changeContinue)];
                    }];
                    [self runAction:[CCActionSequence actions:delay,block2, nil]];
            }];
            [self runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:3.f], block, nil]];
        }
    }
}
-(void)armoryPressed{
    [[CCDirector sharedDirector] pushScene:[CCBReader loadAsScene:@"Store"]];
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
        killCount = 0;
        perfectRound = false;
        [self eggHit:nodeA];
        if (![GameData sharedGameData].newPlayerFlag){
            if(_progressNode.percentage==0){
                [self barnExp:nodeB];
            }
        }
    } key:nodeA];
}
- (void)eggHit:(CCNode *)egg {
    if (![GameData sharedGameData].newPlayerFlag){
        _health-=10;
        if(_health==0){
            self.userInteractionEnabled = false;
            CCActionDelay *delay =  [CCActionDelay actionWithDuration:3.5f];
            CCActionCallBlock *gameOver = [CCActionCallBlock actionWithBlock:^(void){
                CCScene *gameOver = [CCBReader loadAsScene:@"GameOver"];
                [[CCDirector sharedDirector] replaceScene:gameOver];
            }];
            [self runAction:[CCActionSequence actions: delay, gameOver, nil]];
        }
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    if (person.experience<[GameData sharedGameData].rank1){
        [person setValue:[NSNumber numberWithInt:0] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank1 && person.experience<[GameData sharedGameData].rank2){
        [person setValue:[NSNumber numberWithInt:1] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank2 && person.experience<[GameData sharedGameData].rank3){
        [person setValue:[NSNumber numberWithInt:2] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank3 && person.experience<[GameData sharedGameData].rank4){
        [person setValue:[NSNumber numberWithInt:3] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank4 && person.experience<[GameData sharedGameData].rank5){
        [person setValue:[NSNumber numberWithInt:4] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank5 && person.experience<[GameData sharedGameData].rank6){
        [person setValue:[NSNumber numberWithInt:5] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank6 && person.experience<[GameData sharedGameData].rank7){
        [person setValue:[NSNumber numberWithInt:6] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank7 && person.experience<[GameData sharedGameData].rank8){
        [person setValue:[NSNumber numberWithInt:7] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank8 && person.experience<[GameData sharedGameData].rank9){
        [person setValue:[NSNumber numberWithInt:8] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank9 && person.experience<[GameData sharedGameData].rank10){
        [person setValue:[NSNumber numberWithInt:9] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank10 && person.experience<[GameData sharedGameData].rank11){
        [person setValue:[NSNumber numberWithInt:10] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank11 && person.experience<[GameData sharedGameData].rank12){
        [person setValue:[NSNumber numberWithInt:11] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank12 && person.experience<[GameData sharedGameData].rank13){
        [person setValue:[NSNumber numberWithInt:12] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank13 && person.experience<[GameData sharedGameData].rank14){
        [person setValue:[NSNumber numberWithInt:13] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank14 && person.experience<[GameData sharedGameData].rank15){
        [person setValue:[NSNumber numberWithInt:14] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank15 && person.experience<[GameData sharedGameData].rank16){
        [person setValue:[NSNumber numberWithInt:15] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank16 && person.experience<[GameData sharedGameData].rank17){
        [person setValue:[NSNumber numberWithInt:16] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank17 && person.experience<[GameData sharedGameData].rank18){
        [person setValue:[NSNumber numberWithInt:17] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank18 && person.experience<[GameData sharedGameData].rank19){
        [person setValue:[NSNumber numberWithInt:18] forKey:@"rank"];
        
        
    }
    else if(person.experience>=[GameData sharedGameData].rank19 && person.experience<[GameData sharedGameData].rank20){
        [person setValue:[NSNumber numberWithInt:19] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank20 && person.experience<[GameData sharedGameData].rank21){
        [person setValue:[NSNumber numberWithInt:20] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank21 && person.experience<[GameData sharedGameData].rank22){
        [person setValue:[NSNumber numberWithInt:21] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank22 && person.experience<[GameData sharedGameData].rank23){
        [person setValue:[NSNumber numberWithInt:22] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank23 && person.experience<[GameData sharedGameData].rank24){
        [person setValue:[NSNumber numberWithInt:23] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank24){
        [person setValue:[NSNumber numberWithInt:24] forKey:@"rank"];
    }
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
    rankAfter = person.rank.intValue;
    CCLOG(@"rank before: %d, rank after: %d", rankBefore, rankAfter);
    if (rankBefore < rankAfter){
        CCLOG(@"LEVEL UP");
        [self showLevelUp:person.rank.intValue gameOver:true];
    }
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
    //CCLOG(@"%d",tutorialCounter);
    CCLOG(@"Killcount:%d", killCount);
    _timeSinceLastCollision += delta;
    /*
    if (killCount < shotCount){
        killCount = 0;
        shotCount = 0;
    }
     */
    if ( _timeSinceLastCollision > .21f ) {
            if(medalId==3){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/3.png"];
                [self rewardMedal:triple andLabel:@"Tri" andExp:5];
            }
            else if(medalId==4){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/4.png"];
                [self rewardMedal:triple andLabel:@"Tetra" andExp:10];
            }
            else if(medalId==5){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/5.png"];
                [self rewardMedal:triple andLabel:@"Penta" andExp:15];
            }
            else if(medalId==6){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/6.png"];
                [self rewardMedal:triple andLabel:@"Hexa" andExp:25];
            }
            else if(medalId==7){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/7.png"];
                [self rewardMedal:triple andLabel:@"Hepta" andExp:50];
            }
            else if(medalId==8){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/8.png"];
                [self rewardMedal:triple andLabel:@"Octa" andExp:60];
            }
            else if(medalId==9){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/9.png"];
                [self rewardMedal:triple andLabel:@"Ennea" andExp:80];
            }
            else if(medalId>=10){
                CCSprite *triple = [CCSprite spriteWithImageNamed:@"Assets/10.png"];
                [self rewardMedal:triple andLabel:@"Deca" andExp:100];
                CCNode *gold = [CCBReader load:@"Gold"];
                gold.scale = .7f;
                gold.positionType = CCPositionTypeNormalized;
                gold.position = ccp(.5f,.5f);
                [self addChild:gold];
                CCLabelTTF *expLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+ 1"] fontName:@"Helvetica" fontSize:24];
                expLabel.position = ccp(gold.position.x + 10,gold.position.y);
                CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.4f];
                CCActionDelay *setDelay = [CCActionDelay actionWithDuration:1.2f];
                CCActionDelay *delay2 = [CCActionDelay actionWithDuration:.3f];
                CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.5f position:ccp(expLabel.position.x,1.5f)];
                CCActionMoveTo *liftGold = [CCActionMoveTo actionWithDuration:.5f position:ccp(gold.position.x,1.5f)];
                CCActionRemove *remove = [CCActionRemove action];
                CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
                    NSFetchRequest *request = [[NSFetchRequest alloc] init];
                    [request setEntity:entity];
                    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                                             stringForKey:@"defaultUser"];
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
                    [request setPredicate:predicate];
                    NSError *error2 = nil;
                    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
                    int goldCount =  person.gold.intValue;
                    goldCount++;
                    [person setValue:[NSNumber numberWithInt:goldCount] forKey:@"gold"];
                    if (![person.managedObjectContext save:&error2]) {
                        NSLog(@"Unable to save managed object context.");
                        NSLog(@"%@, %@", error2, error2.localizedDescription);
                    }
                }];
                [self addChild:expLabel];
                [expLabel runAction:[CCActionSequence actions:fade,delay2,lift,remove, nil]];
                [gold runAction:[CCActionSequence actions:fade,delay2,liftGold,remove, nil]];
                [self runAction:[CCActionSequence actions:setDelay, block, nil]];
            }
            medalId = 0;
    }
}
-(void)showLevelUp:(int)from gameOver:(bool)game{
    if(from-2 < rankBefore){
    CCNode *bg = [CCBReader load:@"overlay"];
    bg.anchorPoint = ccp(.5f,.5f);
    bg.positionType = CCPositionTypeNormalized;
    bg.position = ccp(.5f,.5f);
    [self addChild:bg];
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Level Up!" fontName:@"Comic Sans" fontSize:44];
    title.position = ccp(self.contentSize.width/2, self.contentSize.height - title.contentSize.height - 50);
    title.zOrder = 999999;
    [bg addChild:title];
    
    CCSprite *oldSprite;
    CCLabelTTF *oldLabel;
    CCSprite *newSprite;
    CCLabelTTF *newLabel;
    
    if (from == 1){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
            oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Recruit" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Private" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 2){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
            oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Private" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Private First Class" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
        
    }
    else if (from == 3){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Private First Class" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Private Second Class" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
        
    }
    else if (from == 4){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Private Second Class" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Lance Corporal" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
        
    }
    else if (from == 5){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Lance Corporal" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Corporal" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
        
    }
    else if (from == 6){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Corporal" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Sergeant" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
        
    }
    
    else if (from == 7){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Sergeant" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Staff Sergeant" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
        
    }
    else if (from == 8){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Staff Sergeant" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Gunnery Sergeant" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
        
    }
    
    else if (from == 9){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Gunnery Sergeant" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Master Sergeant" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
        
    }
    else if (from == 10){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Master Sergeant" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"First Sergeant" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
        
    }
    else if (from == 11){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"First Sergeant" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Leutenant" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 12){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Leutenant" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/l_First Leutenant.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"First Leutenant" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 13){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/l_First Leutenant.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"First Leutenant" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Second Leutenant" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 14){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"First Leutenant" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Captain" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 15){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Captain" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Staff Captain" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 16){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Staff Captain" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Leutenant Colonel" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 17){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Leutenant Colonel" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Colonel" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 18){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Colonel" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Brigadier" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 19){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Brigadier" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Brigadier General" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 20){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Brigadier General" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"General" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 21){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"General" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Two Star General" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 22){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Two StarGeneral" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Three Star General" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 23){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Three StarGeneral" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Four Star General" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    else if (from == 24){
        oldSprite = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
        oldSprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [bg addChild:oldSprite];
        
        oldLabel = [CCLabelTTF labelWithString:@"Four StarGeneral" fontName:@"Helvetica" fontSize:22.f];
        oldLabel.anchorPoint = ccp(0,.5f);
        oldLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2);
        [bg addChild:oldLabel];
        
        newSprite = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
        newSprite.position = ccp(self.contentSize.width/2, -70);
        [bg addChild:newSprite];
        
        newLabel = [CCLabelTTF labelWithString:@"Five Star General" fontName:@"Helvetica" fontSize:22.f];
        newLabel.anchorPoint = ccp(0,.5f);
        newLabel.position = ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, -70);
        [bg addChild:newLabel];
    }
    CCActionDelay *gameDelay = [CCActionDelay actionWithDuration:1.1f];
    CCActionMoveTo *liftOld = [CCActionMoveTo actionWithDuration:.8f position:ccp(self.contentSize.width/2, self.contentSize.height+70)];
    CCActionMoveTo *liftOldLabel = [CCActionMoveTo actionWithDuration:.8f position:ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height + 70)];
    CCActionMoveTo *liftNew = [CCActionMoveTo actionWithDuration:.8f position:ccp(self.contentSize.width/2, self.contentSize.height/2)];
    CCActionMoveTo *liftNewLabel = [CCActionMoveTo actionWithDuration:.8f position:ccp(self.contentSize.width/2 + oldSprite.contentSize.width - 50, self.contentSize.height/2)];
    CCActionDelay *delay = [CCActionDelay actionWithDuration:1.f];
    if (game == false){
    [oldSprite runAction:[CCActionSequence actions:delay,liftOld,nil]];
    [oldLabel runAction:[CCActionSequence actions:delay, liftOldLabel, nil]];
    [newSprite runAction:[CCActionSequence actions:delay, liftNew, nil]];
    [newLabel runAction:[CCActionSequence actions:delay, liftNewLabel, nil]];
    }else{
        [oldSprite runAction:[CCActionSequence actions:gameDelay, delay,liftOld,nil]];
        [oldLabel runAction:[CCActionSequence actions:gameDelay, delay, liftOldLabel, nil]];
        [newSprite runAction:[CCActionSequence actions:gameDelay, delay, liftNew, nil]];
        [newLabel runAction:[CCActionSequence actions:gameDelay, delay, liftNewLabel, nil]];
    }
    
    CCActionRemove *remove = [CCActionRemove action];
    CCActionDelay *removeDelay = [CCActionDelay actionWithDuration:2.4f];
        if (game == false){
    [bg runAction:[CCActionSequence actions:removeDelay,remove,nil]];
        }else{
            [bg runAction:[CCActionSequence actions:gameDelay, removeDelay,remove,nil]];
        }
    }
}
- (void)eggRemoved:(CCNode *)egg {
    CCNode *explosion = (CCNode *)[CCBReader load:@"LeftShot"];
    killCount++;
    if(![GameData sharedGameData].newPlayerFlag == true){
        [_scoreLabel setString:[NSString stringWithFormat:@"%li", [GameData sharedGameData].score]];
    }
    explosion.scale = 0.6f;
    explosion.position = egg.position;
    explosion.rotation = egg.rotation;
    [egg.parent addChild:explosion];
    CCActionRemove *actionRemove = [CCActionRemove action];
    id delay = [CCActionDelay actionWithDuration:0.3f];
    [explosion runAction:[CCActionSequence actionWithArray:@[delay, actionRemove]]];
    [egg removeFromParentAndCleanup: NO];
}
-(void)onEnter{
    [super onEnter];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    [_goldCount setString:[NSString stringWithFormat:@"X %d",person.gold.intValue]];
    
}
-(void)rewardMedal:(CCSprite *)medalType andLabel:(NSString*)input andExp:(int)points {
    if(![GameData sharedGameData].newPlayerFlag){
    medalCount+=1;
    //CGRect screenRect = [[UIScreen mainScreen] bounds];
    //CGFloat screenWidth = screenRect.size.width;
    //CGFloat screenHeight = screenRect.size.height;
    CGFloat space = medalType.contentSize.width/2;
    medalType.positionType = CCPositionTypePoints;
    medalType.anchorPoint = ccp(0,1);
    medalType.scale = .83f;
    if(medalCount == 1){
        medalType.position = ccp(_scoreText.position.x +_scoreText.contentSize.width + space, 319.f);
    }else if (medalCount==2){
        medalType.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width + space, 319.f);
    }else if (medalCount==3){
        medalType.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width * 2 + space, 319.f);
    }else if (medalCount==4){
        medalType.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width * 3 + space, 319.f);
    }else if (medalCount==5){
        medalType.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width * 4 + space, 319.f);
    }else if (medalCount==6){
        medalType.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width * 5 + space, 319.f);
    }
    CCLabelTTF *expLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+ %d", points] fontName:@"Didot" fontSize:24];
    expLabel.position = ccp(67,225);
    expLabel.anchorPoint = ccp(0,.5f);
    CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.4f];
    CCActionDelay *delay2 = [CCActionDelay actionWithDuration:.3f];
    CCActionMoveTo *lift = [CCActionMoveTo actionWithDuration:.5f position:ccp(67,285)];
    CCActionRemove *remove = [CCActionRemove action];
    [self addChild:expLabel];
    [expLabel runAction:[CCActionSequence actions:fade, delay2, lift,remove,nil]];
    [self runAction:[CCActionFadeIn actionWithDuration:0.4]];
    [self addChild:medalType];
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@",input] fontName:@"Didot" fontSize:12.0f];
    label.anchorPoint = ccp(.5f,.5f);
    if(medalCount == 1){
        label.position = ccp(_scoreText.position.x +_scoreText.contentSize.width + space + (medalType.contentSize.width/2), 319.f - medalType.contentSize.height - 5);
    }else if (medalCount==2){
        label.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width + space + (medalType.contentSize.width/2), 319.f - medalType.contentSize.height - 5);
    }else if (medalCount==3){
        label.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width * 2+ space + (medalType.contentSize.width/2), 319.f - medalType.contentSize.height - 5);
    }else if (medalCount==4){
        label.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width * 3+ space + (medalType.contentSize.width/2),  319.f - medalType.contentSize.height - 5);
    }else if (medalCount==5){
        label.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width * 4+ space + (medalType.contentSize.width/2),  319.f - medalType.contentSize.height - 5);
    }else if (medalCount==6){
        label.position = ccp(_scoreText.position.x +_scoreText.contentSize.width+medalType.contentSize.width * 5+ space + (medalType.contentSize.width/2),  319.f - medalType.contentSize.height - 5);
    }
    [self addChild:label];
    CCActionDelay *delay =  [CCActionDelay actionWithDuration:1.2f];
    CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
        [self removeChild:medalType];
        [GameData sharedGameData].score+=points;
        [GameData sharedGameData].roundScore+=points;
        [_scoreLabel setString:[NSString stringWithFormat:@"%ld",[GameData sharedGameData].score]];
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

    if ([input isEqualToString:@"Tri"]){
        int tripleCount = person.three.intValue;
        tripleCount++;
        [person setValue:[NSNumber numberWithInt:tripleCount] forKey:@"three"];
    }
    else if ([input isEqualToString:@"Tetra"]){
        int fourCount = person.four.intValue;
        fourCount++;
        [person setValue:[NSNumber numberWithInt:fourCount] forKey:@"four"];
    }
    else if ([input isEqualToString:@"Penta"]){
        int fiveCount = person.five.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"five"];
    }
    else if ([input isEqualToString:@"Hexa"]){
        int fiveCount = person.six.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"six"];
    }
    else if ([input isEqualToString:@"Hepta"]){
        int fiveCount = person.seven.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"seven"];
    }
    else if ([input isEqualToString:@"Octa"]){
        int fiveCount = person.eight.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"eight"];
    }
    else if ([input isEqualToString:@"Ennea"]){
        int fiveCount = person.nine.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"nine"];
    }
    else if ([input isEqualToString:@"Deca"]){
        int fiveCount = person.ten.intValue;
        fiveCount++;
        [person setValue:[NSNumber numberWithInt:fiveCount] forKey:@"ten"];
    }
    else if ([input isEqualToString:@"Icosi"]){
        int twentyCount = person.twenty.intValue;
        twentyCount++;
        NSNumber *conv = [NSNumber numberWithInt:twentyCount];
        [person setValue:conv forKey:@"twenty"];
    }
    else if ([input isEqualToString:@"Triaconta"]){
        int fortyCount = person.forty.intValue;
        fortyCount++;
        [person setValue:[NSNumber numberWithInt:fortyCount] forKey:@"forty"];
    }
    else if ([input isEqualToString:@"Tetraconta"]){
        int sixtyCount = person.sixty.intValue;
        sixtyCount++;
        [person setValue:[NSNumber numberWithInt:sixtyCount] forKey:@"sixty"];
    }
    else if ([input isEqualToString:@"Pentaconta"]){
        int sixtyCount = person.eighty.intValue;
        sixtyCount++;
        [person setValue:[NSNumber numberWithInt:sixtyCount] forKey:@"eighty"];
    }
    else if ([input isEqualToString:@"Hecto"]){
        int sixtyCount = person.hundred.intValue;
        sixtyCount++;
        [person setValue:[NSNumber numberWithInt:sixtyCount] forKey:@"hundred"];
    }
    else if ([input isEqualToString:@"Perfect"]){
        int perfect = person.perfect.intValue;
        perfect++;
        [person setValue:[NSNumber numberWithInt:perfect] forKey:@"perfect"];
    }
    else if ([input isEqualToString:@"Close"]){
        int close = person.closecall.intValue;
        close++;
        [person setValue:[NSNumber numberWithInt:close] forKey:@"closecall"];
    }
    else if ([input isEqualToString:@"Refueled"]){
        int gascomplete = person.gascomplete.intValue;
        gascomplete++;
        [person setValue:[NSNumber numberWithInt:gascomplete] forKey:@"gascomplete"];
    }
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
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
    if(![GameData sharedGameData].newPlayerFlag){
        if(roundCount == 1){
            egg.position = ccp(440.f,120.f);
        }else if (running){
            egg.position = ccp(470.f,135.f);
        }
        else{
            egg.position = ccp(self.contentSize.width-25.f,120.f);
        }
    }else{
        if(tutorialCounter < 11){
            egg.position = ccp(440.f,120.f);
        }else if (running){
            egg.position = ccp(470.f,135.f);
        }
        else{
            egg.position = ccp(self.contentSize.width-25.f,120.f);
        }
    }
    egg.name = @"egg";
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
        if(![GameData sharedGameData].newPlayerFlag == true){
        if (targetsLaunched == 10){
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
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 50){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
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
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 150){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
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
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 300){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
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
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 500){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
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
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 750){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
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
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 1000){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 9){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 1300){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 10){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 1600){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 11){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 2000){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 12){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 2500){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 13){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 3000){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 14){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 3500){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 15){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 4000){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 16){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 4500){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 17){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 5000){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 18){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 5500){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 19){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
        if (targetsLaunched == 6000){
            [self unschedule:@selector(launchEgg)];
            [self unschedule:@selector(launchEggTopRight)];
            if (failedOnce == 3){
                [self unschedule:@selector(launchEggTopLeft)];
                [self unschedule:@selector(launchEggBottomLeft)];
            }
        }
    }
    if (roundCount == 20){
        int minTime = .1f * 1000;
        int maxTime = .3f * 1000;
        int rangeTime = maxTime - minTime;
        int a = (arc4random() % rangeTime) + minTime;
        float randomTime = a/1000.f;
        [self scheduleOnce:@selector(launchEgg) delay:randomTime];
        [self scheduleOnce:@selector(launchEggTopRight) delay:randomTime];
        if (failedOnce == 3){
            [self scheduleOnce:@selector(launchEggTopLeft) delay:randomTime];
            [self scheduleOnce:@selector(launchEggBottomLeft) delay:randomTime];
        }
    }
    if(![GameData sharedGameData].newPlayerFlag == true){
    if(targetsLaunched == 10){  //round 1 over
        if (failedOnce == 1){
            emitter.emissionRate = 20.f;
        }
        [self roundComplete];
    }
    else if(targetsLaunched == 20){ //round 2 over
        if (failedOnce == 1){
            emitter.emissionRate = 20.f;
        }
        [self roundComplete];
    }
    else if(targetsLaunched == 50){ //round 3 over
        if (failedOnce == 1){
            emitter.emissionRate = 20.f;
        }
        [self roundComplete];
    }
    else if(targetsLaunched == 150){    //round 4 over
        if (failedOnce == 1){
            emitter.emissionRate = 20.f;
        }
        [self roundComplete];
    }
    else if(targetsLaunched == 300){    //round 5 over
        [self roundComplete];
    }
    else if(targetsLaunched == 500){    //round 6 over
        [self roundComplete];
    }
    else if(targetsLaunched == 750){    //round 7 over
        [self roundComplete];
    }
    else if(targetsLaunched == 1000){   //round 8 over
        [self roundComplete];
    }
    else if(targetsLaunched == 1300){   //round 9 over
        [self roundComplete];
    }
    else if(targetsLaunched == 1600){   //round 10 over
        [self roundComplete];
    }
    else if(targetsLaunched == 2000){   //round 11 over
        [self roundComplete];
    }
    else if(targetsLaunched == 2500){   //round 12 over
        [self roundComplete];
    }
    else if(targetsLaunched == 3000){   //round 13 over
        [self roundComplete];
    }
    else if(targetsLaunched == 3500){   //round 14 over
        [self roundComplete];
    }
    else if(targetsLaunched == 4000){   //round 15 over
        [self roundComplete];
    }
    else if(targetsLaunched == 4500){   //round 16 over
        [self roundComplete];
    }
    else if(targetsLaunched == 5000){   //round 17 over
        [self roundComplete];
    }
    else if(targetsLaunched == 5500){   //round 18 over
        [self roundComplete];
    }
    else if(targetsLaunched == 6000){   //round 19 over
        [self roundComplete];
    }
                                        //round 20 will last until the player is defeated
    }
}
-(void)roundComplete{
    if (perfectRound){
        [self rewardMedal:[CCSprite spriteWithImageNamed:@"Assets/Perfect.png"] andLabel:@"Perfect" andExp:10];
    }
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    NSNumber *expSum = [NSNumber numberWithLong:(person.experience.intValue + [GameData sharedGameData].roundScore)];
    CCLOG(@"Person exp before: %d roundExp: %d", person.experience.intValue, [GameData sharedGameData].roundScore);
    [GameData sharedGameData].roundScore = 0;
    [person setValue:expSum forKey:@"experience"];
    CCLOG(@"Person exp before: %d roundExp: %d", person.experience.intValue, [GameData sharedGameData].roundScore);
    CCLOG(@"Person rank before: %d person rankAfter: %d", rankBefore, rankAfter);
    
    if (person.experience<[GameData sharedGameData].rank1){
        [person setValue:[NSNumber numberWithInt:0] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank1 && person.experience<[GameData sharedGameData].rank2){
        [person setValue:[NSNumber numberWithInt:1] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank2 && person.experience<[GameData sharedGameData].rank3){
        [person setValue:[NSNumber numberWithInt:2] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank3 && person.experience<[GameData sharedGameData].rank4){
        [person setValue:[NSNumber numberWithInt:3] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank4 && person.experience<[GameData sharedGameData].rank5){
        [person setValue:[NSNumber numberWithInt:4] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank5 && person.experience<[GameData sharedGameData].rank6){
        [person setValue:[NSNumber numberWithInt:5] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank6 && person.experience<[GameData sharedGameData].rank7){
        [person setValue:[NSNumber numberWithInt:6] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank7 && person.experience<[GameData sharedGameData].rank8){
        [person setValue:[NSNumber numberWithInt:7] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank8 && person.experience<[GameData sharedGameData].rank9){
        [person setValue:[NSNumber numberWithInt:8] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank9 && person.experience<[GameData sharedGameData].rank10){
        [person setValue:[NSNumber numberWithInt:9] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank10 && person.experience<[GameData sharedGameData].rank11){
        [person setValue:[NSNumber numberWithInt:10] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank11 && person.experience<[GameData sharedGameData].rank12){
        [person setValue:[NSNumber numberWithInt:11] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank12 && person.experience<[GameData sharedGameData].rank13){
        [person setValue:[NSNumber numberWithInt:12] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank13 && person.experience<[GameData sharedGameData].rank14){
        [person setValue:[NSNumber numberWithInt:13] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank14 && person.experience<[GameData sharedGameData].rank15){
        [person setValue:[NSNumber numberWithInt:14] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank15 && person.experience<[GameData sharedGameData].rank16){
        [person setValue:[NSNumber numberWithInt:15] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank16 && person.experience<[GameData sharedGameData].rank17){
       [person setValue:[NSNumber numberWithInt:16] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank17 && person.experience<[GameData sharedGameData].rank18){
        [person setValue:[NSNumber numberWithInt:17] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank18 && person.experience<[GameData sharedGameData].rank19){
        [person setValue:[NSNumber numberWithInt:18] forKey:@"rank"];
        
        
    }
    else if(person.experience>=[GameData sharedGameData].rank19 && person.experience<[GameData sharedGameData].rank20){
        [person setValue:[NSNumber numberWithInt:19] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank20 && person.experience<[GameData sharedGameData].rank21){
        [person setValue:[NSNumber numberWithInt:20] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank21 && person.experience<[GameData sharedGameData].rank22){
        [person setValue:[NSNumber numberWithInt:21] forKey:@"rank"];

    }
    else if(person.experience>=[GameData sharedGameData].rank22 && person.experience<[GameData sharedGameData].rank23){
        [person setValue:[NSNumber numberWithInt:22] forKey:@"rank"];
        
    }
    else if(person.experience>=[GameData sharedGameData].rank23 && person.experience<[GameData sharedGameData].rank24){
        [person setValue:[NSNumber numberWithInt:23] forKey:@"rank"];
    }
    else if(person.experience>=[GameData sharedGameData].rank24){
        [person setValue:[NSNumber numberWithInt:24] forKey:@"rank"];
    }
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
        if (running){
            [self unschedule:@selector(scrollBackground:)];
            [self unschedule:@selector(scrollMid:)];
            [self unschedule:@selector(scrollBack:)];
            [_tractor setPaused:true];
            [horse setPaused:true];
        }
        running = false;
        emitter.duration = .01f;
        emitter.autoRemoveOnFinish = true;
        self.userInteractionEnabled = FALSE;
        _pauseButton.visible = false;
        _bomb.visible = false;
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
        [complete runAction:[CCActionSequence actions:fade, delay2, lift, remove,nil]];
        CCActionCallBlock *levelUpBlock;
        rankAfter = person.rank.intValue;
        CCLOG(@"rank before: %d, rank after: %d", rankBefore, rankAfter);
        if (rankBefore < rankAfter){
            levelUpBlock = [CCActionCallBlock actionWithBlock:^(void){
                [self showLevelUp:person.rank.intValue gameOver:false];
                overlay.visible = false;
            }];
        } else{
            levelUpBlock = nil;
        }
        CCActionCallBlock *visible = [CCActionCallBlock actionWithBlock:^(void){
            overlay.visible = true;
        }];
        CCActionDelay *levelUpDelay = [CCActionDelay actionWithDuration:2.2f];
        [self runAction:[CCActionSequence actions:levelUpDelay,levelUpBlock,visible, nil]];
        
        CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^{
            [GameData sharedGameData].bombCount = person.nukes.intValue;
            [_bombCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
            [_nukes setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
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
        _goldCount.anchorPoint = ccp(0,.5f);
        _goldCount.position = ccp(.165f,.4f);
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
        int min1;
        int max1;
        if (person.betterodds.intValue == 1){
            min1 = 1;
            max1 = 3;
        }else{
            min1 = 1;
            max1 = 5;
        }
        int range1 = max1 - min1;
        int random1 = (arc4random() % range1) + min1;
        switch (random1){
            case 1:{
                int wallet;
                if (person.bladewallet){
                    wallet = 20;
                }
                else{
                    wallet = 10;
                }
                if (person.blades.intValue < wallet){
                    int blades = person.blades.intValue;
                    blades++;
                    [person setValue:[NSNumber numberWithInt:blades] forKey:@"blades"];
                    [GameData sharedGameData].bladeCount = person.blades.intValue;
                    [bladeCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
                    [bladeCostLabel setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bladeCount]];
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
                }
                break;
            }
            case 2:{
                int wallet;
                if (person.nukewallet){
                    wallet = 20;
                }
                else{
                    wallet = 10;
                }
                if (person.nukes.intValue < wallet){
                    int bombs = person.nukes.intValue;
                    bombs++;
                    [person setValue:[NSNumber numberWithInt:bombs] forKey:@"nukes"];
                    NSError *error2 = nil;
                    if (![person.managedObjectContext save:&error2]) {
                        NSLog(@"Unable to save managed object context.");
                        NSLog(@"%@, %@", error2, error2.localizedDescription);
                    }
                    [GameData sharedGameData].bombCount = person.nukes.intValue;
                    [_bombCount setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
                    [_nukes setString:[NSString stringWithFormat:@"%d", [GameData sharedGameData].bombCount]];
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
                }
            }
                break;
            case 3:{
                
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
    _bombCount.visible = true;
    bladeCount.visible = true;
    bladeButton.visible = true;
    timer.visible = true;

    NSString *text = [NSString stringWithFormat:@"%d", roundCount];
    [self newRound:text];
    [self initRound:roundCount];
}






- (void)showGasAlert{
    static int one;
    static int two;
    static int three;
    static int four;
    
    if (running){
    alert = [CCSprite spriteWithImageNamed:@"Assets/lowGas.png"];
    alert.name = @"1234";
    alert.positionType = CCPositionTypeUIPoints;
    //alert.scaleType = CCScaleTypeScaled;
    //alert.scale = 2.f;
    alert.anchorPoint  = ccp(.5f,.5f);
    alert.positionType = CCPositionTypeNormalized;
    alert.position = ccp(.5f,.5f);
    
    float fontSize = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?36:20;
        /*
    CGPoint seq1Size = CGPointMake(10, alert.contentSize.height + 10);
    CGPoint seq2Size = CGPointMake(35, alert.contentSize.height + 10);
    CGPoint seq3Size = CGPointMake(60, alert.contentSize.height + 10);
    CGPoint seq4Size = CGPointMake(85, alert.contentSize.height + 10);
         */
        CGPoint seq1Size = CGPointMake(.42f, .7f);
        CGPoint seq2Size = CGPointMake(.47f, .7f);
        CGPoint seq3Size = CGPointMake(.52f, .7f);
        CGPoint seq4Size = CGPointMake(.57f, .7f);
    
        //sequence where I is equal to the order of the command plus one (zero based), seq 1 refers to up, seq 2 refers to right, seq 3
        //refers to down, and seq 4 refers to left
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
                    upLab1.positionType = CCPositionTypeNormalized;
                    upLab1.position = seq1Size;
                    upLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab1.name = @"upLab1";
                    [self addChild:upLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 1;
                    upLab2 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab2.positionType = CCPositionTypeNormalized;
                    upLab2.position = seq2Size;
                    upLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab2.name = @"upLab2";
                    [self addChild:upLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 1;
                    upLab3 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab3.positionType = CCPositionTypeNormalized;
                    upLab3.position = seq3Size;
                    upLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab3.name = @"upLab3";
                    [self addChild:upLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 1;
                    upLab4 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab4.positionType = CCPositionTypeNormalized;
                    upLab4.position = seq4Size;
                    upLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab4.name = @"upLab4";
                    [self addChild:upLab4];
                }
            }
            if (seq1 == 2){
                NSString *right = [NSString stringWithFormat:@"→"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 2;
                    rightLab1 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab1.positionType = CCPositionTypeNormalized;
                    rightLab1.position = seq1Size;
                    rightLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab1.name = @"rightLab1";
                    [self addChild:rightLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 2;
                    rightLab2 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab2.positionType = CCPositionTypeNormalized;
                    rightLab2.position = seq2Size;
                    rightLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab2.name = @"rightLab2";
                    [self addChild:rightLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 2;
                    rightLab3 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab3.positionType = CCPositionTypeNormalized;
                    rightLab3.position = seq3Size;
                    rightLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab3.name = @"rightLab3";
                    [self addChild:rightLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 2;
                    rightLab4 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab4.positionType = CCPositionTypeNormalized;
                    rightLab4.position = seq4Size;
                    rightLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab4.name = @"rightLab4";
                    [self addChild:rightLab4];
                }
            }
            if (seq1 == 3){
                NSString *down = [NSString stringWithFormat:@"↓"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 3;
                    downLab1 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab1.positionType = CCPositionTypeNormalized;
                    downLab1.position = seq1Size;
                    downLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab1.name = @"downLab1";
                    [self addChild:downLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 3;
                    downLab2 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab2.positionType = CCPositionTypeNormalized;
                    downLab2.position = seq2Size;
                    downLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab2.name = @"downLab2";
                    [self addChild:downLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 3;
                    downLab3 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab3.positionType = CCPositionTypeNormalized;
                    downLab3.position = seq3Size;
                    downLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab3.name = @"downLab3";
                    [self addChild:downLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 3;
                    downLab4 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab4.positionType = CCPositionTypeNormalized;
                    downLab4.position = seq4Size;
                    downLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab4.name = @"downLab4";
                    [self addChild:downLab4];
                }
            }
            if (seq1 == 4){
                NSString *left = [NSString stringWithFormat:@"←"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 4;
                    leftLab1 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab1.positionType = CCPositionTypeNormalized;
                    leftLab1.position = seq1Size;
                    leftLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab1.name = @"leftLab1";
                    [self addChild:leftLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 4;
                    leftLab2 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab2.positionType = CCPositionTypeNormalized;
                    leftLab2.position = seq2Size;
                    leftLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab2.name = @"leftLab2";
                    [self addChild:leftLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 4;
                    leftLab3 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab3.positionType = CCPositionTypeNormalized;
                    leftLab3.position = seq3Size;
                    leftLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab3.name = @"leftLab3";
                    [self addChild:leftLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 4;
                    leftLab4 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab4.positionType = CCPositionTypeNormalized;
                    leftLab4.position = seq4Size;
                    leftLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab4.name = @"leftLab4";
                    [self addChild:leftLab4];
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
                    upLab1.positionType = CCPositionTypeNormalized;
                    upLab1.position = seq1Size;
                    upLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab1.name = @"upLab1";
                    [self addChild:upLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 1;
                    upLab2 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab2.positionType = CCPositionTypeNormalized;
                    upLab2.position = seq2Size;
                    upLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab2.name = @"upLab2";
                    [self addChild:upLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 1;
                    upLab3 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab3.positionType = CCPositionTypeNormalized;
                    upLab3.position = seq3Size;
                    upLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab3.name = @"upLab3";
                    [self addChild:upLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 1;
                    upLab4 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab4.positionType = CCPositionTypeNormalized;
                    upLab4.position = seq4Size;
                    upLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab4.name = @"upLab4";
                    [self addChild:upLab4];
                }
            }
            if (seq2 == 2){
                NSString *right = [NSString stringWithFormat:@"→"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 2;
                    rightLab1 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab1.positionType = CCPositionTypeNormalized;
                    rightLab1.position = seq1Size;
                    rightLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab1.name = @"rightLab1";
                    [self addChild:rightLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 2;
                    rightLab2 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab2.positionType = CCPositionTypeNormalized;
                    rightLab2.position = seq2Size;
                    rightLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab2.name = @"rightLab2";
                    [self addChild:rightLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 2;
                    rightLab3 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab3.positionType = CCPositionTypeNormalized;
                    rightLab3.position = seq3Size;
                    rightLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab3.name = @"rightLab3";
                    [self addChild:rightLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 2;
                    rightLab4 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab4.positionType = CCPositionTypeNormalized;
                    rightLab4.position = seq4Size;
                    rightLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab4.name = @"rightLab4";
                    [self addChild:rightLab4];
                }
            }
            if (seq2 == 3){
                NSString *down = [NSString stringWithFormat:@"↓"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 3;
                    downLab1 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab1.positionType = CCPositionTypeNormalized;
                    downLab1.position = seq1Size;
                    downLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab1.name = @"downLab1";
                    [self addChild:downLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 3;
                    downLab2 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab2.positionType = CCPositionTypeNormalized;
                    downLab2.position = seq2Size;
                    downLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab2.name = @"downLab2";
                    [self addChild:downLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 3;
                    downLab3 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab3.positionType = CCPositionTypeNormalized;
                    downLab3.position = seq3Size;
                    downLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab3.name = @"downLab3";
                    [self addChild:downLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 3;
                    downLab4 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab4.positionType = CCPositionTypeNormalized;
                    downLab4.position = seq4Size;
                    downLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab4.name = @"downLab4";
                    [self addChild:downLab4];
                }
            }
            if (seq2 == 4){
                NSString *left = [NSString stringWithFormat:@"←"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 4;
                    leftLab1 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab1.positionType = CCPositionTypeNormalized;
                    leftLab1.position = seq1Size;
                    leftLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab1.name = @"leftLab1";
                    [self addChild:leftLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 4;
                    leftLab2 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab2.positionType = CCPositionTypeNormalized;
                    leftLab2.position = seq2Size;
                    leftLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab2.name = @"leftLab2";
                    [self addChild:leftLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 4;
                    leftLab3 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab3.positionType = CCPositionTypeNormalized;
                    leftLab3.position = seq3Size;
                    leftLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab3.name = @"leftLab3";
                    [self addChild:leftLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 4;
                    leftLab4 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab4.positionType = CCPositionTypeNormalized;
                    leftLab4.position = seq4Size;
                    leftLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab4.name = @"leftLab4";
                    [self addChild:leftLab4];
                }
            }
        }
        else if (i==2){
            three = random;
            seq3 = three;
            if (seq3 == 1){
                NSString *up = [NSString stringWithFormat:@"↑"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 1;
                    upLab1 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab1.positionType = CCPositionTypeNormalized;
                    upLab1.position = seq1Size;
                    upLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab1.name = @"upLab1";
                    [self addChild:upLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 1;
                    upLab2 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab2.positionType = CCPositionTypeNormalized;
                    upLab2.position = seq2Size;
                    upLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab2.name = @"upLab2";
                    [self addChild:upLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 1;
                    upLab3 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab3.positionType = CCPositionTypeNormalized;
                    upLab3.position = seq3Size;
                    upLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab3.name = @"upLab3";
                    [self addChild:upLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 1;
                    upLab4 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab4.positionType = CCPositionTypeNormalized;
                    upLab4.position = seq4Size;
                    upLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab4.name = @"upLab4";
                    [self addChild:upLab4];
                }
            }
            if (seq3 == 2){
                NSString *right = [NSString stringWithFormat:@"→"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 2;
                    rightLab1 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab1.positionType = CCPositionTypeNormalized;
                    rightLab1.position = seq1Size;
                    rightLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab1.name = @"rightLab1";
                    [self addChild:rightLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 2;
                    rightLab2 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab2.positionType = CCPositionTypeNormalized;
                    rightLab2.position = seq2Size;
                    rightLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab2.name = @"rightLab2";
                    [self addChild:rightLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 2;
                    rightLab3 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab3.positionType = CCPositionTypeNormalized;
                    rightLab3.position = seq3Size;
                    rightLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab3.name = @"rightLab3";
                    [self addChild:rightLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 2;
                    rightLab4 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab4.positionType = CCPositionTypeNormalized;
                    rightLab4.position = seq4Size;
                    rightLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab4.name = @"rightLab4";
                    [self addChild:rightLab4];
                }
            }
            if (seq3 == 3){
                NSString *down = [NSString stringWithFormat:@"↓"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 3;
                    downLab1 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab1.positionType = CCPositionTypeNormalized;
                    downLab1.position = seq1Size;
                    downLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab1.name = @"downLab1";
                    [self addChild:downLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 3;
                    downLab2 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab2.positionType = CCPositionTypeNormalized;
                    downLab2.position = seq2Size;
                    downLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab2.name = @"downLab2";
                    [self addChild:downLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 3;
                    downLab3 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab3.positionType = CCPositionTypeNormalized;
                    downLab3.position = seq3Size;
                    downLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab3.name = @"downLab3";
                    [self addChild:downLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 3;
                    downLab4 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab4.positionType = CCPositionTypeNormalized;
                    downLab4.position = seq4Size;
                    downLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab4.name = @"downLab4";
                    [self addChild:downLab4];
                }
            }
            if (seq3 == 4){
                NSString *left = [NSString stringWithFormat:@"←"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 4;
                    leftLab1 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab1.positionType = CCPositionTypeNormalized;
                    leftLab1.position = seq1Size;
                    leftLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab1.name = @"leftLab1";
                    [self addChild:leftLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 4;
                    leftLab2 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab2.positionType = CCPositionTypeNormalized;
                    leftLab2.position = seq2Size;
                    leftLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab2.name = @"leftLab2";
                    [self addChild:leftLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 4;
                    leftLab3 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab3.positionType = CCPositionTypeNormalized;
                    leftLab3.position = seq3Size;
                    leftLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab3.name = @"leftLab3";
                    [self addChild:leftLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 4;
                    leftLab4 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab4.positionType = CCPositionTypeNormalized;
                    leftLab4.position = seq4Size;
                    leftLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab4.name = @"leftLab4";
                    [self addChild:leftLab4];
                }
            }
        }
        if (i==3){
            four = random;
            seq4 = four;
            if (seq4 == 1){
                NSString *up = [NSString stringWithFormat:@"↑"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 1;
                    upLab1 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab1.positionType = CCPositionTypeNormalized;
                    upLab1.position = seq1Size;
                    upLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab1.name = @"upLab1";
                    [self addChild:upLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 1;
                    upLab2 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab2.positionType = CCPositionTypeNormalized;
                    upLab2.position = seq2Size;
                    upLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab2.name = @"upLab2";
                    [self addChild:upLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 1;
                    upLab3 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab3.positionType = CCPositionTypeNormalized;
                    upLab3.position = seq3Size;
                    upLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab3.name = @"upLab3";
                    [self addChild:upLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 1;
                    upLab4 = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize];
                    upLab4.positionType = CCPositionTypeNormalized;
                    upLab4.position = seq4Size;
                    upLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    upLab4.name = @"upLab4";
                    [self addChild:upLab4];
                }
            }
            if (seq4 == 2){
                NSString *right = [NSString stringWithFormat:@"→"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 2;
                    rightLab1 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab1.positionType = CCPositionTypeNormalized;
                    rightLab1.position = seq1Size;
                    rightLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab1.name = @"rightLab1";
                    [self addChild:rightLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 2;
                    rightLab2 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab2.positionType = CCPositionTypeNormalized;
                    rightLab2.position = seq2Size;
                    rightLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab2.name = @"rightLab2";
                    [self addChild:rightLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 2;
                    rightLab3 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab3.positionType = CCPositionTypeNormalized;
                    rightLab3.position = seq3Size;
                    rightLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab3.name = @"rightLab3";
                    [self addChild:rightLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 2;
                    rightLab4 = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize];
                    rightLab4.positionType = CCPositionTypeNormalized;
                    rightLab4.position = seq4Size;
                    rightLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    rightLab4.name = @"rightLab4";
                    [self addChild:rightLab4];
                }
            }
            if (seq4 == 3){
                NSString *down = [NSString stringWithFormat:@"↓"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 3;
                    downLab1 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab1.positionType = CCPositionTypeNormalized;
                    downLab1.position = seq1Size;
                    downLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab1.name = @"downLab1";
                    [self addChild:downLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 3;
                    downLab2 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab2.positionType = CCPositionTypeNormalized;
                    downLab2.position = seq2Size;
                    downLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab2.name = @"downLab2";
                    [self addChild:downLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 3;
                    downLab3 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab3.positionType = CCPositionTypeNormalized;
                    downLab3.position = seq3Size;
                    downLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab3.name = @"downLab3";
                    [self addChild:downLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 3;
                    downLab4 = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize];
                    downLab4.positionType = CCPositionTypeNormalized;
                    downLab4.position = seq4Size;
                    downLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    downLab4.name = @"downLab4";
                    [self addChild:downLab4];
                }
            }
            if (seq4 == 4){
                NSString *left = [NSString stringWithFormat:@"←"];
                if(i == 0){
                    [GameData sharedGameData].seq1 = 4;
                    leftLab1 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab1.positionType = CCPositionTypeNormalized;
                    leftLab1.position = seq1Size;
                    leftLab1.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab1.name = @"leftLab1";
                    [self addChild:leftLab1];
                }
                else if(i == 1){
                    [GameData sharedGameData].seq2 = 4;
                    leftLab2 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab2.positionType = CCPositionTypeNormalized;
                    leftLab2.position = seq2Size;
                    leftLab2.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab2.name = @"leftLab2";
                    [self addChild:leftLab2];
                }
                else if(i == 2){
                    [GameData sharedGameData].seq3 = 4;
                    leftLab3 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab3.positionType = CCPositionTypeNormalized;
                    leftLab3.position = seq3Size;
                    leftLab3.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab3.name = @"leftLab3";
                    [self addChild:leftLab3];
                }
                else if(i == 3){
                    [GameData sharedGameData].seq4 = 4;
                    leftLab4 = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize];
                    leftLab4.positionType = CCPositionTypeNormalized;
                    leftLab4.position = seq4Size;
                    leftLab4.color = [CCColor colorWithCcColor3b:ccBLACK];
                    leftLab4.name = @"leftLab4";
                    [self addChild:leftLab4];
                }
            }
        }
    }

    [self addChild:alert];
    
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
        float fadeLength;
        if(roundCount > 1 && roundCount < 6){
            fadeLength = .6f;
        }
        if(roundCount >= 6 && roundCount < 10){
            fadeLength = .4f;
        }
        if(roundCount >= 11 && roundCount < 15){
            fadeLength = .3f;
        }
        if(roundCount >= 15 && roundCount <= 20){
            fadeLength = .2f;
        }
    CCActionFadeTo *fadeIn = [CCActionFadeTo actionWithDuration:fadeLength opacity:1.f];
    CCActionFadeTo *fadeOut = [CCActionFadeTo actionWithDuration:fadeLength opacity:.3f];
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
    CCActionCallBlock *failBlock = [CCActionCallBlock actionWithBlock:^(void){
        [self gasAlertFailed];
    }];
    if(![GameData sharedGameData].newPlayerFlag){
        [alert runAction:[CCActionSequence actions: fadeIn,fadeOut,fadeIn,fadeOut, fadeIn, fadeOut, block, shortDelay, remove, failBlock, nil]];
    }else{
        [alert runAction:[CCActionSequence actions: fadeIn,fadeOut,fadeIn,fadeOut, fadeIn, fadeOut, fadeIn, fadeOut, fadeIn, fadeOut, block, shortDelay, remove, failBlock, nil]];
    }
    }
         
}
-(void)gasAlertFailed{
    //up
    if ([self getChildByName:@"upLab1" recursively:YES]){
        [self removeChild:upLab1];
    }
    if ([self getChildByName:@"upLab2" recursively:YES]){
        [self removeChild:upLab2];
    }
    if ([self getChildByName:@"upLab3" recursively:YES]){
        [self removeChild:upLab3];
    }
    if ([self getChildByName:@"upLab4" recursively:YES]){
        [self removeChild:upLab4];
    }
    //right
    if ([self getChildByName:@"rightLab1" recursively:YES]){
        [self removeChild:rightLab1];
    }
    if ([self getChildByName:@"rightLab2" recursively:YES]){
        [self removeChild:rightLab2];
    }
    if ([self getChildByName:@"rightLab3" recursively:YES]){
        [self removeChild:rightLab3];
    }
    if ([self getChildByName:@"rightLab4" recursively:YES]){
        [self removeChild:rightLab4];
    }
    //down
    if ([self getChildByName:@"downLab1" recursively:YES]){
        [self removeChild:downLab1];
    }
    if ([self getChildByName:@"downLab2" recursively:YES]){
        [self removeChild:downLab2];
    }
    if ([self getChildByName:@"downLab3" recursively:YES]){
        [self removeChild:downLab3];
    }
    if ([self getChildByName:@"downLab4" recursively:YES]){
        [self removeChild:downLab4];
    }
    //left
    if ([self getChildByName:@"leftLab1" recursively:YES]){
        [self removeChild:leftLab1];
    }
    if ([self getChildByName:@"leftLab2" recursively:YES]){
        [self removeChild:leftLab2];
    }
    if ([self getChildByName:@"leftLab3" recursively:YES]){
        [self removeChild:leftLab3];
    }
    if ([self getChildByName:@"leftLab4" recursively:YES]){
        [self removeChild:leftLab4];
    }
    if (failedOnce == 0){
        CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
            emitter = [CCParticleSystem particleWithFile:@"exhaust.plist"];
            [self addChild:emitter];
            emitter.position = ccp(_barn.position.x-75,_barn.position.y);
            emitter.duration = .5;
            emitter.zOrder = 2;
            emitter.autoRemoveOnFinish = true;
        }];
        CCActionCallBlock *block2 = [CCActionCallBlock actionWithBlock:^(void){
            emitter = [CCParticleSystem particleWithFile:@"exhaust.plist"];
            [self addChild:emitter];
            emitter.zOrder = 2;
            emitter.position = ccp(_barn.position.x-70,_barn.position.y);
        }];
        CCActionDelay *delay = [CCActionDelay actionWithDuration:.5f];
        [self runAction:[CCActionSequence actions:block,delay,block,delay, delay, delay, block2,nil]];
        failedOnce++;
        CCActionMoveTo *moveTractor = [CCActionMoveTo actionWithDuration:1.5f position:ccp(_tractor.position.x+210,_tractor.position.y)];
        CCActionMoveTo *moveBarn = [CCActionMoveTo actionWithDuration:1.5f position:ccp(_barn.position.x+210,_barn.position.y)];
        [_tractor runAction:moveTractor];
        [_barn runAction:moveBarn];
    }
    else{
        failedOnce++;
        running = false;
        emitter.duration = .1f;
        emitter.autoRemoveOnFinish = true;
        CCActionMoveTo *moveTractor = [CCActionMoveTo actionWithDuration:1.5f position:ccp(_tractor.position.x-500,_tractor.position.y)];
        CCActionMoveTo *moveBarn = [CCActionMoveTo actionWithDuration:1.5f position:ccp(_barn.position.x,_barn.position.y-20)];
        CCActionMoveTo *moveHorse = [CCActionMoveTo actionWithDuration:1.5f position:ccp(horse.position.x-1000,horse.position.y)];
        CCActionMoveTo *moveChicken = [CCActionMoveTo actionWithDuration:1.5f position:ccp(self.contentSize.width+10,chicken.position.y-30)];
        [_tractor runAction:moveTractor];
        [_barn runAction:moveBarn];
        [horse runAction:moveHorse];
        [chicken runAction:moveChicken];
        [self unschedule:@selector(scrollBackground:)];
        [self unschedule:@selector(scrollMid:)];
        [self unschedule:@selector(scrollBack:)];
        if ([GameData sharedGameData].newPlayerFlag){
            CCActionCallBlock *block = [CCActionCallBlock actionWithBlock:^(void){
                [[CCDirector sharedDirector] pause];
                if (![self getChildByName:@"overlay" recursively:YES]){
                    [self addChild:tutorialOverlay];
                    tutorialOverlay.name = @"overlay";
                }
                if (![tutorialOverlay getChildByName:@"instructions" recursively:YES]){
                    instructions.name = @"instructions";
                    [tutorialOverlay addChild:instructions];
                };
                if (![tutorialOverlay getChildByName:@"continueButton" recursively:YES]){
                    continueButton.name = @"continueButton";
                    [tutorialOverlay addChild:continueButton];
                };
            }];
            [self changeContinue];
            [self runAction:[CCActionSequence actions:[CCActionDelay actionWithDuration:1.5f], block, nil]];
        }
    }
}
-(void)quitTutorial{
    roundCount = 1;
    [GameData sharedGameData].newPlayerFlag = false;
    [[CCDirector sharedDirector] popScene];
}

// -----------------------------------------------------------------

@end

