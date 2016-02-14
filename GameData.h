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
@property (assign, nonatomic) int round;
@property (assign, nonatomic) long score;
@property(assign, nonatomic) int rank;
@property (assign, nonatomic) long doubleKills;
@property (assign, nonatomic) NSMutableArray *hiScores;

@property (assign, nonatomic) int bombCount;
@property (assign,nonatomic) int bladeCount;

@property (assign, nonatomic) int tableID;
@property (assign, nonatomic) bool newPlayerFlag;

@property (retain,nonatomic,readonly) NSManagedObjectModel *managedObjectModel;
@property (retain,nonatomic,readonly) NSManagedObjectContext *managedObjectContext;
@property (retain,nonatomic,readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;


@property (retain, nonatomic) NSNumber* rank1;
@property (retain, nonatomic) NSNumber *rank2;
@property (retain, nonatomic) NSNumber *rank3;
@property (retain, nonatomic) NSNumber *rank4;
@property (retain, nonatomic) NSNumber *rank5;
@property (retain, nonatomic) NSNumber *rank6;
@property (retain, nonatomic) NSNumber *rank7;
@property (retain, nonatomic) NSNumber *rank8;
@property (retain, nonatomic) NSNumber *rank9;
@property (retain, nonatomic) NSNumber *rank10;
@property (retain, nonatomic) NSNumber *rank11;
@property (retain, nonatomic) NSNumber *rank12;
@property (retain, nonatomic) NSNumber *rank13;
@property (retain, nonatomic) NSNumber *rank14;
@property (retain, nonatomic) NSNumber *rank15;
@property (retain, nonatomic) NSNumber *rank16;
@property (retain, nonatomic) NSNumber *rank17;
@property (retain, nonatomic) NSNumber *rank18;
@property (retain, nonatomic) NSNumber *rank19;
@property (retain, nonatomic) NSNumber *rank20;
@property (retain, nonatomic) NSNumber *rank21;
@property (retain, nonatomic) NSNumber *rank22;
@property (retain, nonatomic) NSNumber *rank23;
@property (retain, nonatomic) NSNumber *rank24;
@property (retain, nonatomic) NSNumber *rank25;

@property (nonatomic) int seq1;
@property (nonatomic) int seq2;
@property (nonatomic) int seq3;
@property (nonatomic) int seq4;

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




