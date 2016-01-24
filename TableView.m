//
//  TableView.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/7/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "TableView.h"
#import "GameData.h"
// -----------------------------------------------------------------

@implementation TableView{
    float _rowHeight;
    NSString *doubles;
    NSString *triples;
    NSString *overs;
    NSString *taculars;
    
    CCButton *_addUser;
    int amount;
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
-(void)onEnter{
    [super onEnter];
    CCLOG(@"%d", [GameData sharedGameData].tableID);
    if([GameData sharedGameData].tableID == 3){
        _addUser = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forward.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/forwardPressed.png"] disabledSpriteFrame:nil];
        _addUser.positionType = CCPositionTypeNormalized;
        _addUser.position = ccp(.7f,.73f);
        [_addUser setTarget:self selector:@selector(createUser)];
        [self addChild:_addUser];
        
    }
}
-(void)createUser{
    CCScene *gameplayScene = [CCBReader loadAsScene:@"SignIn"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
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
    
    
    
    if([GameData sharedGameData].tableID ==1){
        amount = 16;
    if (index == 1){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/2.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Double Kill"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 2 instantaneous kills"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        doubles = [NSString stringWithFormat:@"X %@", [person1 valueForKey:@"two"]];
        CCLabelTTF* count = [CCLabelTTF labelWithString:doubles fontName:@"HelveticaNeue" fontSize:22];
        //CCLabelTTF * count = [CCLabelTTF labelWithString:@"X %li", [[GameData sharedGameData].doubleKills]; fontName:[@"HelveticaNeue" fontSize:30];
        //fontName:@"HelveticaNeue" fontSize:30];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 2){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/3.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
         _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Triple Kill"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);

        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 3 instantaneous kills"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"three"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    
    else if (index == 3){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/4.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
         _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Over Kill"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 4 instantaneous kills"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        
        [cell addChild:lbl];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"four"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
        
    }
    else if (index == 4){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/5.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Killtacular"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);

        
        [cell addChild:lbl];
        
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 5 instantaneous kills"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"five"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 5){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/6.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Killpocalypse"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);

        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 6 instantaneous kills"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"six"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
        
    }
    else if (index == 6){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/7.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"7 Kills"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);

        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 7 instantaneous kills"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"seven"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
        
    }
    else if (index == 7){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/8.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"8 kills"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 8 instantaneous kills"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"eight"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
        
    }
    else if (index == 8){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/9.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"9 Kills"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 9 instantaneous kills"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"nine"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
        
    }
    else if (index == 9){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/10.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"10 kills"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 10 instantaneous kills"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"ten"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 10){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Killing Spree"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 20 kills without missing a shot"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"twenty"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 11){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/40.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Killing Frenzy"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 40 kills without missing a shot"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"forty"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 12){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/60.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Running Riot"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 60 kills without missing a shot"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"sixty"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 13){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/80.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"80 Spree"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 80 kills without missing a shot"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"eighty"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 14){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/100.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"100 Spree"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 100 kills without missing a shot"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"hundred"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 15){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/CloseCall.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Close Call"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Crush an egg just before it hits the barn"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"closecall"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
        }
    }
    
    
    
    else if ([GameData sharedGameData].tableID == 2){
        amount = 25;
        int rank = person1.rank.intValue;
        if (index == 1){
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
                lbl.position = ccp(.75f,.3f);
                
                [cell addChild:lbl];
                
                CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Recruit"] fontName:@"HelveticaNeue" fontSize:14];
                desc.anchorPoint = CGPointZero;
                desc.positionType = CCPositionTypeNormalized;
                //lbl.position = ccp(70, 20);
                desc.position = ccp(.75f,.1f);
                
                [cell addChild:desc];
                
            }
        else if (index == 2){
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
                lbl.position = ccp(.75f,.3f);
            
                [cell addChild:lbl];
            
                CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Private"] fontName:@"HelveticaNeue" fontSize:14];
                desc.anchorPoint = CGPointZero;
                desc.positionType = CCPositionTypeNormalized;
                //lbl.position = ccp(70, 20);
                desc.position = ccp(.75f,.1f);
            
                [cell addChild:desc];
            
            }
            else{
                CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                icon.anchorPoint = CGPointZero;
                icon.scale = .5f;
                cell.contentSize = icon.contentSize;
                _rowHeight = cell.contentSize.height;
                [cell addChild:icon];
                
                CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
                lbl.anchorPoint = CGPointZero;
                lbl.positionType = CCPositionTypeNormalized;
                //lbl.position = ccp(70, 20);
                lbl.position = ccp(.75f,.5f);
                
                [cell addChild:lbl];
            }
        }
        else if (index == 3){
            if (rank >=1){
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
                lbl.position = ccp(.75f,.3f);
                
                [cell addChild:lbl];
                
                CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You are a Private First Class"] fontName:@"HelveticaNeue" fontSize:14];
                desc.anchorPoint = CGPointZero;
                desc.positionType = CCPositionTypeNormalized;
                //lbl.position = ccp(70, 20);
                desc.position = ccp(.75f,.1f);
                
                [cell addChild:desc];
            }
            else{
                CCSprite* icon = [CCSprite spriteWithImageNamed:@"Rank/aa_Private.png"];
                icon.anchorPoint = CGPointZero;
                icon.scale = .5f;
                cell.contentSize = icon.contentSize;
                _rowHeight = cell.contentSize.height;
                [cell addChild:icon];
                
                CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Locked"] fontName:@"HelveticaNeue" fontSize:18];
                lbl.anchorPoint = CGPointZero;
                lbl.positionType = CCPositionTypeNormalized;
                //lbl.position = ccp(70, 20);
                lbl.position = ccp(1.3f,.5f);
                
                [cell addChild:lbl];
            }
        }
    }
    else if ([GameData sharedGameData].tableID == 3){
        if (index == 1){
            Person *person11 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:0];
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person11.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypeNormalized;
            //lbl.position = ccp(70, 20);
            lbl.position = ccp(.5f,.4f);
            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
        }
        else if (index == 2){
            Person *person2 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:1];
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person2.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypeNormalized;
            //lbl.position = ccp(70, 20);
            lbl.position = ccp(.5f,.4f);
            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
        }
        else if (index == 3){
            Person *person3 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:2];
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person3.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypeNormalized;
            //lbl.position = ccp(70, 20);
            lbl.position = ccp(.5f,.4f);
            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
        }
        else if (index == 4){
            Person *person4 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:3];
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person4.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypeNormalized;
            //lbl.position = ccp(70, 20);
            lbl.position = ccp(.5f,.4f);
            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
        }
        else if (index == 5){
            Person *person5 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:4];
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person5.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypeNormalized;
            //lbl.position = ccp(70, 20);
            lbl.position = ccp(.5f,.4f);
            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
        }
        else if (index == 6){
            Person *person6 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:5];
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person6.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypeNormalized;
            //lbl.position = ccp(70, 20);
            lbl.position = ccp(.5f,.4f);
            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
        }
        else if (index == 7){
            Person *person7 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:6];
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person7.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypeNormalized;
            //lbl.position = ccp(70, 20);
            lbl.position = ccp(.5f,.4f);
            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
        }
        /*
        else if (index == 8){
            Person *person8 = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request1 error:&error2] objectAtIndex:7];
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@", person8.name] fontName:@"HelveticaNeue" fontSize:32];
            lbl.positionType = CCPositionTypeNormalized;
            //lbl.position = ccp(70, 20);
            lbl.position = ccp(.5f,.4f);
            cell.contentSize = lbl.contentSize;
            [cell addChild:lbl];
        }
         */
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
    return 16;
}

// -----------------------------------------------------------------

@end




