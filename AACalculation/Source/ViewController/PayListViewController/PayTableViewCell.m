//
//  PayTableViewCell.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PayTableViewCell.h"
#import "PayModel.h"
#import "PersonsViewController.h"

@implementation PayTableViewCell

- (void)awakeFromNib {
    MGSwipeButton *deleteButton = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]];
    deleteButton.width = 80;
    self.rightButtons = @[deleteButton];
}
-(void)setModel:(PayModel *)model{
    _model = model;
    self.contentLabel.text = model.name;
    self.payNumberLabel.text = [NSString stringWithFormat:@"¥%.2f",model.money.floatValue];
    self.payPerson.text = model.payPersonName;
    self.timeLabel.text = model.time.stringValue;
}

- (IBAction)tapReferPersons:(id)sender {
    //参与的人
    self.tapReferPersonsBlock(self.model.referPersonsSidArray);
    
}

@end
