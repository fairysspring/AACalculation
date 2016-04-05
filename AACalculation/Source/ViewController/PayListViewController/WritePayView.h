//
//  WritePayView.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PayModel;
@interface WritePayView : UIView

+(WritePayView *)writePayView;

@property(nonatomic, copy)void (^finishBlock)(PayModel *payModel);
@property(nonatomic, copy)void (^cancelBlock)();


@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@end
