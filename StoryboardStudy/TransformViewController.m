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
    
    [self sortedArray];
    [self filteredArray];
}

//数组过滤例程
- (void)filteredArray {
    //需要去掉的元素数组
    NSMutableArray *filteredArray = [[NSMutableArray alloc]initWithObjects:@"1", @"4", nil];
    //需要被筛选的数组
    NSMutableArray *dataArray = [[NSMutableArray alloc]initWithObjects:@"1", @"2", @"1", @"4", @"6", @"1", @"1", @"4", @"1", @"6", @"4", nil];
    
    /*
     方法一：利用NSPredicate
     注：NSPredicate所属Cocoa框架，在密码、用户名等正则判断中经常用到。
     类似于SQL语句
     NOT 不是
     SELF 代表字符串本身
     IN 范围运算符
     那么NOT (SELF IN %@) 意思就是：不是这里所指定的字符串的值
    */
    NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", filteredArray];
    //过滤数组
    NSArray *reslutFilteredArray = [dataArray filteredArrayUsingPredicate:filterPredicate];
    NSLog(@"Reslut Filtered Array = %@", reslutFilteredArray);
    /*
     结果：
     Reslut Filtered Array = (
     2,
     6,
     6
     )
    */
    
    /*
     方法二：从后往前遍历数组，然后匹配删除
    */
    int i = (int)[dataArray count]-1;
    for(;i >= 0;i--){
        //containsObject 判断元素是否存在于数组中(根据两者的内存地址判断，相同：YES  不同：NO）
        if([filteredArray containsObject:[dataArray objectAtIndex:i]]) {
            [dataArray removeObjectAtIndex:i];
        }
    }
    NSLog(@"Data Array = %@", dataArray);
    /* 
     结果： 
     Data Array = ( 
     2, 
     6, 
     6 
     ) 
    */
}

//数组排序例程
- (void)sortedArray {
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"abd", @"abc", @"acd", @"ad1", @"ac2", nil];
//    array = [NSMutableArray arrayWithObjects:@"-10.01", @"0.98", @"1.32", @"-0.21", @"-0.0", nil];
    array = [NSMutableArray arrayWithObjects:@"65.165", @"600", @"-560.987", @"575.009", @"560", @"500", @"500", @"500", @"", @"450", @"40", @"3000", @"300", @"2750.75", @"2073.25", @"200000", @"-320.9", @"2000", @"2000", @"2000", @"200", @"-89", @"200", @"143832.7914", @"117", @"1060", @"10000", @"1000", @"1000", @"1000", @"", nil];
    // 升序
    [array sortUsingComparator:^NSComparisonResult(__strong id obj1, __strong id obj2) {
//        NSString *str1 = (NSString *)obj1;
//        NSString *str2 = (NSString *)obj2;
//        return [str1 compare:str2];
        double num1 = [obj1 doubleValue];//NSString类型的必须转为double才可以正确排序
        double num2 = [obj2 doubleValue];
        return num1 > num2;
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
    NSSortDescriptor *sortByKey = [NSSortDescriptor sortDescriptorWithKey:@"pinyin" ascending:YES];
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
