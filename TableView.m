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

// -----------------------------------------------------------------
float const kNumberOfRows = 30.0f;
@implementation TableView

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


- (CCTableViewCell*) tableView:(CCTableView*)tableView nodeForRowAtIndex:(NSUInteger) index
{
    CCTableViewCell* cell = [CCTableViewCell node];
    
    cell.contentSizeType = CCSizeTypeMake(CCSizeUnitNormalized, CCSizeUnitPoints);
    cell.contentSize = CGSizeMake(1, 24);
    
    // Color every other row differently
    CCNodeColor* bg;
    if (index % 2 != 0) bg = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1 green:0 blue:0 alpha:0.5]];
    else bg = [CCNodeColor nodeWithColor: [CCColor colorWithRed:0 green:1 blue:0 alpha:0.5]];
    
    bg.userInteractionEnabled = NO;
    bg.contentSizeType = CCSizeTypeNormalized;
    bg.contentSize = CGSizeMake(1, 1);
    [cell addChild:bg];
    
    // Create a label with the row number
    CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", (int)index] fontName:@"HelveticaNeue" fontSize:18];
    lbl.positionType = CCPositionTypeNormalized;
    lbl.position = ccp(0.5f, 0.5f);
    
    [cell addChild:lbl];
    
    return cell;
}

- (NSUInteger) tableViewNumberOfRows:(CCTableView*) tableView
{
    return 50;
}

// -----------------------------------------------------------------

@end





