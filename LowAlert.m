//
//  LowAlert.m
//
//  Created by : Michael Heirendt
//  Project    : Crush
//  Date       : 2/7/16
//
//  Copyright (c) 2016 Apportable.
//  All rights reserved.
//
// -----------------------------------------------------------------

#import "LowAlert.h"
#import "GameData.h"

// -----------------------------------------------------------------
@implementation LowAlert{
    int seq1;
    int seq2;
    int seq3;
    int seq4;
    int min;
    int max;
    int range;
    int random;
    
    CCLabelTTF *upLab;
    CCLabelTTF *rightLab;
    CCLabelTTF *downLab;
    CCLabelTTF *leftLab;
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


+ (void) dismiss: (CCSprite*) alertDialog onCoverLayer: (CCNode*) coverLayer executingBlock: (void(^)())block {
    
    [alertDialog runAction:[CCActionFadeOut actionWithDuration:1.f]];
    
    [coverLayer runAction:[CCActionCallBlock actionWithBlock:^{
        if (block) block();
    }]];
}

- (void)ShowAlertOnLayer: (CCNode *) layer{
    //[self alertStarted];
    static int one;
    static int two;
    static int three;
    static int four;
    
    CCSprite *alert = [CCSprite spriteWithImageNamed:@"Assets/lowGas.png"];
    alert.name = @"1234";
    alert.positionType = CCPositionTypeUIPoints;
    alert.scaleType = CCScaleTypeScaled;
    alert.anchorPoint  = ccp(.5f,.5f);
    alert.position = ccp(120,160);

    float fontSize = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)?30:18;
    for (int i = 0; i<4; i++){
        min = 1;
        max = 5;
        range = max - min;
        random = (arc4random() % range) + min;
        CCLOG(@"random:%d",random);
        if (i==0){
            one = random;
            seq1 = one;
            [GameData sharedGameData].seq1 = seq1;
            if (seq1 == 1){
                
                NSString *up = [NSString stringWithFormat:@"↑"];
                upLab = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                upLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                upLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                //[alert addChild: lab1];
                [alert addChild:upLab];
            }
            if (seq1 == 2){
                //seq2 = 2;
                NSString *right = [NSString stringWithFormat:@"→"];
                rightLab = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                rightLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                rightLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                //[alert addChild: lab2];
                [alert addChild:rightLab];
            }
            if (seq1 == 3){
                //seq3 = 3;
                NSString *down = [NSString stringWithFormat:@"↓"];
                downLab = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                downLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width+ 18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                downLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                [alert addChild:downLab];
            }
            if (seq1 == 4){
                //seq4 = 4;
                NSString *left = [NSString stringWithFormat:@"←"];
                leftLab = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                leftLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +50, alert.contentSize.height * 0.35f);
                }
                leftLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                [alert addChild:leftLab];
            }

            NSString *log = [NSString stringWithFormat:@"%d%d%d%d",seq1,seq2,seq3,seq4];
            CCLOG(@"Data Sequence%d: %@",i, log);
        }
        else if (i == 1){
            two = random;
            seq2 = two;
            [GameData sharedGameData].seq2 = seq2;
            if (seq2 == 1){
                
                NSString *up = [NSString stringWithFormat:@"↑"];
                upLab = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                upLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                upLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                //[alert addChild: lab1];
                [alert addChild:upLab];
            }
            if (seq2 == 2){
                //seq2 = 2;
                NSString *right = [NSString stringWithFormat:@"→"];
                rightLab = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                rightLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                rightLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                //[alert addChild: lab2];
                [alert addChild:rightLab];
            }
            if (seq2 == 3){
                //seq3 = 3;
                NSString *down = [NSString stringWithFormat:@"↓"];
                downLab = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                downLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width+ 18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                downLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                [alert addChild:downLab];
            }
            if (seq2 == 4){
                //seq4 = 4;
                NSString *left = [NSString stringWithFormat:@"←"];
                leftLab = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                leftLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +50, alert.contentSize.height * 0.35f);
                }
                leftLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                [alert addChild:leftLab];
            }

            NSString *log = [NSString stringWithFormat:@"%d%d%d%d",seq1,seq2,seq3,seq4];
            CCLOG(@"Data Sequence%d: %@",i, log);
        }
        else if (i==2){
            three = random;
            seq3 = three;
            [GameData sharedGameData].seq3 = seq3;
            if (seq3 == 1){
                
                NSString *up = [NSString stringWithFormat:@"↑"];
                upLab = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                upLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                upLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                //[alert addChild: lab1];
                [alert addChild:upLab];
            }
            if (seq3 == 2){
                //seq2 = 2;
                NSString *right = [NSString stringWithFormat:@"→"];
                rightLab = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                rightLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                rightLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                //[alert addChild: lab2];
                [alert addChild:rightLab];
            }
            if (seq3 == 3){
                //seq3 = 3;
                NSString *down = [NSString stringWithFormat:@"↓"];
                downLab = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                downLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width+ 18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                downLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                [alert addChild:downLab];
            }
            if (seq3 == 4){
                //seq4 = 4;
                NSString *left = [NSString stringWithFormat:@"←"];
                leftLab = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                leftLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +50, alert.contentSize.height * 0.35f);
                }
                leftLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                [alert addChild:leftLab];
            }

            NSString *log = [NSString stringWithFormat:@"%d%d%d%d",seq1,seq2,seq3,seq4];
            CCLOG(@"Data Sequence%d: %@",i, log);
        }
        if (i==3){
            four = random;
            seq4 = four;
            [GameData sharedGameData].seq4 = seq4;
            if (seq4 == 1){
                
                NSString *up = [NSString stringWithFormat:@"↑"];
                upLab = [CCLabelTTF labelWithString:up fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                upLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    upLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                upLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                //[alert addChild: lab1];
                [alert addChild:upLab];
            }
            if (seq4 == 2){
                //seq2 = 2;
                NSString *right = [NSString stringWithFormat:@"→"];
                rightLab = [CCLabelTTF labelWithString:right fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                rightLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    rightLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                rightLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                //[alert addChild: lab2];
                [alert addChild:rightLab];
            }
            if (seq4 == 3){
                //seq3 = 3;
                NSString *down = [NSString stringWithFormat:@"↓"];
                downLab = [CCLabelTTF labelWithString:down fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                downLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width+ 18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 4){
                    downLab.position = ccp(alert.contentSize.width - alert.contentSize.width +54, alert.contentSize.height * 0.35f);
                }
                downLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                [alert addChild:downLab];
            }
            if (seq4 == 4){
                //seq4 = 4;
                NSString *left = [NSString stringWithFormat:@"←"];
                leftLab = [CCLabelTTF labelWithString:left fontName:@"Helvetica" fontSize:fontSize dimensions:CGSizeMake(300,100)];
                leftLab.anchorPoint = ccp(0, 0);
                if(i == 0){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width, alert.contentSize.height * 0.35f);
                }
                else if(i == 1){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +18, alert.contentSize.height * 0.35f);
                }
                else if(i == 2){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +36, alert.contentSize.height * 0.35f);
                }
                else if(i == 3){
                    leftLab.position = ccp(alert.contentSize.width - alert.contentSize.width +50, alert.contentSize.height * 0.35f);
                }
                leftLab.color = [CCColor colorWithCcColor3b:ccBLACK];
                [alert addChild:leftLab];
            }

            NSString *log = [NSString stringWithFormat:@"%d%d%d%d",seq1,seq2,seq3,seq4];
            CCLOG(@"Data Sequence%d: %@",i, log);
        }
    }
    NSString *log = [NSString stringWithFormat:@"%d%d%d%d",seq1,seq2,seq3,seq4];
    CCLOG(@"Data Sequence: %@",log);
    [layer addChild:alert];
    
    UISwipeGestureRecognizer * swipeLeft= [[UISwipeGestureRecognizer alloc]initWithTarget:layer action:@selector(swipeLeft)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeLeft];
    // listen for swipes to the right
    UISwipeGestureRecognizer * swipeRight= [[UISwipeGestureRecognizer alloc]initWithTarget:layer action:@selector(swipeRight)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRight];
    // listen for swipes up
    UISwipeGestureRecognizer * swipeUp= [[UISwipeGestureRecognizer alloc]initWithTarget:layer action:@selector(swipeUp)];
    swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeUp];
    // listen for swipes down
    UISwipeGestureRecognizer * swipeDown= [[UISwipeGestureRecognizer alloc]initWithTarget:layer action:@selector(swipeDown)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeDown];


    alert.opacity = 0;
    CCActionFadeIn *fadeIn = [CCActionFadeIn actionWithDuration:.5f];
    CCActionFadeOut *fadeOut = [CCActionFadeOut actionWithDuration:.5f];
    [alert runAction:[CCActionSequence actions: fadeIn,fadeOut,fadeIn,fadeOut,nil]];

}

-(void)changeColor:(int)color{
    if (color == 1){
        CCLOG(@"GREEN");
        [rightLab setColor:[CCColor greenColor]];
        [upLab setColor:[CCColor greenColor]];
        [downLab setColor:[CCColor greenColor]];
        [leftLab setColor:[CCColor greenColor]];
        //rightLab.color = [CCColor greenColor];
    }
    else{
        CCLOG(@"FAIL");
    }
}




@end





