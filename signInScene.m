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

// -----------------------------------------------------------------

@implementation signInScene{
    CCTextField *_profileText;
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

-(void)createPressed{
    //NSString *containerForTextFieldValue = _profileText.textField.text;
    //NSLog(@"%@", containerForTextFieldValue);
    NSString* userName = [NSString stringWithString:[self buttonText:_profileText]];
    CCLOG(@"%@",userName);
    if (userName.length == 0){
        CCLOG(@"fail");
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

    
    NSError *error = nil;
    if (![newPerson.managedObjectContext save:&error]) {
        NSLog(@"Unable to save managed object context.");
        NSLog(@"%@, %@", error, error.localizedDescription);
    }
    else{
        CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
        [[CCDirector sharedDirector] replaceScene: mainScene];
            CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
            [[CCDirector sharedDirector] pushScene:gameplayScene];
    }
    }

}
// -----------------------------------------------------------------

@end





