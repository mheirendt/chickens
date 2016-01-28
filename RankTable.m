//
//  RankTable.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/26/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "RankTable.h"
#import "GameData.h"

// -----------------------------------------------------------------

@implementation RankTable{
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
        NSLog(@"Cell %d was pressed", (int) table.selectedRow);
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
    Person *person1 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    
    NSEntityDescription *entity1 = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request1 = [[NSFetchRequest alloc] init];
    [request1 setEntity:entity1];
//amount = 25;
int rank = person1.rank.intValue;
if (index == 1){
    //Rank 0
    CCLOG(@"testing");
    CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/a_Recruit.png"];
    icon.anchorPoint = CGPointZero;
    icon.scale = .5f;
    cell.contentSize = icon.contentSize;
    _rowHeight = cell.contentSize.height;
    [cell addChild:icon];
    
    CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Recruit"] fontName:@"HelveticaNeue" fontSize:18];
    lbl.anchorPoint = CGPointZero;
    lbl.positionType = CCPositionTypeNormalized;
    //lbl.position = ccp(70, 20);
    lbl.position = ccp(.75f,.27f);
    
    [cell addChild:lbl];
    
    CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Recruit"] fontName:@"HelveticaNeue" fontSize:14];
    desc.anchorPoint = CGPointZero;
    desc.positionType = CCPositionTypeNormalized;
    //lbl.position = ccp(70, 20);
    desc.position = ccp(.75f,.07f);
    
    [cell addChild:desc];
    
}
else if (index == 2){
    //Rank 1
    
    if (rank >=1){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Private"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Private"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
        
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        //long diff = person1.experience.intValue-[GameData sharedGameData].score;
        
        int currentRank = [GameData sharedGameData].rank1.intValue;
        //CCLOG(@"diff %li exp: %d", diff, experience);
        float preTemp = (float)experience/(float)currentRank *100;
       // float temp = (float)diff/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 3){
    //Rank 2

    if (rank >=2){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/b_Private First Class.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Private First Class"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Private First Class"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        //long diff = person1.experience.intValue-[GameData sharedGameData].score;
        
        int currentRank = [GameData sharedGameData].rank2.intValue;
        //CCLOG(@"diff %li exp: %d", diff, experience);
        float preTemp = (float)experience/(float)currentRank *100;
        // float temp = (float)diff/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 4){
    //Rank 3
    
    if (rank >=3){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/c_Private Second Class.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Private Second Class"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Private First Class"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        //long diff = person1.experience.intValue-[GameData sharedGameData].score;
        
        int currentRank = [GameData sharedGameData].rank3.intValue;
        //CCLOG(@"diff %li exp: %d", diff, experience);
        float preTemp = (float)experience/(float)currentRank *100;
        // float temp = (float)diff/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 5){
    //Rank 4
    
    if (rank >=4){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/d_Lance Corporal.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Lance Corporal"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Lance Corporal"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank4.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 6){
    //Rank 5
    
    if (rank >=5){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/e_Corporal.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Corporal"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Corporal"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank5.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 7){
    //Rank 6
    
    if (rank >=6){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/f_Sergeant.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Sergeant"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Sergeant"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank6.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 8){
    //Rank 7
    
    if (rank >=7){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/g_Staff Sergeant.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Staff Sergeant"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Staff Sergeant"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank7.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 9){
    //Rank 8
    
    if (rank >=8){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/h_Gunnery Sergeant.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Gunnery Sergeant"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Gunnery Sergeant"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank8.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 10){
    //Rank 9
    
    if (rank >=9){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/i_Master Sergeant.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Master Sergeant"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Master Sergeant"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank9.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 11){
    //Rank 10
    
    if (rank >=10){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/j_First Sergeant.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"First Sergeant"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a First Sergeant"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank10.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 12){
    //Rank 11
    
    if (rank >=11){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/k_Leutenant.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Leutenant"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Leutenant"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank11.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 13){
    //Rank 12
    
    if (rank >=12){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/l_First Leutenant.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"First Leutenant"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a First Leutenant"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank12.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 14){
    //Rank 13
    
    if (rank >=13){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/m_Second Leutenant.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Second Leutenant"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Second Leutenant"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank13.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 15){
    //Rank 14
    
    if (rank >=14){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/n_Captain.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Captain"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Captain"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank14.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 16){
    //Rank 15
    
    if (rank >=15){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/o_Staff Captain.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Staff Captain"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Staff Captain"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank15.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 17){
    //Rank 16
    
    if (rank >=16){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/p_Leutenant Colonel.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Leutenant Colonel"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Leutenant Colonel"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank16.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 18){
    //Rank 17
    
    if (rank >=17){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/q_Colonel.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Colonel"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Colonel"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank17.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 19){
    //Rank 18
    
    if (rank >=18){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/r_Brigadier.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Brigadier"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Brigadier"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank18.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 20){
    //Rank 19
    
    if (rank >=19){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/s_Brigadier General.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Brigadier General"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Brigadier General"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank19.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 21){
    //Rank 20
    
    if (rank >=20){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/t_General.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"General"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a General"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank20.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 22){
    //Rank 21
    
    if (rank >=21){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/U_2 Star General.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Two Star General"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Two Star General"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank21.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 23){
    //Rank 22
    
    if (rank >=22){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/V_3 Star General.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Three Star General"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Three Star General"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank22.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 24){
    //Rank 23
    
    if (rank >=23){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/W_4 Star General.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Four Star General"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Four Star General"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank23.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
else if (index == 25){
    //Rank 24
    
    if (rank >=24){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/X_5 Star General.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Five Star General"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.27f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Five Star General"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(.75f,.07f);
        
        [cell addChild:desc];
    }
    else{
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Locked.png"];
        icon.anchorPoint = CGPointZero;
        icon.scale = .5f;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(.75f,.3f);
        
        [cell addChild:lbl];
        
        CCSprite *base = [CCSprite spriteWithImageNamed:@"Assets/base.png"];
        base.positionType = CCPositionTypeNormalized;
        base.anchorPoint = ccp(0,1);
        base.position = ccp(.75f, .18f);
        
        [cell addChild:base];
        
        CCSprite *progress = [CCSprite spriteWithImageNamed:@"Assets/progress.png"];
        CCProgressNode*_progress = [CCProgressNode progressWithSprite:progress];
        _progress.type = CCProgressNodeTypeBar;
        _progress.midpoint = ccp(0.0f, 0.0f);
        _progress.anchorPoint = ccp(0,1);
        _progress.barChangeRate = ccp(1.0f, 0.5f);
        _progress.zOrder = 2500000;
        _progress.positionType = CCPositionTypeNormalized;
        _progress.position = ccp(.75f,.18f);
        
        int experience = person1.experience.intValue;
        int currentRank = [GameData sharedGameData].rank24.intValue;
        float preTemp = (float)experience/(float)currentRank *100;
        CCLOG(@"experience %d, preTemp: %f", experience, preTemp);
        _progress.percentage=preTemp;
        
        [cell addChild:_progress];
        
    }
}
return cell;
}


-(float) tableView:(CCTableView*)tableView heightForRowAtIndex:(NSUInteger)index {
    return 60;
}

- (NSUInteger) tableViewNumberOfRows:(CCTableView*) tableView
{
    /*
     if([GameData sharedGameData].tableID==2){
     return 25;
     }
     
     else if ([GameData sharedGameData].tableID==1){
     return 16;
     }
     else{
     NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
     NSFetchRequest *request = [[NSFetchRequest alloc] init];
     [request setEntity:entity];
     NSError *error = nil;
     NSUInteger count = [[GameData sharedGameData].managedObjectContext countForFetchRequest: request error: &error];
     CCLOG(@"%lu",(unsigned long)count);
     return count+1;
     }
     */
    return 26;
}

// -----------------------------------------------------------------

@end





