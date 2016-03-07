//
//  Users.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/28/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Users.h"
#import "UsersTable.h"
#import "GameData.h"
#import "AlertView.h"

// -----------------------------------------------------------------

@implementation Users{
    CCButton *createButton;
    CCButton *cancelButton;
}

// -----------------------------------------------------------------

- (instancetype)init
{
    self = [super init];
    NSAssert(self, @"Unable to create class %@", [self class]);
    UsersTable *table = [UsersTable node];
    table.contentSizeType = CCSizeTypeNormalized;
    table.positionType = CCPositionTypeNormalized;
    table.position = ccp(.2f,-0.01f);
    table.contentSize = CGSizeMake(1, 1);
    table.zOrder = 1000;
    [self addChild:table];
    
    return self;
}
-(void)createUser{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entity1];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name != %@", currentUser];
    [request1 setPredicate:predicate1];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request1 setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    NSError *error = nil;
    NSUInteger count = [[GameData sharedGameData].managedObjectContext countForFetchRequest:request1 error:&error];
    CCLOG(@"count:%d",(int)count);
    
    if (count + 1 <= 10){
        [GameData sharedGameData].tableID = 3;
        CCScene *gameplayScene = [CCBReader loadAsScene:@"SignIn"];
        [[CCDirector sharedDirector] pushScene:gameplayScene];
    }
    else{
        cancelButton.enabled = false;
        createButton.enabled = false;
        self.userInteractionEnabled = false;
        id block = ^(void){
            cancelButton.enabled = true;
            createButton.enabled = true;
            self.userInteractionEnabled = true;
        };
        [AlertView ShowAlert:@"You may only create 11 users. Play as an existing user or delete unnecessary users." onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
    }
}
-(void)backPressed{
    [[CCDirector sharedDirector] popScene];
}


// -----------------------------------------------------------------

@end





