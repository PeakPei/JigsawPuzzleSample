//游戏运行时的 Scene
#import <SpriteKit/SpriteKit.h>

typedef void(^GameSceneBlock)(BOOL allMatched);

@interface GameScene : SKScene

/** 如果游戏都拼对了,传递结束消息给 Controller */
@property (nonatomic, strong) GameSceneBlock block;

@end
