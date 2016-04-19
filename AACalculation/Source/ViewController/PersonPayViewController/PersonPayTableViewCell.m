//
//  PersonPayTableViewCell.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PersonPayTableViewCell.h"
#import "PayModel.h"

@implementation PersonPayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setPayModel:(PayModel *)payModel{
    _payModel = payModel;
    if (payModel.isSelfPayStyle) {
        self.moneyLabel.textColor = [UIColor redColor];
    }else{
        self.moneyLabel.textColor = [UIColor blackColor];
    }
    
    self.moneyLabel.text = [NSString stringWithFormat:@"%.2f",_payModel.money.floatValue];
    self.contentLabel.text = _payModel.name;
}
@end
