//
//  HighScoresScene.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/1/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "HighScoresScene.h"
#import "GameData.h"

// -----------------------------------------------------------------

@implementation HighScoresScene{
    CCLabelTTF *_userName;
    CCLabelTTF *_rankLabel;
    CCSprite *_rankIcon;
    CCProgressNode *_progress;
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

-(void)backToMenu{
    CCScene *gameplayScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}
-(void) onEnter
{
    [super onEnter];
    [self addHighScore];
    
    CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
    /*
    _progressNode1.type = CCProgressNodeTypeBar;
    _progressNode1.midpoint = ccp(0.0f, 0.0f);
    _progressNode1.anchorPoint = ccp(0,1);
    _progressNode1.barChangeRate = ccp(1.0f, 0.5f);
    
    _progressNode1.zOrder = 2500000;
    
    _progressNode1.positionType = CCPositionTypeNormalized;
    _progressNode1.position = ccp(.2f,.65f);
     */

    
    CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
    //sprite = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
    base.anchorPoint = ccp(0,1);
    base.positionType = CCPositionTypeNormalized;
    base.position = ccp(.2f,.65f);
    [self addChild:base];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:fetchRequest error:&error2] objectAtIndex:0];
    [[GameData sharedGameData]summarizeRank:_rankLabel andUser:_userName andRankIcon:_rankIcon];
    
    
    _progress = [CCProgressNode progressWithSprite:progress];
    _progress.type = CCProgressNodeTypeBar;
    _progress.midpoint = ccp(0.0f, 0.0f);
    _progress.anchorPoint = ccp(0,1);
    _progress.barChangeRate = ccp(1.0f, 0.5f);
    _progress.zOrder = 2500000;
    
    int rank = person.rank.intValue;
    if(rank ==0){
        int experience = person.experience.intValue;
        int currentRankExp = [GameData sharedGameData].rank1.intValue;
        float temp = (float)experience/(float)currentRankExp *100;
        CCLOG(@"temp: %f experience %d currentRankExp %d", temp, experience, currentRankExp);
        _progress.percentage=temp;
    }
    else if (rank == 1){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank2.intValue;
        int nextRank = [GameData sharedGameData].rank1.intValue;
        int currentRankExp = experience - nextRank;
        
        float temp = (float)currentRankExp/(float)currentRank *100;
        CCLOG(@"temp: %f experience %d currentRankExp %d", temp, experience, currentRankExp);
        _progress.percentage=temp;
    }
    else if (rank == 2){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank3.intValue;
        int nextRank = [GameData sharedGameData].rank2.intValue;
        int currentRankExp = experience - nextRank;
        
        float temp = (float)currentRankExp/(float)currentRank *100;
        CCLOG(@"temp: %f experience %d currentRankExp %d", temp, experience, currentRankExp);
        _progress.percentage=temp;
    }
    else if (rank == 3){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank4.intValue;
        int nextRank = [GameData sharedGameData].rank3.intValue;
        int currentRankExp = experience - nextRank;
        
        float temp = (float)currentRankExp/(float)currentRank *100;
        CCLOG(@"temp: %f experience %d currentRankExp %d", temp, experience, currentRankExp);
        _progress.percentage=temp;
    }
    _progress.positionType = CCPositionTypeNormalized;
    _progress.position = ccp(.2f,.65f);
    [self addChild:_progress];
    
    
}
-(void)addHighScore{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error2 = nil;
    NSArray *result = [[GameData sharedGameData].managedObjectContext executeFetchRequest:fetchRequest error:&error2];
    Person *person = [result objectAtIndex:0];
    
    if (error2) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
        
    } else {
        NSString *doubles = [NSString stringWithFormat:@"%@", [person valueForKey:@"highscore"]];
        CCLabelTTF* count = [CCLabelTTF labelWithString:doubles fontName:@"HelveticaNeue" fontSize:30];
        count.positionType = CCPositionTypeNormalized;
        count.position = ccp(.5f,.4f);
        
        
        
        [self addChild:count];
    }
    if (result.count > 0) {
        NSManagedObject *person = (NSManagedObject *)[result objectAtIndex:0];
        NSLog(@"1 - %@", person);
        
        NSLog(@"%@ %@", [person valueForKey:@"name"], [person valueForKey:@"highscore"]);
        
        NSLog(@"2 - %@", person);
    }
}


// -----------------------------------------------------------------

@end





