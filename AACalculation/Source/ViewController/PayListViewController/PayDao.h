//
//  PayDao.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class  PayModel;
@interface PayDao : NSObject
@property(nonatomic, strong)NSNumber *belongToActivitySid;
-(instancetype)initWithActivitySid:(NSNumber *)sid;

-(NSArray *)payList;
-(BOOL)addPay:(PayModel *)model;
-(BOOL)deletePay:(PayModel *)model;

@end
