//
//  ActivityDetailItemView.h
//  AACalculation
//
//  Created by FairySong on 16/4/4.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityDetailItemView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property(nonatomic, copy)void(^tapBlock)();
+(ActivityDetailItemView *)activityDetailItemView;
@end
