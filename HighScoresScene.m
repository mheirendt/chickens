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
    CCLabelTTF *scoreLabel;
    CCLabelTTF *roundLabel;
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
    CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
    base.anchorPoint = ccp(0,1);
    base.positionType = CCPositionTypeNormalized;
    base.position = ccp(.2f,.65f);
    [self addChild:base];

    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    [[GameData sharedGameData]summarizeRank:_rankLabel andUser:_userName andRankIcon:_rankIcon];
    
    
    _progress = [CCProgressNode progressWithSprite:progress];
    _progress.type = CCProgressNodeTypeBar;
    _progress.midpoint = ccp(0.0f, 0.0f);
    _progress.anchorPoint = ccp(0,1);
    _progress.barChangeRate = ccp(1.0f, 0.5f);
    _progress.zOrder = 2500000;
    
    int rank = person.rank.intValue;
    if(rank == 0){
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
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;            }
    else if (rank == 3){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank4.intValue;
        int nextRank = [GameData sharedGameData].rank3.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 4){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank5.intValue;
        int nextRank = [GameData sharedGameData].rank4.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 5){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank6.intValue;
        int nextRank = [GameData sharedGameData].rank5.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 6){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank7.intValue;
        int nextRank = [GameData sharedGameData].rank6.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 7){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank8.intValue;
        int nextRank = [GameData sharedGameData].rank7.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 8){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank9.intValue;
        int nextRank = [GameData sharedGameData].rank8.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 9){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank10.intValue;
        int nextRank = [GameData sharedGameData].rank9.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 10){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank11.intValue;
        int nextRank = [GameData sharedGameData].rank10.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 11){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank12.intValue;
        int nextRank = [GameData sharedGameData].rank11.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 12){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank13.intValue;
        int nextRank = [GameData sharedGameData].rank12.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 13){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank14.intValue;
        int nextRank = [GameData sharedGameData].rank13.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 14){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank15.intValue;
        int nextRank = [GameData sharedGameData].rank14.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 15){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank16.intValue;
        int nextRank = [GameData sharedGameData].rank15.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 16){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank17.intValue;
        int nextRank = [GameData sharedGameData].rank16.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 17){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank18.intValue;
        int nextRank = [GameData sharedGameData].rank17.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 18){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank19.intValue;
        int nextRank = [GameData sharedGameData].rank18.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 19){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank20.intValue;
        int nextRank = [GameData sharedGameData].rank19.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 20){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank21.intValue;
        int nextRank = [GameData sharedGameData].rank20.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 21){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank22.intValue;
        int nextRank = [GameData sharedGameData].rank21.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 22){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank23.intValue;
        int nextRank = [GameData sharedGameData].rank22.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 23){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank24.intValue;
        int nextRank = [GameData sharedGameData].rank23.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    else if (rank == 24){
        int experience = person.experience.intValue;
        int currentRank = [GameData sharedGameData].rank25.intValue;
        int nextRank = [GameData sharedGameData].rank24.intValue;
        int currentRankExp = experience - nextRank;
        float preTemp = (float)currentRankExp/(float)currentRank *100;
        _progress.percentage=preTemp;
    }
    _progress.positionType = CCPositionTypeNormalized;
    _progress.position = ccp(.2f,.65f);
    [self addChild:_progress];
    
    
}

- (void)medalsPressed{
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Medals"];
    [GameData sharedGameData].tableID = 1;
    [[CCDirector sharedDirector] pushScene:gameplayScene];
}

-(void)rankPressed{
    [GameData sharedGameData].tableID = 2;
    CCScene *gameplayScene = [CCBReader loadAsScene:@"RankScene"];
    [[CCDirector sharedDirector] pushScene:gameplayScene];
}
-(void)viewUsers{
    [GameData sharedGameData].tableID = 3;
    CCScene *gameplayScene = [CCBReader loadAsScene:@"UsersTable"];
    [[CCDirector sharedDirector] pushScene:gameplayScene];
}
-(void)armoryPressed{
    [[CCDirector sharedDirector]pushScene:[CCBReader loadAsScene:@"Store"]];
}

-(void)addHighScore{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    
    if (error2) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
        
    } else {
        NSString *highScore = [NSString stringWithFormat:@"%@", [person valueForKey:@"highscore"]];
        [scoreLabel setString:highScore];
        NSString *highRound = [NSString stringWithFormat:@"%@", [person valueForKey:@"highround"]];
        [roundLabel setString:highRound];
    }
}


// -----------------------------------------------------------------

@end





