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

@synthesize bombCount;
@synthesize bladeCount;

@synthesize tableID;

@synthesize rank1;
@synthesize rank2;
@synthesize rank3;
@synthesize rank4;
@synthesize rank5;
@synthesize rank6;
@synthesize rank7;
@synthesize rank8;
@synthesize rank9;
@synthesize rank10;
@synthesize rank11;
@synthesize rank12;
@synthesize rank13;
@synthesize rank14;
@synthesize rank15;
@synthesize rank16;
@synthesize rank17;
@synthesize rank18;
@synthesize rank19;
@synthesize rank20;
@synthesize rank21;
@synthesize rank22;
@synthesize rank23;
@synthesize rank24;
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
    self.bombCount = 0;
    self.bladeCount = 0;
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
    icon.scale = .8f;
    icon.position=(ccp(.1f,.81f));
    
  /*
    self.rank1 = [NSNumber numberWithInt:300];
    self.rank2 = [NSNumber numberWithInt:600];
    self.rank3 = [NSNumber numberWithInt:1000];
    self.rank4 = [NSNumber numberWithInt:5000];
    self.rank5 = [NSNumber numberWithInt:10000];
    self.rank6 = [NSNumber numberWithInt:15000];
    self.rank7 = [NSNumber numberWithInt:20000];
    self.rank8 = [NSNumber numberWithInt:25000];
    self.rank9 = [NSNumber numberWithInt:30000];
    self.rank10 = [NSNumber numberWithInt:35000];
    self.rank11 = [NSNumber numberWithInt:40000];
    self.rank12 = [NSNumber numberWithInt:45000];
    self.rank13 = [NSNumber numberWithInt:50000];
    self.rank14 = [NSNumber numberWithInt:60000];
    self.rank15 = [NSNumber numberWithInt:75000];
    self.rank16 = [NSNumber numberWithInt:100000];
    self.rank17 = [NSNumber numberWithInt:150000];
    self.rank18 = [NSNumber numberWithInt:200000];
    self.rank19 = [NSNumber numberWithInt:300000];
    self.rank20 = [NSNumber numberWithInt:500000];
    self.rank21 = [NSNumber numberWithInt:750000];
    self.rank22 = [NSNumber numberWithInt:1000000];
    self.rank23 = [NSNumber numberWithInt:1500000];
    self.rank24 = [NSNumber numberWithInt:2000000];
   */
    self.rank1 = [NSNumber numberWithInt:1];
    self.rank2 = [NSNumber numberWithInt:2];
    self.rank3 = [NSNumber numberWithInt:3];
    self.rank4 = [NSNumber numberWithInt:4];
    self.rank5 = [NSNumber numberWithInt:5];
    self.rank6 = [NSNumber numberWithInt:6];
    self.rank7 = [NSNumber numberWithInt:7];
    self.rank8 = [NSNumber numberWithInt:8];
    self.rank9 = [NSNumber numberWithInt:9];
    self.rank10 = [NSNumber numberWithInt:10];
    self.rank11 = [NSNumber numberWithInt:11];
    self.rank12 = [NSNumber numberWithInt:12];
    self.rank13 = [NSNumber numberWithInt:13];
    self.rank14 = [NSNumber numberWithInt:14];
    self.rank15 = [NSNumber numberWithInt:15];
    self.rank16 = [NSNumber numberWithInt:16];
    self.rank17 = [NSNumber numberWithInt:17];
    self.rank18 = [NSNumber numberWithInt:18];
    self.rank19 = [NSNumber numberWithInt:19];
    self.rank20 = [NSNumber numberWithInt:20];
    self.rank21 = [NSNumber numberWithInt:21];
    self.rank22 = [NSNumber numberWithInt:22];
    self.rank23 = [NSNumber numberWithInt:23];
    self.rank24 = [NSNumber numberWithInt:24];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                            stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    [user setString:person.name];
    if (person.experience<rank1){
        person.rank = [NSNumber numberWithInt:0];
        [rank setString:@"Recruit"];
        CCSpriteFrame *sprite = [CCSpriteFrame frameWithImageNamed:@"Rank/a_Recruit.png"];
        [icon setSpriteFrame:sprite];
    }
    else if(person.experience>=rank1 && person.experience<rank2){
        person.rank = [NSNumber numberWithInt:1];
        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/aa_Private.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Private"];
        
    }
    else if(person.experience>=rank2 && person.experience<rank3){
        person.rank = [NSNumber numberWithInt:2];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/b_Private First Class.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Private First Class"];
        
    }
    else if(person.experience>=rank3 && person.experience<rank4){
        person.rank = [NSNumber numberWithInt:3];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/c_Private Second Class.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Private Second Class"];
        
    }
    else if(person.experience>=rank4 && person.experience<rank5){
        person.rank = [NSNumber numberWithInt:4];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/d_Lance Corporal.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Lance Corporal"];
        
    }
    else if(person.experience>=rank5 && person.experience<rank6){
        person.rank = [NSNumber numberWithInt:5];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/e_Corporal.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Corporal"];
        
    }
    else if(person.experience>=rank6 && person.experience<rank7){
        person.rank = [NSNumber numberWithInt:6];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/f_Sergeant.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Sergeant"];
        
    }
    else if(person.experience>=rank7 && person.experience<rank8){
        person.rank = [NSNumber numberWithInt:7];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/g_Staff Sergeant.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Staff Sergeant"];
        
    }
    else if(person.experience>=rank8 && person.experience<rank9){
        person.rank = [NSNumber numberWithInt:8];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Gunnery Sergeant"];
        
    }
    else if(person.experience>=rank9 && person.experience<rank10){
        person.rank = [NSNumber numberWithInt:9];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/i_Master Sergeant.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Master Sergeant"];
        
    }
    else if(person.experience>=rank10 && person.experience<rank11){
        person.rank = [NSNumber numberWithInt:10];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/j_First Sergeant.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"First Sergeant"];
        
    }
    else if(person.experience>=rank11 && person.experience<rank12){
        person.rank = [NSNumber numberWithInt:11];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/k_Leutenant.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Leutenant"];
        
    }
    else if(person.experience>=rank12 && person.experience<rank13){
        person.rank = [NSNumber numberWithInt:12];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/l_First Leutenant.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"First Leutenant"];
        
    }
    else if(person.experience>=rank13 && person.experience<rank14){
        person.rank = [NSNumber numberWithInt:13];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/m_Second Leutenant.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Second Leutenant"];
        
    }
    else if(person.experience>=rank14 && person.experience<rank15){
        person.rank = [NSNumber numberWithInt:14];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/n_Captain.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Captain"];
        
    }
    else if(person.experience>=rank15 && person.experience<rank16){
        person.rank = [NSNumber numberWithInt:15];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/o_Staff Captain.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Staff Captain"];
        
    }
    else if(person.experience>=rank16 && person.experience<rank17){
        person.rank = [NSNumber numberWithInt:16];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Leutenant Colonel"];
    }
    else if(person.experience>=rank17 && person.experience<rank18){
        person.rank = [NSNumber numberWithInt:17];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/q_Colonel.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Colonel"];
        
    }
    else if(person.experience>=rank18 && person.experience<rank19){
        person.rank = [NSNumber numberWithInt:18];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/r_Brigadier.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Brigadier"];
        
    }
    else if(person.experience>=rank19 && person.experience<rank20){
        person.rank = [NSNumber numberWithInt:19];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/s_Brigadier General.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Brigadier General"];
        
    }
    else if(person.experience>=rank20 && person.experience<rank21){
        person.rank = [NSNumber numberWithInt:20];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/t_General.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"General"];
        
    }
    else if(person.experience>=rank21 && person.experience<rank22){
        person.rank = [NSNumber numberWithInt:21];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/U_2 Star General.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Two Star General"];
        
    }
    else if(person.experience>=rank22 && person.experience<rank23){
        person.rank = [NSNumber numberWithInt:22];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/V_3 Star General.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Three Star General"];
        
    }
    else if(person.experience>=rank23 && person.experience<rank24){
        person.rank = [NSNumber numberWithInt:23];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/W_4 Star General.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Four Star General"];
        
    }
    else if(person.experience>=rank24){
        person.rank = [NSNumber numberWithInt:24];

        CCSpriteFrame *private = [CCSpriteFrame frameWithImageNamed:@"Rank/X_5 Star General.png"];
        [icon setSpriteFrame:private];
        [rank setString:@"Five Star General"];
        
    }
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
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

