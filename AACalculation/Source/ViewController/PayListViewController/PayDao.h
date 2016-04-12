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
-(NSArray *)payListForPerson:(NSNumber *)personSid;
/**
 *  付款项
 *
 *  @param personSid <#personSid description#>
 *
 *  @return <#return value description#>
 */
-(NSArray *)payByPerson:(NSNumber *)personSid;
-(BOOL)addPay:(PayModel *)model;
-(BOOL)deletePay:(PayModel *)model;

@end
