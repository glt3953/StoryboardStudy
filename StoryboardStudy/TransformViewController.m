//
//  TransformViewController.m
//  StoryboardStudy
//
//  Created by ningxia on 15/4/22.
//  Copyright (c) 2015年 ningxia. All rights reserved.
//

#import "TransformViewController.h"

@interface TransformViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *transformImageView;
@property (nonatomic) double angle;

@end

@implementation TransformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGAffineTransform transform= CGAffineTransformMakeRotation(M_PI * 0.38);
    /*关于M_PI
     #define M_PI     3.14159265358979323846264338327950288
     其实它就是圆周率的值，在这里代表弧度，相当于角度制 0-360 度，M_PI=180度
     旋转方向为：顺时针旋转
    */
    _transformImageView.transform = transform;//旋转
    
    _angle = 0;
    [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(transformAction) userInfo:nil repeats:YES];
}

- (void)transformAction {
    _angle = _angle + 0.01;//angle角度 double angle;
    if (_angle > M_PI * 2) {//大于 M_PI*2(360度) 角度再次从0开始
        _angle = 0;
    }
    
    CGAffineTransform transform = CGAffineTransformMakeRotation(_angle);
    _transformImageView.transform = transform;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
