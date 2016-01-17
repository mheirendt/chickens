//
//  GameData.h
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/11/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "UIKit/UIKit.h"
#import "Person.h"

// -----------------------------------------------------------------

@interface GameData : CCNode <NSFetchedResultsControllerDelegate>
{
    
    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    
}
// -----------------------------------------------------------------
// properties

@property (assign, nonatomic) long highScore;
@property (assign, nonatomic) long score;
@property(assign, nonatomic) int rank;
@property (assign, nonatomic) long doubleKills;
@property (assign, nonatomic) NSMutableArray *hiScores;


@property (retain,nonatomic,readonly) NSManagedObjectModel *managedObjectModel;
@property (retain,nonatomic,readonly) NSManagedObjectContext *managedObjectContext;
@property (retain,nonatomic,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

// -----------------------------------------------------------------
// methods

+ (instancetype)node;
- (instancetype)init;
+(instancetype)sharedGameData;
-(void)reset;
-(void)summarizeRank:(CCLabelTTF *)rank andUser:(CCLabelTTF*) user andRankIcon:(CCSprite*)icon;

-(void)addUser;
-(void)summarizeUser;
-(void)initializeUsers;
// -----------------------------------------------------------------

@end




