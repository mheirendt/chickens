//
//  Store.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 2/27/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "Store.h"
#import "GameData.h"

// -----------------------------------------------------------------

@implementation Store{
    //If purchase method is 1 Gold is being used
    //If purchase method is 2 Cash is being used
    int purchaseMethod1;
    int purchaseMethod2;
    
    CCLabelTTF *toggleLabel;
    CCButton *toggleGold;
    CCButton *toggleCash;
    
    CCLabelTTF *toggleLabel2;
    CCButton *toggleGold2;
    CCButton *toggleCash2;
    
    CCLabelTTF *bladeCost;
    CCLabelTTF *nukeCost;
    
    CCLabelTTF *flyingCost;
    CCLabelTTF *bonusCost;
    
    CCButton *bladeWallet;
    CCButton *bladeWalletGold;
    
    CCButton *nukeWallet;
    CCButton *nukeWalletGold;
    
    CCButton *flying;
    CCButton *bonus;
    CCButton *bonusGold;
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
    
    return self;
}
-(void)showGold{
    purchaseMethod1 = 1;
    [toggleLabel setString:@"Purchase With Cash"];
    toggleGold.visible = false;
    toggleCash.visible = true;
    [bladeCost setString:@"75 Eggs"];
    [nukeCost setString:@"75 Eggs"];
    toggleGold.visible = false;
    toggleCash.visible = true;
    bladeWallet.visible = false;
    bladeWalletGold.visible = true;
    nukeWallet.visible = false;
    nukeWalletGold.visible = true;
}
-(void)showCash{
    purchaseMethod1 = 2;
    [toggleLabel setString:@"Purchase With Gold"];
    toggleGold.visible = true;
    toggleCash.visible = false;
    [bladeCost setString:@"$0.99"];
    [nukeCost setString:@"$0.99"];
    toggleGold.visible = true;
    toggleCash.visible = false;
    bladeWallet.visible = true;
    bladeWalletGold.visible = false;
    nukeWallet.visible = true;
    nukeWalletGold.visible = false;
}
-(void)showGold2{
    [toggleLabel2 setString:@"Purchase With Cash"];
    [flyingCost setString:@"N/A"];
    [bonusCost setString:@"200 Eggs"];
    toggleGold2.visible = false;
    toggleCash2.visible = true;
    bonus.visible = false;
    bonusGold.visible = true;
    flying.enabled = false;
}
-(void)showCash2{
    [toggleLabel2 setString:@"Purchase With Gold"];
    [flyingCost setString:@"$1.99"];
    [bonusCost setString:@"$1.99"];
    toggleCash2.visible = false;
    toggleGold2.visible = true;
    bonus.visible = true;
    bonusGold.visible = false;
    flying.enabled = true;
}
-(void)backPressed{
    [[CCDirector sharedDirector] popScene];
}
-(void)bladeWalletPurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    [person setValue:[NSNumber numberWithInt:1] forKey:@"bladewallet"];
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
}
-(void)nukeWalletPurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    [person setValue:[NSNumber numberWithInt:1] forKey:@"nukewallet"];
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
}
-(void)frequentFlyerPurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    [person setValue:[NSNumber numberWithInt:1] forKey:@"frequentflyer"];
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
}
-(void)bonusOddsPurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    [person setValue:[NSNumber numberWithInt:1] forKey:@"betterodds"];
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
}
-(void)tenEggsPurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    int newAmount = person.gold.intValue + 75;
    [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
    
    
}
-(void)thirtyEggsPurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    int newAmount = person.gold.intValue + 200;
    [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
    
}
-(void)fiftyEggsPurchased{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSString *currentUser = [[NSUserDefaults standardUserDefaults]
                             stringForKey:@"defaultUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", currentUser];
    [request setPredicate:predicate];
    NSError *error2 = nil;
    Person *person = [[[GameData sharedGameData].managedObjectContext executeFetchRequest:request error:&error2] objectAtIndex:0];
    int newAmount = person.gold.intValue + 400;
    [person setValue:[NSNumber numberWithInt:newAmount] forKey:@"gold"];
    if (![person.managedObjectContext save:&error2]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error2, error2.localizedDescription);
    }
    
}
- (void)setupScrollViewPagingTest
{
    
    CCScrollView* scrollView = [[CCScrollView alloc] initWithContentNode:[self createScrollContent]];
    scrollView.delegate = self;
    scrollView.flipYCoordinates = NO;
    scrollView.pagingEnabled = YES;
    scrollView.verticalScrollEnabled = NO;
    
    [self addChild:scrollView];
}
- (void)didLoadFromCCB{
    purchaseMethod1 = 2;
    purchaseMethod2 = 2;
    [self setupScrollViewPagingTest];
}

- (CCNode*) createScrollContent
{
    CCNode* node = [CCNode node];
    
    float w = 3;
    float h = 1;
    
    // create grid as specified with width and height
    node.contentSizeType = CCSizeTypeNormalized;
    node.contentSize = CGSizeMake(w, h);
    // ** IMPORTANT ** Each position x value must be added to x and then the sum must be divided by w
    for (int x = 0; x < w; x++){
        if (x == 0){
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Storage Upgrades"] fontName:@"HelveticaNeue-Light" fontSize:38];
            lbl.positionType = CCPositionTypeNormalized;
            lbl.position = ccp((x + 0.5f)/w, (0.85f));
            [node addChild:lbl];
            
            bladeWallet = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseMoney.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/pruchaseMoneyPressed.png"] disabledSpriteFrame:nil];
            bladeWallet.positionType = CCPositionTypeNormalized;
            bladeWallet.position = ccp((x + .35f)/w, .6f);
            [bladeWallet setTarget:self selector:@selector(bladeWalletPurchased)];
            [node addChild:bladeWallet];
            
            bladeWalletGold = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGold.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGoldPressed.png"] disabledSpriteFrame:nil];
            bladeWalletGold.positionType = CCPositionTypeNormalized;
            bladeWalletGold.position = ccp((x + .35f)/w, .6f);
            [bladeWalletGold setTarget:self selector:@selector(bladeWalletPurchased)];
            bladeWalletGold.visible = false;
            [node addChild:bladeWalletGold];
            
            
            CCLabelTTF *bladeDesc = [CCLabelTTF labelWithString:@"Purchasing this item allows you to hold 20 pitchforks as opposed to 10." fontName:@"Helvetica" fontSize:14.f dimensions:CGSizeMake(180, 100)];
            bladeDesc.positionType = CCPositionTypeNormalized;
            bladeDesc.position = ccp((x+.42f)/w, .68f);
            bladeDesc.anchorPoint = ccp(0,1);
            [node addChild:bladeDesc];
            
            bladeCost = [CCLabelTTF labelWithString:@"$0.99" fontName:@"Helvetica" fontSize:22.f dimensions:CGSizeMake(100,100)];
            bladeCost.positionType = CCPositionTypeNormalized;
            bladeCost.position = ccp((x+.13f)/w, .53f);
            bladeCost.anchorPoint = ccp(0,.5f);
            [node addChild:bladeCost];
            
            nukeWallet = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseMoney.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/pruchaseMoneyPressed.png"] disabledSpriteFrame:nil];
            nukeWallet.positionType = CCPositionTypeNormalized;
            nukeWallet.position = ccp((x + .35f)/w, .3f);
            [nukeWallet setTarget:self selector:@selector(nukeWalletPurchased)];
            [node addChild:nukeWallet];
            
            nukeWalletGold = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGold.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGoldPressed.png"] disabledSpriteFrame:nil];
            nukeWalletGold.positionType = CCPositionTypeNormalized;
            nukeWalletGold.position = ccp((x + .35f)/w, .3f);
            [nukeWalletGold setTarget:self selector:@selector(nukeWalletPurchased)];
            nukeWalletGold.visible = false;
            [node addChild:nukeWalletGold];
            
            CCLabelTTF *nukeDesc = [CCLabelTTF labelWithString:@"Purchasing this item allows you to hold 20 nukes as opposed to 10." fontName:@"Helvetica" fontSize:14.f dimensions:CGSizeMake(220, 100)];
            nukeDesc.positionType = CCPositionTypeNormalized;
            nukeDesc.position = ccp((x+.42f)/w, .38f);
            nukeDesc.anchorPoint = ccp(0,1);
            [node addChild:nukeDesc];
            
            nukeCost = [CCLabelTTF labelWithString:@"$0.99" fontName:@"Helvetica" fontSize:22.f dimensions:CGSizeMake(100,100)];

            nukeCost.positionType = CCPositionTypeNormalized;
            nukeCost.position = ccp((x+.13f)/w, .23f);
            nukeCost.anchorPoint = ccp(0,.5f);
            [node addChild:nukeCost];
            
            CCSprite *icon = [CCSprite spriteWithImageNamed:@"Rank/blockWallet.png"];
            icon.positionType = CCPositionTypeNormalized;
            icon.position = ccp((x+.87f)/w,.75f);
            [node addChild:icon];
            
            toggleGold = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGold.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGoldPressed.png"] disabledSpriteFrame:nil];
            [toggleGold setTarget:self selector:@selector(showGold)];
            toggleGold.positionType = CCPositionTypeNormalized;
            toggleGold.position = ccp((x + .06f)/w,.88f);
            [node addChild:toggleGold];
            
            toggleCash = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseMoney.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/pruchaseMoneyPressed.png"] disabledSpriteFrame:nil];
            [toggleCash setTarget:self selector:@selector(showCash)];
            toggleCash.visible = false;
            toggleCash.positionType = CCPositionTypeNormalized;
            toggleCash.position = ccp((x + .06f)/w,.88f);
            [node addChild:toggleCash];
            
            
            toggleLabel = [CCLabelTTF labelWithString:@"Purchase With Gold" fontName:@"Helvetica" fontSize:12.f dimensions:CGSizeMake(toggleCash.contentSize.width + 20, 100)];
            toggleLabel.anchorPoint = ccp(0,1);
            toggleLabel.positionType = CCPositionTypeNormalized;
            toggleLabel.position = ccp((x + toggleCash.position.x)/w,toggleCash.position.y - .08);
            [node addChild:toggleLabel];
            
        }
        else if (x == 1){
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Better Odds"] fontName:@"HelveticaNeue-Light" fontSize:38];
            lbl.positionType = CCPositionTypeNormalized;
            lbl.position = ccp((x + 0.5f)/w, (0.85f));
            [node addChild:lbl];
            
            flying = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseMoney.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/pruchaseMoneyPressed.png"] disabledSpriteFrame:nil];
            flying.positionType = CCPositionTypeNormalized;
            flying.position = ccp((x + .35f)/w, .6f);
            [flying setTarget:self selector:@selector(frequentFlyerPurchased)];
            [node addChild:flying];
            
            
            CCLabelTTF *flyingDesc = [CCLabelTTF labelWithString:@"Purchasing this item improves your odds per round of receiving a golden egg from 25% to 50%." fontName:@"Helvetica" fontSize:14.f dimensions:CGSizeMake(180, 100)];
            flyingDesc.positionType = CCPositionTypeNormalized;
            flyingDesc.position = ccp((x+.42f)/w, .68f);
            flyingDesc.anchorPoint = ccp(0,1);
            [node addChild:flyingDesc];
            
            flyingCost = [CCLabelTTF labelWithString:@"$1.99" fontName:@"Helvetica" fontSize:22.f dimensions:CGSizeMake(100,100)];
            flyingCost.positionType = CCPositionTypeNormalized;
            flyingCost.position = ccp((x+.13f)/w, .53f);
            flyingCost.anchorPoint = ccp(0,.5f);
            [node addChild:flyingCost];
            
            bonus = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseMoney.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/pruchaseMoneyPressed.png"] disabledSpriteFrame:nil];
            bonus.positionType = CCPositionTypeNormalized;
            bonus.position = ccp((x + .35f)/w, .3f);
            [bonus setTarget:self selector:@selector(bonusOddsPurchased)];
            [node addChild:bonus];
            
            bonusGold = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGold.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGoldPressed.png"] disabledSpriteFrame:nil];
            bonusGold.positionType = CCPositionTypeNormalized;
            bonusGold.position = ccp((x + .35f)/w, .3f);
            [bonusGold setTarget:self selector:@selector(bonusOddsPurchased)];
            bonusGold.visible = false;
            [node addChild:bonusGold];
            
            CCLabelTTF *bonusDesc = [CCLabelTTF labelWithString:@"Purchasing this item gives your user a 100% chance of a bonus of either a nuke or a pitchfork after completing each round as opposed to a 50% chance." fontName:@"Helvetica" fontSize:14.f dimensions:CGSizeMake(220, 100)];
            bonusDesc.positionType = CCPositionTypeNormalized;
            bonusDesc.position = ccp((x+.42f)/w, .38f);
            bonusDesc.anchorPoint = ccp(0,1);
            [node addChild:bonusDesc];
            
            bonusCost = [CCLabelTTF labelWithString:@"$1.99" fontName:@"Helvetica" fontSize:22.f dimensions:CGSizeMake(100,100)];
            
            bonusCost.positionType = CCPositionTypeNormalized;
            bonusCost.position = ccp((x+.13f)/w, .23f);
            bonusCost.anchorPoint = ccp(0,.5f);
            [node addChild:bonusCost];
            
            CCSprite *icon = [CCSprite spriteWithImageNamed:@"Rank/blockOdds.png"];
            icon.positionType = CCPositionTypeNormalized;
            icon.position = ccp((x+.87f)/w,.75f);
            [node addChild:icon];
            
            toggleGold2 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGold.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseGoldPressed.png"] disabledSpriteFrame:nil];
            [toggleGold2 setTarget:self selector:@selector(showGold2)];
            toggleGold2.positionType = CCPositionTypeNormalized;
            toggleGold2.position = ccp((x + .06f)/w,.88f);
            [node addChild:toggleGold2];
            
            toggleCash2 = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseMoney.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/pruchaseMoneyPressed.png"] disabledSpriteFrame:nil];
            [toggleCash2 setTarget:self selector:@selector(showCash2)];
            toggleCash2.visible = false;
            toggleCash2.positionType = CCPositionTypeNormalized;
            toggleCash2.position = ccp((x + .06f)/w,.88f);
            [node addChild:toggleCash2];
            
            
            toggleLabel2 = [CCLabelTTF labelWithString:@"Purchase With Gold" fontName:@"Helvetica" fontSize:12.f dimensions:CGSizeMake(toggleCash2.contentSize.width + 20, 100)];
            toggleLabel2.anchorPoint = ccp(0,1);
            toggleLabel2.positionType = CCPositionTypeNormalized;
            toggleLabel2.position = ccp((x + toggleCash.position.x)/w,toggleCash2.position.y - .08f);
            [node addChild:toggleLabel2];
        }
        else if (x == 2){
            CCLabelTTF* lbl = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Golden Eggs"] fontName:@"HelveticaNeue-Light" fontSize:38];
            lbl.positionType = CCPositionTypeNormalized;
            lbl.position = ccp((x + 0.5f)/w, (0.85f));
            [node addChild:lbl];
            
            CCButton *tenEggs = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseMoney.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/pruchaseMoneyPressed.png"] disabledSpriteFrame:nil];
            tenEggs.positionType = CCPositionTypeNormalized;
            tenEggs.position = ccp((x + .35f)/w, .65f);
            [tenEggs setTarget:self selector:@selector(tenEggsPurchased)];
            [node addChild:tenEggs];
            
            CCLabelTTF *tenDesc = [CCLabelTTF labelWithString:@"Seventy five eggs for when you are in a pinch." fontName:@"Helvetica" fontSize:14.f dimensions:CGSizeMake(180, 100)];
            tenDesc.positionType = CCPositionTypeNormalized;
            tenDesc.position = ccp((x+.42f)/w, .73f);
            tenDesc.anchorPoint = ccp(0,1);
            [node addChild:tenDesc];
            
            CCLabelTTF *tenCost = [CCLabelTTF labelWithString:@"$0.99" fontName:@"Helvetica" fontSize:22.f dimensions:CGSizeMake(100,100)];
            tenCost.positionType = CCPositionTypeNormalized;
            tenCost.position = ccp((x+.13f)/w, .58f);
            tenCost.anchorPoint = ccp(0,.5f);
            [node addChild:tenCost];
            
            CCButton *thirtyEggs = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseMoney.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/pruchaseMoneyPressed.png"] disabledSpriteFrame:nil];
            thirtyEggs.positionType = CCPositionTypeNormalized;
            thirtyEggs.position = ccp((x + .35f)/w, .42f);
            [thirtyEggs setTarget:self selector:@selector(thirtyEggsPurchased)];
            [node addChild:thirtyEggs];
            
            CCLabelTTF *thirtyDesc = [CCLabelTTF labelWithString:@"Two hundred eggs for the books." fontName:@"Helvetica" fontSize:14.f dimensions:CGSizeMake(220, 100)];
            thirtyDesc.positionType = CCPositionTypeNormalized;
            thirtyDesc.position = ccp((x+.42f)/w, .5f);
            thirtyDesc.anchorPoint = ccp(0,1);
            [node addChild:thirtyDesc];
            
            CCLabelTTF *thirtyCost = [CCLabelTTF labelWithString:@"$1.99" fontName:@"Helvetica" fontSize:22.f dimensions:CGSizeMake(100,100)];
            
            thirtyCost.positionType = CCPositionTypeNormalized;
            thirtyCost.position = ccp((x+.13f)/w, .34f);
            thirtyCost.anchorPoint = ccp(0,.5f);
            [node addChild:thirtyCost];
            
            CCButton *fiftyEggs = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/purchaseMoney.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Rank/pruchaseMoneyPressed.png"] disabledSpriteFrame:nil];
            fiftyEggs.positionType = CCPositionTypeNormalized;
            fiftyEggs.position = ccp((x + .35f)/w, .18f);
            [fiftyEggs setTarget:self selector:@selector(fiftyEggsPurchased)];
            [node addChild:fiftyEggs];
            
            CCLabelTTF *best = [CCLabelTTF labelWithString:@"** Best Value **" fontName:@"Helvetica" fontSize:14.f];
            best.positionType = CCPositionTypeNormalized;
            best.position = ccp((x+.42f)/w, .26f);
            best.anchorPoint = ccp(0,1);
            [node addChild:best];
        
            CCLabelTTF *fiftyDesc = [CCLabelTTF labelWithString:@"Four hundred eggs for you to do with as you please!" fontName:@"Helvetica" fontSize:14.f dimensions:CGSizeMake(220, 100)];
            fiftyDesc.positionType = CCPositionTypeNormalized;
            fiftyDesc.position = ccp((x+.42f)/w, .21f);
            fiftyDesc.anchorPoint = ccp(0,1);
            [node addChild:fiftyDesc];
            
            CCLabelTTF *fiftyCost = [CCLabelTTF labelWithString:@"$2.99" fontName:@"Helvetica" fontSize:22.f dimensions:CGSizeMake(100,100)];
            
            fiftyCost.positionType = CCPositionTypeNormalized;
            fiftyCost.position = ccp((x+.13f)/w, .11f);
            fiftyCost.anchorPoint = ccp(0,.5f);
            [node addChild:fiftyCost];
            
            CCSprite *icon = [CCSprite spriteWithImageNamed:@"Rank/blockEggs.png"];
            icon.positionType = CCPositionTypeNormalized;
            icon.position = ccp((x+.87f)/w,.75f);
            [node addChild:icon];
        }
        
    }
    
    return node;
}

// -----------------------------------------------------------------

@end





