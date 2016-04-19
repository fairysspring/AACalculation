//
//  PersonsDao.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PersonsDao.h"
#import "PersonsModel.h"
#import "PayDao.h"
@interface PersonsDao()
@property(nonatomic, strong)PayDao *paydao;
@end
@implementation PersonsDao
-(instancetype)initWithBelongToActivitySid:(NSNumber *)sid{
    self = [super init];
    if (self) {
        self.belongToActivitySid = sid;
        self.paydao = [[PayDao alloc] initWithActivitySid:sid];
    }
    return self;
}
-(NSArray *)persons{
    NSString *select = [NSString stringWithFormat:@"select * from %@;",[PersonsModel tPersonsWithMark:self.belongToActivitySid.stringValue]];
    FMResultSet *resultSet = [[FMDBManager sharedInstance] executeQuery:select];
    //遍历结果集合
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:10];
    while ([resultSet  next])
    {
        PersonsModel *model = [[PersonsModel alloc] init];
        [model fillFMResultSet:resultSet];
        [results addObject:model];
    }
    
    return [results copy];
}

-(NSArray *)personsListWithPersonSidArray:(NSArray *)personSidArray{
    NSMutableString *partWhere = [[NSMutableString alloc] initWithCapacity:50];
    for (int i = 0;  i < personSidArray.count; i++) {
        NSString *theSid = personSidArray[i];
        if (i == personSidArray.count-1) {
            [partWhere appendFormat:@"sid=%@",theSid];
        }else{
            [partWhere appendFormat:@"sid=%@ or ",theSid];
        }
    }
    
    if (partWhere.length == 0) {
        return nil;
    }
    
    NSString *select = [NSString stringWithFormat:@"select * from %@ where %@;",[PersonsModel tPersonsWithMark:self.belongToActivitySid.stringValue],partWhere];
    FMResultSet *resultSet = [[FMDBManager sharedInstance] executeQuery:select];
    //遍历结果集合
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:10];
    while ([resultSet  next])
    {
        PersonsModel *model = [[PersonsModel alloc] init];
        [model fillFMResultSet:resultSet];
        [results addObject:model];
    }
    
    return [results copy];
}
-(BOOL)addPerson:(PersonsModel *)model{
    if (model.name == nil || model.name.length == 0) {
        return NO;
    }
    NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (name) VALUES (\"%@\");", [PersonsModel tPersonsWithMark:self.belongToActivitySid.stringValue],model.name];
    BOOL result  = [[FMDBManager sharedInstance] executeUpdate:insert];
    if (!result) {
        return NO;
    }
    return YES;
}
-(BOOL)deletePerson:(PersonsModel *)model{
    
    NSArray *exitPayArray = [self.paydao payListForPerson:model.sid];
    if (exitPayArray.count != 0) {
        return NO;
    }
    
     NSString *deletePerson = [NSString stringWithFormat:@"delete from %@ where sid = %@", [PersonsModel tPersonsWithMark:self.belongToActivitySid.stringValue],model.sid];
    BOOL result = [[FMDBManager sharedInstance] executeUpdate:deletePerson];
    if (!result) {
        return NO;
    }
    
    return YES;
}
@end
