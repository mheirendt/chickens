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
    [[CCDirector sharedDirector] pushScene:gameplayScene];
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
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/3.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
         _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Tri Crush"] fontName:@"HelveticaNeue" fontSize:18];
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
    
    else if (index == 2){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/4.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
         _rowHeight = cell.contentSize.height;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Tetra Crush"] fontName:@"HelveticaNeue" fontSize:18];
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
    else if (index == 3){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/5.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Penta Crush"] fontName:@"HelveticaNeue" fontSize:18];
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
    else if (index == 4){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/6.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Hexa Crush"] fontName:@"HelveticaNeue" fontSize:18];
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
    else if (index == 5){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/7.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Hepta Crush"] fontName:@"HelveticaNeue" fontSize:18];
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
    else if (index == 6){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/8.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Octa Crush"] fontName:@"HelveticaNeue" fontSize:18];
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
    else if (index == 7){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/9.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Ennea Crush"] fontName:@"HelveticaNeue" fontSize:18];
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
    else if (index == 8){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/10.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Deca Crush"] fontName:@"HelveticaNeue" fontSize:18];
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
    else if (index == 9){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/100.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Icosi"] fontName:@"HelveticaNeue" fontSize:18];
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
    else if (index == 10){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/40.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Triaconta"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 30 kills without missing a shot"] fontName:@"HelveticaNeue" fontSize:14];
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
    else if (index == 11){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/60.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Tetraconta"] fontName:@"HelveticaNeue" fontSize:18];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"sixty"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 12){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/80.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Pentaconta"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Get 50 kills without missing a shot"] fontName:@"HelveticaNeue" fontSize:14];
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
    else if (index == 13){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/20.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Hecto"] fontName:@"HelveticaNeue" fontSize:18];
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
    else if (index == 14){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/CloseCall.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Close Call"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Crush an egg just before it hits the barn"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"closecall"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
        }
    else if (index == 15){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/Perfect.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Perfect Round"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Don't miss a single egg"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"closecall"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }
    else if (index == 16){
        CCSprite* icon = [CCSprite spriteWithImageNamed:@"Assets/100.png"];
        icon.anchorPoint = CGPointZero;
        cell.contentSize = icon.contentSize;
        [cell addChild:icon];
        
        CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Refueled"] fontName:@"HelveticaNeue" fontSize:18];
        lbl.anchorPoint = CGPointZero;
        lbl.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        lbl.position = ccp(1.3f,.5f);
        
        [cell addChild:lbl];
        
        CCLabelTTF* desc = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Complete the swipe sequence in time"] fontName:@"HelveticaNeue" fontSize:14];
        desc.anchorPoint = CGPointZero;
        desc.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        desc.position = ccp(1.3f,.1f);
        
        [cell addChild:desc];
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person1 valueForKey:@"gascomplete"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }

    }

    
    return cell;
}

-(float) tableView:(CCTableView*)tableView heightForRowAtIndex:(NSUInteger)index {
    return 60;
}

- (NSUInteger) tableViewNumberOfRows:(CCTableView*) tableView
{
    return 17;
}

// -----------------------------------------------------------------

@end




