//
//  PersonPayTableViewCell.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PayModel;
@interface PersonPayTableViewCell : UITableViewCell
@property(nonatomic, strong)PayModel *payModel;


@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@end
