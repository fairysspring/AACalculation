//
//  PayListViewController.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "BaseViewController.h"

@interface PayListViewController : BaseViewController
@property(nonatomic, strong)NSNumber *activitySid;
-(instancetype)initWithActivitySid:(NSNumber *)sid;
@end
