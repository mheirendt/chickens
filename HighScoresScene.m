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

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    [fetchRequest setEntity:entity];
    [[GameData sharedGameData]summarizeRank:_rankLabel andUser:_userName andRankIcon:_rankIcon];
    
    
    
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





