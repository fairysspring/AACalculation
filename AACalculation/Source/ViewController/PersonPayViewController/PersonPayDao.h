//
//  PersonPayDao.h
//  AACalculation
//
//  Created by FairySong on 16/4/11.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonPayDao : NSObject
@property(nonatomic, strong)NSNumber *belongToActivitySid;
-(instancetype)initWithActivitySid:(NSNumber *)sid;
-(NSArray *)personPayList;//PersonPayDetail

@end

@class PersonsModel;
@interface PersonPayDetail : NSObject
@property(nonatomic, strong)PersonsModel *person;
@property(nonatomic, strong)NSNumber *money;
@property(nonatomic, strong)NSArray *referPay;//PayModel
@property(nonatomic, strong)NSArray *selfPay;//PayModel
@end