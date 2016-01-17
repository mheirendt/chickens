//
//  GameData.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/11/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "GameData.h"

// -----------------------------------------------------------------

@implementation GameData{
    NSString *currentPlayerName;
    int hiScore;
    int currentScore;
    CCSprite *darkSprite;
    
}
@synthesize hiScores;
@synthesize rank = _rank;
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
-(void)reset
{
    self.score = 0;
}
-(void)summarizeRank:(CCLabelTTF *)rank andUser:(CCLabelTTF*) user andRankIcon:(CCSprite*)icon{
    user.positionType = CCPositionTypeNormalized;
    user.anchorPoint = ccp(0,1);
    user.position = ccp(.2f,.8f);
    
    rank.positionType = CCPositionTypeNormalized;
    rank.anchorPoint = ccp(0,1);
    rank.position = ccp(.2f,.73f);
    
    icon.positionType = CCPositionTypeNormalized;
    icon.anchorPoint = ccp(.5f,1);
    icon.position=(ccp(.1f,.81f));
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    [user setString:person.name];
    if([person.rank  isEqual:@24]){
        [rank setString:@"Five Star General"];
        CCSpriteFrame *sprite = [CCSpriteFrame frameWithImageNamed:@"Rank/X_5 Star General.png"];
        [icon setSpriteFrame:sprite];
    }
    

}




/*
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *) managedObjectContext {
    //Return the managedObjectContext if it already exists
    if (managedObjectContext != nil) {
        return managedObjectContext;
    }
    
    //Init the managedObjectContext
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext = [[NSManagedObjectContext alloc] init];
        [managedObjectContext setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}

/*
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created by merging all of the models found in the application bundle.
 */
- (NSManagedObjectModel *)managedObjectModel {
    //Return the managedObjectModel if it already exists
    if (managedObjectModel != nil) {
        return managedObjectModel;
    }
    
    //Init the managedObjectModel
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return managedObjectModel;
}

/*
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    //Return the persistentStoreCoordinator if it already exists
    if (persistentStoreCoordinator != nil) {
        return persistentStoreCoordinator;
    }
    
    //Our file name
    NSString *fileName = @"Crush.sqlite";
    
    //We get our file path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSURL *filePathURL = [NSURL fileURLWithPath:filePath];
    
    //Init the persistentStoreCoordinator
    persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:filePathURL options:nil error:nil];
    
    return persistentStoreCoordinator;
}

-(void)addUser{
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    NSManagedObject *newPerson = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
    [newPerson setValue:@"mikey7896" forKey:@"name"];
    [newPerson setValue:@8143 forKey:@"highscore"];
    
    NSError *error = nil;
    
    if (![newPerson.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
}
-(void) initializeUsers{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error2 = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error2];
    
    if (result.count == 0) {
        CCScene *signIn = [CCBReader loadAsScene:@"SignIn"];
        [[CCDirector sharedDirector] replaceScene:signIn];
    }

}
-(void)summarizeUser{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error2 = nil;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error2];
    
    if (error2) {
        NSLog(@"Unable to execute fetch request.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
        
    } else {
        NSLog(@"%@", result);
    }
    if (result.count > 0) {
        NSManagedObject *person = (NSManagedObject *)[result objectAtIndex:0];
        NSLog(@"1 - %@", person);
        
        NSLog(@"%@ %@", [person valueForKey:@"name"], [person valueForKey:@"highscore"]);
        
        NSLog(@"2 - %@", person);
    }
}

/*
-(void) addHiScoresToMenu {
    for(id score in hiScores){
        Hiscore *hiscore = (Hiscore*)score;
        NSString *scoreStr = [NSString stringWithFormat:@"%@: %i", hiscore.name, [hiscore.score intValue]];
        //[hiScoresMenu addChild:[CCMenuItemFont itemFromString:scoreStr]];
        NSLog(@"%@", scoreStr);
        
    }
}
 */
/*
 
-(void) loadHiScores {
    //Initialization
    managedObjectContext = self.managedObjectContext;
    NSLog(@"button pressed");
    //Attempt to create SQLite database
    NSEntityDescription *entity;
    @try{
        //Define our table/entity to use
        entity = [NSEntityDescription entityForName:@"Hiscore" inManagedObjectContext:managedObjectContext];
 */
    /*
    }@catch (NSException *exception){
        NSLog(@"Caught %@: %@", [exception name], [exception reason]);
        
        //Copy SQLite template because creation failed
        NSString *fileName = @"Crush.sqlite";
        NSString *templateName = @"Crush_template.sqlite";
        
        //File paths
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
        
        if(![[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            //If file doesn't exist in document directory create a new one from the template
            //getActualPath(templateName)
            [[NSFileManager defaultManager] copyItemAtPath:templateName
                                                    toPath:[NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName] error:nil];
        }
        
        //Finally define our table/entity to use
        entity = [NSEntityDescription entityForName:@"Hiscore" inManagedObjectContext:managedObjectContext];
    }
    
    //Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    //Define how we will sort the records with a descriptor
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"score" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    [request setSortDescriptors:sortDescriptors];
     */
    /*
    //Init hiScores
    hiScores = [[managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    
    //Add an intial score if necessary
    if(hiScores.count < 1){
        NSLog(@"Putting in initial hi score");
        currentScore = 0;
        currentPlayerName = @"Player1";
        //unrecognized selector sent to self
        [self addHiScore];
        //[[GameData sharedGameData] addHiScore];
        
        hiScores = [[managedObjectContext executeFetchRequest:request error:nil] mutableCopy];
    }
    
    //Set the hi score
    Hiscore *highest = [hiScores objectAtIndex:0];
    hiScore = [highest.score intValue];
}

-(void) addHiScore {
    bool hasScore = NO;
    
    //Add score if player's name already exists
    for(id score in hiScores){
        Hiscore *hiscore = (Hiscore*)score;
        if([hiscore.name isEqualToString:currentPlayerName]){
            hasScore = YES;
            if(currentScore > [hiscore.score intValue]){
                hiscore.score = [NSNumber numberWithInt:currentScore];
            }
        }
    }
    
    //Add new score if player's name doesn't exist
    if(!hasScore){
        Hiscore *hiscoreObj = (Hiscore *)[NSEntityDescription insertNewObjectForEntityForName:@"Hiscore" inManagedObjectContext:managedObjectContext];
        [hiscoreObj setName:currentPlayerName];
        [hiscoreObj setScore:[NSNumber numberWithInt:currentScore]];
        [hiScores addObject:hiscoreObj];
    }
    
    //Save managedObjectContext
    [managedObjectContext save:nil];
}

-(void) viewHiScores {
    [self loadHiScores];
    
}

-(void) deleteHiScores {
    //Delete all Hi Score objects
    NSFetchRequest * allHiScores = [[NSFetchRequest alloc] init];
    [allHiScores setEntity:[NSEntityDescription entityForName:@"Hiscore" inManagedObjectContext:managedObjectContext]];
    [allHiScores setIncludesPropertyValues:NO]; //only fetch the managedObjectID
    
    NSArray * hs = [managedObjectContext executeFetchRequest:allHiScores error:nil];
    for (NSManagedObject *h in hs) {
        [managedObjectContext deleteObject:h];
    }
    
    //Our file name
    NSString *fileName = @"memory.sqlite";
    
    //We get our file path
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    //Delete our file
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    
    //[message setString:@"Hi scores deleted!"];
    CCLOG(@"All Scores Deleted");
    
    hiScore = 0;
    [hiScores removeAllObjects];
    hiScores = nil;
    
    //Finally, load clean hi scores
    [self loadHiScores];
}

*/

@end

