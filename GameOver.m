//
//  GameOver.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/10/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameOver.h"
#import "GameData.h"
#import "SignInScene.h"
// -----------------------------------------------------------------

@implementation GameOver{
    CCLabelTTF *userName;
    CCLabelTTF *rankLabel;
    CCSprite *rankIcon;
    CCSprite *progress;

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
+ (instancetype)sharedGameData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(void) onEnter
{
    [super onEnter];
    NSString *doubles = [NSString stringWithFormat:@"%li", [GameData sharedGameData].score];
    CCLabelTTF* count = [CCLabelTTF labelWithString:doubles fontName:@"HelveticaNeue" fontSize:30];
    count.positionType = CCPositionTypeNormalized;
    count.position = ccp(.5f,.4f);
    [self addChild:count];
    [[GameData sharedGameData]summarizeRank:rankLabel andUser:userName andRankIcon:rankIcon];
    [GameData sharedGameData].highScore = MAX([GameData sharedGameData].score,
                                                [GameData sharedGameData].highScore);
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    int score = [GameData sharedGameData].roundScore;
    score +=person.experience.intValue;
    [person setValue:[NSNumber numberWithInt:score] forKey:@"experience"];
    [GameData sharedGameData].roundScore = 0;
    NSNumber *highScore = [NSNumber numberWithLong:[GameData sharedGameData].score];
    NSNumber *highRound = [NSNumber numberWithInt:[GameData sharedGameData].round];
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
    if(highScore > person.highscore){
        [person setValue:highScore forKey:@"highscore"];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
    }
    if(highRound > person.highround){
        [person setValue:highRound forKey:@"highround"];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
    }
}
-(void)retryPressed{
    [[GameData sharedGameData] reset];
    [[CCDirector sharedDirector] popScene];
    CCScene *game = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] pushScene:game];
    [GameData sharedGameData].bladeCount = 0;
    [GameData sharedGameData].bombCount = 0;
}
-(void)backPressed{
    [[GameData sharedGameData] reset];
    [[CCDirector sharedDirector] popScene];
}

// -----------------------------------------------------------------

@end





