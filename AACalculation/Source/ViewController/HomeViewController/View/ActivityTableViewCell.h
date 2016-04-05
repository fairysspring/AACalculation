//
//  ActivityTableViewCell.h
//  AACalculation
//
//  Created by FairySong on 16/4/4.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ActivityModel;
@interface ActivityTableViewCell : MGSwipeTableCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong)ActivityModel *model;
@end
