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

    // class initalization goes here
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
    //[_scoreLabel setString:[NSString stringWithFormat:@"%li", [GameData sharedGameData].score]];
    NSString *doubles = [NSString stringWithFormat:@"%li", [GameData sharedGameData].score];
    CCLabelTTF* count = [CCLabelTTF labelWithString:doubles fontName:@"HelveticaNeue" fontSize:30];
    count.positionType = CCPositionTypeNormalized;
    count.position = ccp(.5f,.4f);
    [self addChild:count];
    
    userName.positionType = CCPositionTypeNormalized;
    userName.anchorPoint = ccp(0,1);
    userName.position = ccp(.2f,.8f);
    
    rankLabel.positionType = CCPositionTypeNormalized;
    rankLabel.anchorPoint = ccp(0,1);
    rankLabel.position = ccp(.2f,.73f);
    
    rankIcon.positionType = CCPositionTypeNormalized;
    rankIcon.anchorPoint = ccp(.5f,1);
    rankIcon.position=(ccp(.1f,.81f));
    
    [GameData sharedGameData].highScore = MAX([GameData sharedGameData].score,
                                                [GameData sharedGameData].highScore);
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    NSNumber *highScore = [NSNumber numberWithLong:[GameData sharedGameData].score];
    NSNumber *expSum = [NSNumber numberWithLong:(person.experience.intValue + [GameData sharedGameData].score)];
    [person setValue:expSum forKey:@"experience"];
    
    [userName setString:person.name];
    
    
    [self assignRank];
    
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }

    CCLOG(@"%i",expSum.intValue);
    if(highScore > person.highscore){
        [person setValue:highScore forKey:@"highscore"];
        //[person.managedObjectContext save:&error2];
        if (![person.managedObjectContext save:&error2]) {
            NSLog(@"Unable to save managed object context.");
            NSLog(@"%@, %@", error2, error2.localizedDescription);
        }
    
        [self addHighScore];
    }
}
-(void)addHighScore{

    // Retrieve the entity from the local store -- much like a table in a database
    }

-(void)retryPressed{
    [[GameData sharedGameData] reset];
    [[CCDirector sharedDirector] popScene];
    CCScene *game = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] pushScene:game];
}
-(void)backPressed{
    [[GameData sharedGameData] reset];
    [[CCDirector sharedDirector] popScene];
    //[[CCDirector sharedDirector] popScene];
    //CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    //[[CCDirector sharedDirector] pushScene:MainScene];
}
-(void) assignRank{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    NSNumber *rank1 = [NSNumber numberWithInt:5];
    NSNumber *rank2 = [NSNumber numberWithInt:10];
    NSNumber *rank3 = [NSNumber numberWithInt:15];
    NSNumber *rank4 = [NSNumber numberWithInt:20];
    NSNumber *rank5 = [NSNumber numberWithInt:25];
    NSNumber *rank6 = [NSNumber numberWithInt:30];
    NSNumber *rank7 = [NSNumber numberWithInt:35];
    NSNumber *rank8 = [NSNumber numberWithInt:40];
    NSNumber *rank9 = [NSNumber numberWithInt:45];
    NSNumber *rank10 = [NSNumber numberWithInt:50];
    NSNumber *rank11 = [NSNumber numberWithInt:55];
    NSNumber *rank12 = [NSNumber numberWithInt:60];
    NSNumber *rank13 = [NSNumber numberWithInt:65];
    NSNumber *rank14 = [NSNumber numberWithInt:70];
    NSNumber *rank15 = [NSNumber numberWithInt:75];
    NSNumber *rank16 = [NSNumber numberWithInt:80];
    NSNumber *rank17 = [NSNumber numberWithInt:95];
    NSNumber *rank18 = [NSNumber numberWithInt:100];
    NSNumber *rank19 = [NSNumber numberWithInt:105];
    NSNumber *rank20 = [NSNumber numberWithInt:110];
    NSNumber *rank21 = [NSNumber numberWithInt:115];
    NSNumber *rank22 = [NSNumber numberWithInt:120];
    NSNumber *rank23 = [NSNumber numberWithInt:125];
    NSNumber *rank24 = [NSNumber numberWithInt:130];
    NSNumber *rank25 = [NSNumber numberWithInt:135];
    if(person.experience<rank1){
        CCSpriteFrame *recruit = [CCSpriteFrame frameWithImageNamed:@"Rank/a_Recruit.png"];
        [rankIcon setSpriteFrame:recruit];
        [rankLabel setString:@"Recruit"];
    }
    else if(person.experience>=rank1 && person.experience<rank2){
        person.rank = [NSNumber numberWithInt:1];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/aa_Private.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Private"];
        
    }
    else if(person.experience>=rank2 && person.experience<rank3){
        person.rank = [NSNumber numberWithInt:2];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/b_Private First Class.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Private First Class"];
        
    }
    else if(person.experience>=rank3 && person.experience<rank4){
        person.rank = [NSNumber numberWithInt:3];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/c_Private Second Class.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Private Second Class"];
        
    }
    else if(person.experience>=rank4 && person.experience<rank5){
        person.rank = [NSNumber numberWithInt:4];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/d_Lance Corporal.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Lance Corporal"];
        
    }
    else if(person.experience>=rank5 && person.experience<rank6){
        person.rank = [NSNumber numberWithInt:5];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/e_Corporal.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Corporal"];
        
    }
    else if(person.experience>=rank6 && person.experience<rank7){
        person.rank = [NSNumber numberWithInt:6];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/f_Sergeant.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Sergeant"];
        
    }
    else if(person.experience>=rank7  && person.experience<rank8){
        person.rank = [NSNumber numberWithInt:7];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/g_Staff Sergeant.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Staff Sergeant"];
        
    }
    else if(person.experience>=rank8  && person.experience<rank9){
        person.rank = [NSNumber numberWithInt:8];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Gunnery Sergeant"];
        
    }
    else if(person.experience>=rank9  && person.experience<rank10){
        person.rank = [NSNumber numberWithInt:9];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/i_Master Sergeant.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Master Sergeant"];
        
    }
    else if(person.experience>=rank10  && person.experience<rank11){
        person.rank = [NSNumber numberWithInt:10];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/j_First Sergeant.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"First Sergeant"];
        
    }
    else if(person.experience>=rank11 && person.experience<rank12){
        person.rank = [NSNumber numberWithInt:11];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/k_Leutenant.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Leutenant"];
        
    }
    else if(person.experience>=rank12 && person.experience<rank13){
        person.rank = [NSNumber numberWithInt:12];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/l_First Leutenant.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"First Leutenant"];
        
    }
    else if(person.experience>=rank13  && person.experience<rank14){
        person.rank = [NSNumber numberWithInt:13];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/m_Second Leutenant.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Second Leutenant"];
        
    }
    else if(person.experience>=rank14  && person.experience<rank15){
        person.rank = [NSNumber numberWithInt:14];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/n_Captain.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Captain"];
        
    }
    else if(person.experience>=rank15 && person.experience<rank16){
        person.rank = [NSNumber numberWithInt:15];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/o_Staff Captain.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Staff Captain"];
        
    }
    else if(person.experience>=rank16 && person.experience<rank17){
        person.rank = [NSNumber numberWithInt:16];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Leutenant Colonel"];
    }
    else if(person.experience>=rank17  && person.experience<rank18){
        person.rank = [NSNumber numberWithInt:17];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/q_Colonel.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Colonel"];
        
    }
    else if(person.experience>=rank18  && person.experience<rank19){
        person.rank = [NSNumber numberWithInt:18];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/r_Brigadier.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Brigadier"];
        
    }
    else if(person.experience>=rank19 && person.experience<rank20){
        person.rank = [NSNumber numberWithInt:19];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/s_Brigadier General.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Brigadier General"];
        
    }
    else if(person.experience>=rank20 && person.experience<rank21){
        person.rank = [NSNumber numberWithInt:20];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/t_General.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"General"];
        
    }
    else if(person.experience>=rank21  && person.experience<rank22){
        person.rank = [NSNumber numberWithInt:21];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/U_2 Star General.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Two Star General"];
        
    }
    else if(person.experience>=rank22  && person.experience<rank23){
        person.rank = [NSNumber numberWithInt:22];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/V_3 Star General.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Three Star General"];
        
    }
    else if(person.experience>=rank23 && person.experience<rank24){
        person.rank = [NSNumber numberWithInt:23];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/W_4 Star General.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Four Star General"];
        
    }
    else if(person.experience>=rank24 && person.experience<rank25){
        person.rank = [NSNumber numberWithInt:24];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/X_5 Star General.png"];
        [rankIcon setSpriteFrame:private];
        [rankLabel setString:@"Five Star General"];
        
    }
    
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
}

// -----------------------------------------------------------------

@end





