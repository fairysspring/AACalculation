//
//  PersonTableViewCell.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonsModel;
@interface PersonTableViewCell : MGSwipeTableCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong)PersonsModel *model;
@end
