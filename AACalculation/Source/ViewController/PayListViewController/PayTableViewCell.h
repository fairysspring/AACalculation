//
//  PayTableViewCell.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayModel;
@interface PayTableViewCell : MGSwipeTableCell
@property(nonatomic, strong)PayModel *model;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *payNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *payPerson;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIButton *referPersonsButton;

@end
