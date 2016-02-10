//
//  signInScene.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 1/13/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "signInScene.h"
#import "GameData.h"
#import "AlertView.h"

// -----------------------------------------------------------------

@implementation signInScene{
    CCTextField *_profileText;
    CCButton *back;
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
+ (instancetype)sharedGameData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

- (NSString *)buttonText:(CCTextField*)sender {
    NSString * userName = sender.string;
    return userName;
}
-(void)onEnter{
    [super onEnter];
    CCLOG(@"%d", [GameData sharedGameData].tableID);
    if([GameData sharedGameData].tableID == 3){
        back = [CCButton buttonWithTitle:nil spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/Back.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"Assets/BackPressed.png"] disabledSpriteFrame:nil];
        back.positionType = CCPositionTypeNormalized;
        back.position = ccp(.065f, .13f);
        [back setTarget:self selector:@selector(backPressed)];
        [self addChild:back];
        
        CCLabelTTF *label = [CCLabelTTF labelWithString:@"Cancel" fontName:@"Helvetica" fontSize:14];
        label.positionType = CCPositionTypeNormalized;
        label.position = ccp(.065f, .04f);
        [self addChild:label];
    }
}
-(void)backPressed{
    [[CCDirector sharedDirector] popScene];
}

-(void)createPressed{
    //NSString *containerForTextFieldValue = _profileText.textField.text;
    //NSLog(@"%@", containerForTextFieldValue);
    NSString* userName = [NSString stringWithString:[self buttonText:_profileText]];
    CCLOG(@"%@",userName);
    if (userName.length == 0){
        id block = ^(void){
            _profileText.enabled = true;
            back.enabled = true;
        };
        _profileText.enabled = false;
        back.enabled = false;
        
        [AlertView ShowAlert:@"You must enter a profile name." onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
    }
    else if (userName.length > 12){
        id block = ^(void){
            _profileText.enabled = true;
            back.enabled = true;
        };
        _profileText.enabled = false;
        back.enabled = false;
        
        [AlertView ShowAlert:@"Your name can't be longer than 11 characters." onLayer:self withOpt1:@"Okay" withOpt1Block:block andOpt2:nil withOpt2Block:nil];
    }
    else{
    
        /*
         NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.managedObjectContext];
         NSManagedObject *newPerson = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:self.managedObjectContext];
         [newPerson setValue:@"mikey7896" forKey:@"name"];
         [newPerson setValue:@8143 forKey:@"highscore"];
         */
        
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    NSManagedObject *newPerson = [[NSManagedObject alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:[GameData sharedGameData].managedObjectContext];
    [newPerson setValue:userName forKey:@"name"];
    [newPerson setValue:@0 forKey:@"highscore"];
        [newPerson setValue:@0 forKey:@"rank"];
        [newPerson setValue:@0 forKey:@"experience"];
        [newPerson setValue:@0 forKey:@"two"];
        [newPerson setValue:@0 forKey:@"three"];
        [newPerson setValue:@0 forKey:@"four"];
        [newPerson setValue:@0 forKey:@"five"];
        [newPerson setValue:@0 forKey:@"six"];
        [newPerson setValue:@0 forKey:@"seven"];
        [newPerson setValue:@0 forKey:@"eight"];
        [newPerson setValue:@0 forKey:@"nine"];
        [newPerson setValue:@0 forKey:@"ten"];
        [newPerson setValue:@0 forKey:@"closecall"];
        [newPerson setValue:@0 forKey:@"twenty"];
        [newPerson setValue:@0 forKey:@"forty"];
        [newPerson setValue:@0 forKey:@"sixty"];
        [newPerson setValue:@0 forKey:@"eighty"];
        [newPerson setValue:@0 forKey:@"hundred"];
        [newPerson setValue:@0 forKey:@"perfect"];
        [newPerson setValue:@0 forKey:@"gold"];


    
    NSError *error = nil;
    if (![newPerson.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
        [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"defaultUser"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        if([GameData sharedGameData].tableID){
            //CCScene *mainScene = [CCBReader loadAsScene:@"HighScores"];
            //[[CCDirector sharedDirector] replaceScene: mainScene];
            [[CCDirector sharedDirector] popScene];
            [[CCDirector sharedDirector] popScene];
        }
    else{
        
        CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
        [[CCDirector sharedDirector] replaceScene: mainScene];
        [GameData sharedGameData].newPlayerFlag = true;
            CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
            [[CCDirector sharedDirector] pushScene:gameplayScene];
         
        //[[CCDirector sharedDirector] popScene];
        }
    }

}
// -----------------------------------------------------------------

@end





