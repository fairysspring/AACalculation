//
//  PayDao.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PayDao.h"
#import "PayModel.h"

@implementation PayDao
-(instancetype)initWithActivitySid:(NSNumber *)sid{
    self = [super init];
    if (self) {
        self.belongToActivitySid = sid;
    }
    return self;
}

-(NSArray *)payList{
    NSString *select = [NSString stringWithFormat:@"select * from %@;",[PayModel tPayWithMark:self.belongToActivitySid.stringValue]];
    FMResultSet *resultSet = [[FMDBManager sharedInstance] executeQuery:select];
    //遍历结果集合
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:10];
    while ([resultSet  next])
    {
        PayModel *model = [[PayModel alloc] init];
        [model fillFMResultSet:resultSet];
        [results addObject:model];
    }
    
    return [results copy];

}
-(BOOL)addPay:(PayModel *)model{
    if (model.name == nil || model.name.length == 0) {
        return NO;
    }
    
    NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (name, money, payPersonSid, payPersonName, time, referPersonsSid) VALUES ('%@', '%@', %@,  '%@', %@, '%@');", [PayModel tPayWithMark:self.belongToActivitySid.stringValue],model.name, model.money, model.payPersonSid, model.payPersonName, model.time, model.referPersonsSid];
    BOOL result  = [[FMDBManager sharedInstance] executeUpdate:insert];
    if (!result) {
        return NO;
    }
    return YES;
}
-(BOOL)deletePay:(PayModel *)model{
    NSString *deletePerson = [NSString stringWithFormat:@"delete from %@ where sid = %@", [PayModel tPayWithMark:self.belongToActivitySid.stringValue],model.sid];
    BOOL result = [[FMDBManager sharedInstance] executeUpdate:deletePerson];
    if (!result) {
        return NO;
    }
    
    return YES;
}
@end
