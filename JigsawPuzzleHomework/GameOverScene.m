#import "GameOverScene.h"

@implementation GameOverScene

- (instancetype)initWithSize: (CGSize)size {
    self = [super initWithSize:size];
    self.backgroundColor = [UIColor blackColor];
    return self;
}


//创建 Label
- (void)didMoveToView: (SKView *)view {
    
    SKLabelNode *label = [[SKLabelNode alloc] initWithFontNamed:@"Marker Felt"];
    label.text         = @"You Win!";
    label.fontColor    = [UIColor greenColor];
    label.position     = self.view.center;
    
    [self addChild:label];
}



@end
