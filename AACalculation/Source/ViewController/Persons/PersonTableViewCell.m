//
//  PersonTableViewCell.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PersonTableViewCell.h"
#import "PersonsModel.h"

@implementation PersonTableViewCell

- (void)awakeFromNib {
    MGSwipeButton *deleteButton = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]];
    deleteButton.width = 80;
    self.rightButtons = @[deleteButton];
}

-(void)setModel:(PersonsModel *)model{
    _model = model;
    self.nameLabel.text = _model.name;
    if (_model.isSelected) {
        self.nameLabel.textColor = [UIColor redColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
    }
}

@end
