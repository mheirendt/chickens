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
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    
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
        
        doubles = [NSString stringWithFormat:@"X %@", [person valueForKey:@"two"]];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"three"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"four"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"five"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"six"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"seven"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"eight"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"nine"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"ten"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"twenty"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"forty"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"sixty"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"eighty"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"hundred"]] fontName:@"HelveticaNeue" fontSize:22];
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
        
        CCLabelTTF* count = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"X %@", [person valueForKey:@"closecall"]] fontName:@"HelveticaNeue" fontSize:22];
        count.anchorPoint = CGPointZero;
        count.positionType = CCPositionTypeNormalized;
        //lbl.position = ccp(70, 20);
        count.position = ccp(7.f,.2f);
        
        [cell addChild:count];
    }

    
    return cell;
}

-(float) tableView:(CCTableView*)tableView heightForRowAtIndex:(NSUInteger)index {
    return 60;
}

- (NSUInteger) tableViewNumberOfRows:(CCTableView*) tableView
{
    return 16;
}

// -----------------------------------------------------------------

@end




