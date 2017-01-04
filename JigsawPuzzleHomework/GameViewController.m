#import "GameViewController.h"
#import "GameScene.h"
#import "GameOverScene.h"

@implementation GameViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GameScene *scene = (GameScene *)[SKScene nodeWithFileNamed:@"GameScene"];
    scene.scaleMode  = SKSceneScaleModeAspectFill;
    SKView *skView   = (SKView *)self.view;
    
    [skView presentScene:scene];
    
    //如果收到 GameScene 的"游戏成功"的消息, 就呈现游戏结束 Scene
    scene.block = ^(BOOL allMatched) {
        
        if (allMatched) {
            GameOverScene *gameOverScene = [GameOverScene sceneWithSize:
                                            [UIScreen mainScreen].bounds.size];
            [gameOverScene setScaleMode:SKSceneScaleModeAspectFill];
            [skView presentScene:gameOverScene];
        }
    };
    
    //skView.showsFPS       = YES;
    //skView.showsNodeCount = YES;
}


- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
