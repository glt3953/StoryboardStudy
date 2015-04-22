//
//  ViewController.m
//  StoryboardStudy
//
//  Created by ningxia on 15/4/21.
//  Copyright (c) 2015年 ningxia. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"

@interface ViewController () <UITableViewDataSource, UITextViewDelegate>

@property (assign) NSInteger rowCount;
@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _rowCount = 10;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"customCell"];
    cell.cellIndex = indexPath;
    cell.cellBlock = ^(BOOL isDelete, NSIndexPath *index) {
        if (isDelete) {
            [_mTableView beginUpdates];
            _rowCount--;
            [_mTableView deleteRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationRight];
            [_mTableView endUpdates];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_mTableView reloadData];
            });
        }
    };
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
