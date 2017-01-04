#import "PictureNode.h"

@implementation PictureNode {
    CGPoint touchPoint;
    CGPoint startPoint;
}

//点击开始, 获取点击点的位置和图片的起始位置
- (void)touchesBegan: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event {
    
    touchPoint = [[touches anyObject] locationInNode:self.scene];
    startPoint = self.position;
}

//按住移动, 实现图片随着点击点移动
- (void)touchesMoved: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event {
    
    CGPoint currentTouchPoint = [[touches anyObject] locationInNode:self.scene];
    CGFloat currentPositionX = startPoint.x + currentTouchPoint.x - touchPoint.x;
    CGFloat currentPositionY = startPoint.y + currentTouchPoint.y - touchPoint.y;
    
    self.position = CGPointMake(currentPositionX, currentPositionY);
}

//点击结束, 传递目前图片的 position 给Scene 进行吸附判断
- (void)touchesEnded: (NSSet<UITouch *> *)touches withEvent: (UIEvent *)event {
    
    if (self.block) {
        self.block(self.position);
    }
}

@end
