#import "MainScene.h"
#import "GameData.h"

@implementation MainScene

-(void)onEnter{
    [super onEnter];
    [[GameData sharedGameData] initializeUsers];
}
- (void)playPressed {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Gameplay"];
    [[CCDirector sharedDirector] pushScene:gameplayScene];
}
- (void)medalsPressed {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Medals"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}
- (void)settingsPressed {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"Settings"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}
- (void)highScoresPressed {
    CCScene *gameplayScene = [CCBReader loadAsScene:@"HighScores"];
    [[CCDirector sharedDirector] replaceScene:gameplayScene];
}

@end
