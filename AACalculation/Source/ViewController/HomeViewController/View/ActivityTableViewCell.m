//
//  ActivityTableViewCell.m
//  AACalculation
//
//  Created by FairySong on 16/4/4.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "ActivityTableViewCell.h"
#import "ActivityModel.h"

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
    MGSwipeButton *deleteButton = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor]];
    deleteButton.width = 80;
    self.rightButtons = @[deleteButton];
}

-(void)setModel:(ActivityModel *)model{
    _model = model;
    self.nameLabel.text = _model.name;
}




@end
