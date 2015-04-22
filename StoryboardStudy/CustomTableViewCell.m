//
//  CustomTableViewCell.m
//  StoryboardStudy
//
//  Created by ningxia on 15/4/21.
//  Copyright (c) 2015年 ningxia. All rights reserved.
//

#import "CustomTableViewCell.h"

@interface CustomTableViewCell ()

@property (strong, nonatomic) UIView *snapView;

@end

@implementation CustomTableViewCell

- (void)awakeFromNib {
    _containerView.layer.cornerRadius = 4;
    
    _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
    _shadowView.layer.shadowOffset = CGSizeMake(2, 2);
    _shadowView.layer.shadowOpacity = 0.5;
    _shadowView.layer.shadowRadius = 5;
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongpressGesture:)];
    [self.contentView addGestureRecognizer:longPress];
    
}

- (void)handleLongpressGesture:(UILongPressGestureRecognizer *)gesture {
    CGPoint startPoint = CGPointZero;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            //创建一个复合视图的快照，BOOL类型的参数表示是否立即生成快照，还是在需要更新视图的时候生成（设置No会立即生成快照，并不会调用重新设置颜色的方法）
            _snapView = [_containerView snapshotViewAfterScreenUpdates:NO];
            startPoint = [gesture locationInView:self.contentView];
            //重设layer锚点
            _snapView.layer.anchorPoint = CGPointMake(startPoint.x / _snapView.layer.frame.size.width - 0.1, startPoint.y / _snapView.layer.frame.size.height - 0.1);
            _snapView.frame = _containerView.frame;
            /*关于M_PI
             #define M_PI     3.14159265358979323846264338327950288
             其实它就是圆周率的值，在这里代表弧度，相当于角度制 0-360 度，M_PI=180度
             旋转方向为：顺时针旋转
            */
            _snapView.transform = CGAffineTransformMakeRotation(M_PI / 30);
            [self.contentView addSubview:_snapView];
            self.containerView.hidden = YES;
            self.shadowView.hidden = YES;
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            CGPoint changePoint = [gesture locationInView:self.contentView];
            [UIView animateWithDuration:0.05 animations:^{
                _snapView.layer.position = changePoint;
            }];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            NSLog(@"ended");
            CGPoint endPoint = [gesture locationInView:self.contentView];
            if (endPoint.x > self.contentView.bounds.size.width - 50) {
                if (self.cellBlock) {
                    self.cellBlock(YES, _cellIndex);
                }
            } else {
                if (self.cellBlock) {
                    self.cellBlock(NO, _cellIndex);
                }
            }
            [_snapView removeFromSuperview];
            self.containerView.hidden = NO;
            self.shadowView.hidden = NO;
            
            break;
        }
        default:
            break;
    }
}

@end
