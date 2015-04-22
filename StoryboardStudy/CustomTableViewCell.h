//
//  CustomTableViewCell.h
//  StoryboardStudy
//
//  Created by ningxia on 15/4/21.
//  Copyright (c) 2015年 ningxia. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^handleGestureEndedBlock)(BOOL isDelete, NSIndexPath *index);

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *shadowView;
@property (nonatomic, strong) NSIndexPath *cellIndex;
@property (nonatomic, copy) handleGestureEndedBlock cellBlock;


@end
