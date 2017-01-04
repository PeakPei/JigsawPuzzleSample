#import <SpriteKit/SpriteKit.h>

typedef void(^PictureNodeBlock)(CGPoint position);

@interface PictureNode : SKSpriteNode

/** block 传递目前中心点 */
@property (nonatomic, strong) PictureNodeBlock block;

@end
