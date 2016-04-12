//
//  PersonPayViewController.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "BaseViewController.h"

@interface PersonPayViewController : BaseViewController
@property(nonatomic, strong)NSNumber *activitiSid;
-(instancetype)initWithActivitySid:(NSNumber *)activitiSid;
@end
