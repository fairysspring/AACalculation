//
//  PersonPayDao.m
//  AACalculation
//
//  Created by FairySong on 16/4/11.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PersonPayDao.h"
#import "PersonsModel.h"
#import "PayDao.h"
#import "PersonsDao.h"
#import "PayModel.h"
#import "PersonsModel.h"

@interface PersonPayDao()
@property(nonatomic, strong)PayDao *paydao;
@property(nonatomic, strong)PersonsDao *persondao;
@end
@implementation PersonPayDao

-(instancetype)initWithActivitySid:(NSNumber *)sid{
    self = [super init];
    if (self) {
        self.belongToActivitySid = sid;
        self.paydao = [[PayDao alloc] initWithActivitySid:sid];
        self.persondao = [[PersonsDao alloc] initWithBelongToActivitySid:sid];
    }
    return self;
}
-(NSArray *)personPayList{
    NSMutableArray *payPersons = [[NSMutableArray alloc] initWithCapacity:10];
    for(PersonsModel *thePerson in [self.persondao persons]){
        //个人参与的项目
        NSArray *payForPerson = [self.paydao payListForPerson:thePerson.sid];
        int allMoney = 0;
        for (PayModel *thePay in payForPerson) {
            allMoney += thePay.money.integerValue;
        }
        //个人付款的项目
        NSArray *payByPerson = [self.paydao payByPerson:thePerson.sid];
        int allMoneyByPerson = 0;
        for (PayModel *thePayByPerson in payByPerson) {
            allMoneyByPerson += thePayByPerson.money.integerValue;
        }
        //需要付款
        int moneyToPay = (allMoney-allMoneyByPerson);
        
        PersonPayDetail *detail = [[PersonPayDetail alloc] init];
        detail.person = thePerson;
        detail.money = @(moneyToPay);
        detail.referPay = payForPerson;
        detail.selfPay = payByPerson;
        [payPersons addObject:detail];
    }
    
    NSLog(@"person pay list %@",payPersons);
    return payPersons;
}


@end

@implementation PersonPayDetail

@end
