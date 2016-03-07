//
//  UsersTable.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/28/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "UsersTable.h"
#import "GameData.h"

// -----------------------------------------------------------------

@implementation UsersTable{
    int ident;
    CCButton *delete1;
    CCButton *name1;
    CCButton *delete2;
    CCButton *name2;
    CCButton *delete3;
    CCButton *name3;
    CCButton *delete4;
    CCButton *name4;
    CCButton *delete5;
    CCButton *name5;
    CCButton *delete6;
    CCButton *name6;
    CCButton *delete7;
    CCButton *name7;
    CCButton *delete8;
    CCButton *name8;
    CCButton *delete9;
    CCButton *name9;
    CCButton *delete10;
    CCButton *name10;
    
    int _rowHeight;
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
    CCTableView* table = [CCTableView node];
    table.multipleTouchEnabled = true;
    table.dataSource = self; // make our class the data source
    table.block = ^(CCTableView* table) {
        //NSLog(@"Cell %d was pressed", (int) table.selectedRow);
        ident = (int)table.selectedRow;
        //CCLOG(@"IDENT = %d", ident);
        [self choose:(int)table.selectedRow];
    };
    [self addChild:table];
    
    return self;
}


- (CCTableViewCell*) tableView:(CCTableView*)tableView nodeForRowAtIndex:(NSUInteger) index
{
    CCTableViewCell* cell = [CCTableViewCell node];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entity1];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name != %@", currentUser];
    [request1 setPredicate:predicate1];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request1 setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    NSError *error = nil;
    NSUInteger count = [[GameData sharedGameData].managedObjectContext countForFetchRequest:request1 error:&error];
        if (index == 1){
            if(count >=(NSUInteger)1){
            Person *person11 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:0];
                if (person11.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person11.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person11.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypePoints;
            //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
            lbl.position = ccp(50.f,20.f);
            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
            
            delete1 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
            delete1.positionType = CCPositionTypePoints;
            delete1.opacity = 100.f;
            delete1.visible = false;
            delete1.position = ccp(385.f,20.f);
            [cell addChild:delete1];
            
            name1 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
            name1.positionType = CCPositionTypePoints;
            name1.opacity = 100.f;
            name1.visible = false;
            name1.position = ccp(310.f,20.f);
            [cell addChild:name1];
            }
        }
        else if (index == 2){
            if(count >=(NSUInteger)2){
            Person *person2 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:1];
                
                if (person2.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person2.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person2.name]fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypePoints;
            //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
            lbl.position = ccp(50.f,20.f);

            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
            
            delete2 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
            delete2.positionType = CCPositionTypePoints;
            delete2.opacity = 100.f;
            delete2.visible = false;
            delete2.position = ccp(385.f,20.f);
            [cell addChild:delete2];
            
            name2 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
            name2.positionType = CCPositionTypePoints;
            name2.opacity = 100.f;
            name2.visible = false;
            name2.position = ccp(310.f,20.f);
            [cell addChild:name2];
            }
        }
        else if (index == 3){
            if(count >=(NSUInteger)3){
            Person *person3 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:2];
                
                if (person3.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person3.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person3.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypePoints;
            //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
            lbl.position = ccp(50.f,20.f);

            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
                
                delete3 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
                delete3.positionType = CCPositionTypePoints;
                delete3.opacity = 100.f;
                delete3.visible = false;
                delete3.position = ccp(385.f,20.f);
                [cell addChild:delete3];
                
                name3 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
                name3.positionType = CCPositionTypePoints;
                name3.opacity = 100.f;
                name3.visible = false;
                name3.position = ccp(310.f,20.f);
                [cell addChild:name3];
            }
        }
        else if (index == 4){
            if(count >=(NSUInteger)4){
            Person *person4 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:3];
                
                
                if (person4.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person4.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }

                
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person4.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypePoints;
            //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
            lbl.position = ccp(50.f,20.f);

            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
                
                delete4 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
                delete4.positionType = CCPositionTypePoints;
                delete4.opacity = 100.f;
                delete4.visible = false;
                delete4.position = ccp(385.f,20.f);
                [cell addChild:delete4];
                
                name4 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
                name4.positionType = CCPositionTypePoints;
                name4.opacity = 100.f;
                name4.visible = false;
                name4.position = ccp(310.f,20.f);
                [cell addChild:name4];
            }
        }
        else if (index == 5){
            if(count >=(NSUInteger)5){
            Person *person5 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:4];
                
                
                if (person5.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person5.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }

            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person5.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypePoints;
            //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
            lbl.position = ccp(50.f,20.f);

            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
                
                delete5 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
                delete5.positionType = CCPositionTypePoints;
                delete5.opacity = 100.f;
                delete5.visible = false;
                delete5.position = ccp(385.f,20.f);
                [cell addChild:delete5];
                
                name5 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
                name5.positionType = CCPositionTypePoints;
                name5.opacity = 100.f;
                name5.visible = false;
                name5.position = ccp(310.f,20.f);
                [cell addChild:name5];
            }
        }
        else if (index == 6){
            if(count >=(NSUInteger)6){
            Person *person6 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:5];
                
                if (person6.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person6.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person6.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypePoints;
            //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
            lbl.position = ccp(50.f,20.f);

            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
                
                delete6 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
                delete6.positionType = CCPositionTypePoints;
                delete6.opacity = 100.f;
                delete6.visible = false;
                delete6.position = ccp(385.f,20.f);
                [cell addChild:delete6];
                
                name6 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
                name6.positionType = CCPositionTypePoints;
                name6.opacity = 100.f;
                name6.visible = false;
                name6.position = ccp(310.f,20.f);
                [cell addChild:name6];
            }
        }
        else if (index == 7){
            if(count >=(NSUInteger)7){
            Person *person7 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:6];
                
                if (person7.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person7.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person7.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypePoints;
            //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
            lbl.position = ccp(50.f,20.f);

            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
                
                delete7 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
                delete7.positionType = CCPositionTypePoints;
                delete7.opacity = 100.f;
                delete7.visible = false;
                delete7.position = ccp(385.f,20.f);
                [cell addChild:delete7];
                
                name7 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
                name7.positionType = CCPositionTypePoints;
                name7.opacity = 100.f;
                name7.visible = false;
                name7.position = ccp(310.f,20.f);
                [cell addChild:name7];
            }
        }
        else if (index == 8){
            if(count >=(NSUInteger)8){
                Person *person8 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:7];
                
                if (person8.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person8.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person8.name] fontName:@"HelveticaNeue" fontSize:32];
                lbl.positionType = CCPositionTypePoints;
                //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
                lbl.position = ccp(50.f,20.f);
                
                cell.contentSize = lbl.contentSize;
                [cell addChild:lbl];
                
                delete8 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
                delete8.positionType = CCPositionTypePoints;
                delete8.opacity = 100.f;
                delete8.visible = false;
                delete8.position = ccp(385.f,20.f);
                [cell addChild:delete8];
                
                name8 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
                name8.positionType = CCPositionTypePoints;
                name8.opacity = 100.f;
                name8.visible = false;
                name8.position = ccp(310.f,20.f);
                [cell addChild:name8];
            }
        }
        else if (index == 9){
            if(count >=(NSUInteger)9){
                Person *person9 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:8];
                
                if (person9.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person9.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person9.name] fontName:@"HelveticaNeue" fontSize:32];
                lbl.positionType = CCPositionTypePoints;
                //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
                lbl.position = ccp(50.f,20.f);
                
                cell.contentSize = lbl.contentSize;
                [cell addChild:lbl];
                
                delete9 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
                delete9.positionType = CCPositionTypePoints;
                delete9.opacity = 100.f;
                delete9.visible = false;
                delete9.position = ccp(385.f,20.f);
                [cell addChild:delete9];
                
                name9 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
                name9.positionType = CCPositionTypePoints;
                name9.opacity = 100.f;
                name9.visible = false;
                name9.position = ccp(310.f,20.f);
                [cell addChild:name9];
            }
        }
        else if (index == 10){
            if(count >=(NSUInteger)10){
                Person *person10 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:9];
                
                if (person10.rank.intValue == 0){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 1){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 2){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 3){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 4){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 5){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 6){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 7){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 8){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 9){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 10){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 11){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 12){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_Fisrt Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 13){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 14){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 15){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 16){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 17){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 18){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 19){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 20){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 21){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 22){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 23){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                else if (person10.rank.intValue == 24){
                    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
                    icon.anchorPoint = CGPointZero;
                    icon.scale = .5f;
                    cell.contentSize = icon.contentSize;
                    _rowHeight = cell.contentSize.height;
                    [cell addChild:icon];
                }
                CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person10.name] fontName:@"HelveticaNeue" fontSize:32];
                lbl.positionType = CCPositionTypePoints;
                //lbl.position = ccp(70, 20);
                lbl.anchorPoint = ccp(0,.5f);
                lbl.position = ccp(50.f,20.f);
                
                cell.contentSize = lbl.contentSize;
                [cell addChild:lbl];
                
                delete10 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/delete.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/deletePressed.png"] disabledSpriteFrame:nil];
                delete10.positionType = CCPositionTypePoints;
                delete10.opacity = 100.f;
                delete10.visible = false;
                delete10.position = ccp(385.f,20.f);
                [cell addChild:delete10];
                
                name10 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
                name10.positionType = CCPositionTypePoints;
                name10.opacity = 100.f;
                name10.visible = false;
                name10.position = ccp(310.f,20.f);
                [cell addChild:name10];
            }
        }
    return cell;
}
-(void)choose:(int)number{
    if(number == 1){
        ident = 1;
        //CCLOG(@"Row 1 chosen");
        [delete1 setTarget:self selector:@selector(deleteUser)];
        CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        [delete1 runAction:fade];
        [name1 setTarget:self selector:@selector(chooseUser)];
        name1.visible = true;
        delete1.visible = true;
        name2.visible = false;
        delete2.visible = false;
        delete3.visible = false;
        name3.visible = false;
        delete4.visible = false;
        name4.visible = false;
        delete5.visible = false;
        name5.visible = false;
        delete6.visible = false;
        name6.visible = false;
        delete7.visible = false;
        name7.visible = false;
        delete8.visible = false;
        name8.visible = false;
        delete9.visible = false;
        name9.visible = false;
        delete10.visible = false;
        name10.visible = false;
    }
    else if(number == 2){
        //CCLOG(@"Row 2 chosen");
        ident = 2;
        [delete2 setTarget:self selector:@selector(deleteUser)];
        [name2 setTarget:self selector:@selector(chooseUser)];
        //CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        //[delete1 runAction:fade];
        delete1.visible = false;
        name1.visible = false;
        delete2.visible = true;
        name2.visible = true;
        delete3.visible = false;
        name3.visible = false;
        delete4.visible = false;
        name4.visible = false;
        delete5.visible = false;
        name5.visible = false;
        delete6.visible = false;
        name6.visible = false;
        delete7.visible = false;
        name7.visible = false;
        delete8.visible = false;
        name8.visible = false;
        delete9.visible = false;
        name9.visible = false;
        delete10.visible = false;
        name10.visible = false;
    }
    else if(number == 3){
        //CCLOG(@"Row 2 chosen");
        ident = 3;
        [delete3 setTarget:self selector:@selector(deleteUser)];
        [name3 setTarget:self selector:@selector(chooseUser)];
        //CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        //[delete1 runAction:fade];
        delete1.visible = false;
        name1.visible = false;
        delete2.visible = false;
        name2.visible = false;
        delete3.visible = true;
        name3.visible = true;
        delete4.visible = false;
        name4.visible = false;
        delete5.visible = false;
        name5.visible = false;
        delete6.visible = false;
        name6.visible = false;
        delete7.visible = false;
        name7.visible = false;
        delete8.visible = false;
        name8.visible = false;
        delete9.visible = false;
        name9.visible = false;
        delete10.visible = false;
        name10.visible = false;
    }
    else if(number == 4){
        //CCLOG(@"Row 2 chosen");
        ident = 4;
        [delete4 setTarget:self selector:@selector(deleteUser)];
        [name4 setTarget:self selector:@selector(chooseUser)];
        //CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        //[delete1 runAction:fade];
        delete1.visible = false;
        name1.visible = false;
        delete2.visible = false;
        name2.visible = false;
        delete3.visible = false;
        name3.visible = false;
        delete4.visible = true;
        name4.visible = true;
        delete5.visible = false;
        name5.visible = false;
        delete6.visible = false;
        name6.visible = false;
        delete7.visible = false;
        name7.visible = false;
        delete8.visible = false;
        name8.visible = false;
        delete9.visible = false;
        name9.visible = false;
        delete10.visible = false;
        name10.visible = false;
    }
    else if(number == 5){
        //CCLOG(@"Row 2 chosen");
        ident = 5;
        [delete5 setTarget:self selector:@selector(deleteUser)];
        [name5 setTarget:self selector:@selector(chooseUser)];
        //CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        //[delete1 runAction:fade];
        delete1.visible = false;
        name1.visible = false;
        delete2.visible = false;
        name2.visible = false;
        delete3.visible = false;
        name3.visible = false;
        delete4.visible = false;
        name4.visible = false;
        delete5.visible = true;
        name5.visible = true;
        delete6.visible = false;
        name6.visible = false;
        delete7.visible = false;
        name7.visible = false;
        delete8.visible = false;
        name8.visible = false;
        delete9.visible = false;
        name9.visible = false;
        delete10.visible = false;
        name10.visible = false;
    }
    else if(number == 6){
        //CCLOG(@"Row 2 chosen");
        ident = 6;
        [delete6 setTarget:self selector:@selector(deleteUser)];
        [name6 setTarget:self selector:@selector(chooseUser)];
        //CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        //[delete1 runAction:fade];
        delete1.visible = false;
        name1.visible = false;
        delete2.visible = false;
        name2.visible = false;
        delete3.visible = false;
        name3.visible = false;
        delete4.visible = false;
        name4.visible = false;
        delete5.visible = false;
        name5.visible = false;
        delete6.visible = true;
        name6.visible = true;
        delete7.visible = false;
        name7.visible = false;
        delete8.visible = false;
        name8.visible = false;
        delete9.visible = false;
        name9.visible = false;
        delete10.visible = false;
        name10.visible = false;
    }
    else if(number == 7){
        //CCLOG(@"Row 2 chosen");
        ident = 7;
        [delete7 setTarget:self selector:@selector(deleteUser)];
        [name7 setTarget:self selector:@selector(chooseUser)];
        //CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        //[delete1 runAction:fade];
        delete1.visible = false;
        name1.visible = false;
        delete2.visible = false;
        name2.visible = false;
        delete3.visible = false;
        name3.visible = false;
        delete4.visible = false;
        name4.visible = false;
        delete5.visible = false;
        name5.visible = false;
        delete6.visible = false;
        name6.visible = false;
        delete7.visible = true;
        name7.visible = true;
        delete8.visible = false;
        name8.visible = false;
        delete9.visible = false;
        name9.visible = false;
        delete10.visible = false;
        name10.visible = false;
    }
    else if(number == 8){
        //CCLOG(@"Row 2 chosen");
        ident = 8;
        [delete8 setTarget:self selector:@selector(deleteUser)];
        [name8 setTarget:self selector:@selector(chooseUser)];
        //CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        //[delete1 runAction:fade];
        delete1.visible = false;
        name1.visible = false;
        delete2.visible = false;
        name2.visible = false;
        delete3.visible = false;
        name3.visible = false;
        delete4.visible = false;
        name4.visible = false;
        delete5.visible = false;
        name5.visible = false;
        delete6.visible = false;
        name6.visible = false;
        delete7.visible = false;
        name7.visible = false;
        name8.visible = true;
        delete8.visible = true;
        delete9.visible = false;
        name9.visible = false;
        delete10.visible = false;
        name10.visible = false;
        
    }
    else if(number == 9){
        //CCLOG(@"Row 2 chosen");
        ident = 9;
        [delete9 setTarget:self selector:@selector(deleteUser)];
        [name9 setTarget:self selector:@selector(chooseUser)];
        //CCActionFadeIn *fade = [CCActionFadeIn actionWithDuration:.5f];
        //[delete1 runAction:fade];
        delete1.visible = false;
        name1.visible = false;
        delete2.visible = false;
        name2.visible = false;
        delete3.visible = false;
        name3.visible = false;
        delete4.visible = false;
        name4.visible = false;
        delete5.visible = false;
        name5.visible = false;
        delete6.visible = false;
        name6.visible = false;
        delete7.visible = false;
        name7.visible = false;
        name8.visible = false;
        delete8.visible = false;
        delete9.visible = true;
        name9.visible = true;
        delete10.visible = false;
        name10.visible = false;
    }
    else if(number == 10){
        ident = 10;
        [delete10 setTarget:self selector:@selector(deleteUser)];
        [name10 setTarget:self selector:@selector(chooseUser)];
        delete1.visible = false;
        name1.visible = false;
        delete2.visible = false;
        name2.visible = false;
        delete3.visible = false;
        name3.visible = false;
        delete4.visible = false;
        name4.visible = false;
        delete5.visible = false;
        name5.visible = false;
        delete6.visible = false;
        name6.visible = false;
        delete7.visible = false;
        name7.visible = false;
        name8.visible = false;
        delete8.visible = false;
        delete9.visible = false;
        name9.visible = false;
        delete10.visible = true;
        name10.visible = true;
    }
}

-(void)chooseUser{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entity1];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name != %@", currentUser];
    [request1 setPredicate:predicate1];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request1 setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    NSError *error;
    if(ident == 1){
        CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:0];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
    else if(ident == 2){
       CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:1];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
    else if(ident == 3){
        CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:2];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
    else if(ident == 4){
        CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:3];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
    else if(ident == 5){
        CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:4];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
    else if(ident == 6){
        CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:5];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
    else if(ident == 7){
        CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:6];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
    else if(ident == 8){
        CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:7];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
    else if(ident == 9){
        CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:8];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
    else if(ident == 10){
        CCLOG(@"ident chosen: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:9];
        [[NSUserDefaults standardUserDefaults] setObject:person1.name forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[CCDirector sharedDirector] popScene];
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"HighScores"]];
    }
}

-(void)deleteUser{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entity1];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name != %@", currentUser];
    [request1 setPredicate:predicate1];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request1 setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    NSError *error;
    if(ident == 1){
        CCLOG(@"ident: %d",ident);
        NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                                 stringForKey:@"defaultUser"];
        NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name != %@", currentUser];
        [request1 setPredicate:predicate1];
        NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
        [request1 setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:0];

        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    else if(ident == 2){
        CCLOG(@"ident: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:1];
        
        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        //[self removeChildByName:[NSString stringWithFormat:@"2"]];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    else if(ident == 3){
        CCLOG(@"ident: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:2];
        
        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        //[self removeChildByName:[NSString stringWithFormat:@"2"]];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    else if(ident == 4){
        CCLOG(@"ident: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:3];
        
        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        //[self removeChildByName:[NSString stringWithFormat:@"2"]];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    else if(ident == 5){
        CCLOG(@"ident: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:4];
        
        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        //[self removeChildByName:[NSString stringWithFormat:@"2"]];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    else if(ident == 6){
        CCLOG(@"ident: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:5];
        
        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        //[self removeChildByName:[NSString stringWithFormat:@"2"]];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    else if(ident == 7){
        CCLOG(@"ident: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:6];
        
        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        //[self removeChildByName:[NSString stringWithFormat:@"2"]];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    else if(ident == 8){
        CCLOG(@"ident: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:7];
        
        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        //[self removeChildByName:[NSString stringWithFormat:@"2"]];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    else if(ident == 9){
        CCLOG(@"ident: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:8];
        
        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        //[self removeChildByName:[NSString stringWithFormat:@"2"]];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    else if(ident == 10){
        CCLOG(@"ident: %d",ident);
        Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error] objectAtIndex:9];
        
        [[GameData sharedGameData].managedObjectContext deleteObject:person1];
        //[self removeChildByName:[NSString stringWithFormat:@"2"]];
        [[CCDirector sharedDirector]replaceScene:[CCBReader loadAsScene:@"UsersTable"]];
        CCLOG(@"DELETE PERMANENTLY!!!!!!!");
    }
    
}

-(float) tableView:(CCTableView*)tableView heightForRowAtIndex:(NSUInteger)index {
    return 60;
}

- (NSUInteger) tableViewNumberOfRows:(CCTableView*) tableView
{
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entity1];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate1 = [NSPredicate predicateWithFormat:@"name != %@", currentUser];
    [request1 setPredicate:predicate1];
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request1 setSortDescriptors:[NSArray arrayWithObjects:sort, nil]];
    NSError *error = nil;
    NSUInteger count = [[GameData sharedGameData].managedObjectContext countForFetchRequest:request1 error:&error];
    CCLOG(@"count:%d",(int)count);
    return (int)count + 2;
}

// -----------------------------------------------------------------

@end





