#import "GameScene.h"
#import "PictureNode.h"

@interface GameScene ()

/**  图片 Node 数组 */
@property (nonatomic, strong) NSMutableArray<PictureNode *> *pictureArray;
/** 框线 Node 数组 */
@property (nonatomic, strong) NSMutableArray<SKShapeNode *> *shapeArray;
/** 图片初始位置数组 */
@property (nonatomic, strong) NSMutableArray *picturePositionArray;

@end


@implementation GameScene

/* Scene 进行显示时调用的方法
    1. for 循环建立 框node数组, 图node数组, 图的初始位置数组
    2. 设置 图 node 的 block:
        A 实现吸附效果
        B 如果吸附框有图,则把已吸附的图还原到初始位置
        C 判断是否完成游戏
    3. 如果完成游戏, 调用 Scene 的 block 传消息给 Controller, 呈现游戏结束 Scene
 */
- (void)didMoveToView:(SKView *)view {
    
    //用 for 循环添加 node
    _shapeArray = [NSMutableArray new];
    
    for (int index = 0; index < 4; index ++) {
        
        NSString *nodeName = [NSString stringWithFormat:@"s%d",index];
        SKShapeNode *temp  = (SKShapeNode *)[self childNodeWithName:nodeName];
        
        [_shapeArray addObject:temp];
    }
    
    
    _picturePositionArray = [NSMutableArray new];
    _pictureArray         = [NSMutableArray new];
    
    for (int index = 0; index < 4; index ++) {
        
        NSString *nodeName = [NSString stringWithFormat:@"p%d",index];
        PictureNode *temp  = (PictureNode *)[self childNodeWithName:nodeName];
        //启用互动, 实现可点击
        temp.userInteractionEnabled = YES;
        //添加图片初始位置到数组
        [_picturePositionArray addObject:[NSValue valueWithCGPoint:temp.position]];
        
        temp.block = ^(CGPoint picturePosition) {
            
            //判断是否可以吸附
            for (SKNode *temp in self.shapeArray) {
                
                if ([self canAdsorb:self.pictureArray[index] and:temp]) {
                    
                    self.pictureArray[index].position = temp.position;
                    
                    //如果吸附框已有图, 把已有图还原到它的初始位置
                    for (int indexForBlock = 0; indexForBlock < 4; indexForBlock ++) {
                        
                        if (indexForBlock == index) {
                            continue;
                        }
                        SKNode   *pTemp           = self.pictureArray[indexForBlock];
                        NSString *pTempPosition   = NSStringFromCGPoint(pTemp.position);
                        NSString *tempPositionStr = NSStringFromCGPoint(temp.position);
                        
                        if ([pTempPosition isEqualToString:tempPositionStr]) {
                            pTemp.position = [_picturePositionArray[indexForBlock] CGPointValue];
                        }
                    }
                    
                    //判断是否已游戏成功, 成功则传值给 Controller
                    if (self.block) {
                        
                        int matchCount = 0;
                        
                        for (int matchIndex = 0; matchIndex < 4; matchIndex ++) {
                            
                            SKNode *matchNodeP = _pictureArray[matchIndex];
                            SKNode *matchNodeS = _shapeArray[matchIndex];
                            
                            if ([self canAdsorb:matchNodeP and:matchNodeS]) {
                                matchCount ++;
                            }
                        }
                        if (matchCount == 4) {
                            NSLog(@"send");
                            self.block(YES);
                        }
                    }
                }
            }
        };
        
        [_pictureArray addObject:temp];
    }
}

//计算距离, 是否满足吸附标准, 通过看两个 node 的 position 的 x 和 y 轴上的距离是否小于边长/2
- (BOOL)canAdsorb: (SKNode *)nodeA and: (SKNode *)nodeB {
    
    BOOL xIsClose = fabs(nodeA.position.x - nodeB.position.x) < nodeA.frame.size.width/2;
    BOOL yIsClose = fabs(nodeA.position.y - nodeB.position.y) < nodeA.frame.size.width/2;
    
    if (xIsClose && yIsClose) {
        return YES;
    }else{
        return NO;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    // Called before each frame is rendered
}

@end
