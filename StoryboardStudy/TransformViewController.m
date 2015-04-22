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
@property (nonatomic) double angle;//angle角度

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
    
    [self sortArray];
}

//数组排序例程
- (void)sortArray {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"abd", @"abc", @"acd", @"ad1", @"ac2", nil];
    array = [NSMutableArray arrayWithObjects:@"-10.01", @"0.98", @"1.32", @"-0.21", @"-0.0", nil];
    // 升序
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1, __strong id obj2) {
        NSString *str1 = (NSString *)obj1;
        NSString *str2 = (NSString *)obj2;
        return [str1 compare:str2];
    }];
    NSLog(@"升序：%@", [array debugDescription]);
    
    // 降序
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1, __strong id obj2){
        NSString *str1 = (NSString *)obj1;
        NSString *str2 = (NSString *)obj2;
        return [str2 compare:str1];
    }];
    NSLog(@"降序：%@", [array debugDescription]);
    
    //创建人
    NSMutableArray *users = [NSMutableArray arrayWithObjects:@{@"pinyin":@"ceshishouji2"}, @{@"pinyin":@"fuwei"}, @{@"pinyin":@"congyushuai"}, @{@"pinyin":@"zhoubo"}, @{@"pinyin":@"jeff"}, @{@"pinyin":@"ceshishouji1"}, nil];
    //按照字母升序排列
    NSSortDescriptor * sortByKey = [NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES];
    [users sortUsingDescriptors:[NSArray arrayWithObject:sortByKey]];
}

- (void)transformAction {
    _angle = _angle + 0.01;
    //大于 M_PI*2(360度) 角度再次从0开始
    if (_angle > M_PI * 2) {
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
