//
//  PayModel.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PayModel.h"

@implementation PayModel
+(NSString *)queryStringForCreateWithMark:(NSString *)mark{
    NSString *pay = [[self class] tPayWithMark:mark];
    NSString *t_pay_create =[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (sid integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, money integer NOT NULL,payPersonSid integer NOT NULL, payPersonName text NOT NULL, time text NOT NULL, referPersonsSid text NOT NULL)", pay];
    return t_pay_create;
}
+(NSString *)tPayWithMark:(NSString *)mark{
    const NSString *t_Persons = @"t_Pay";
    return [NSString stringWithFormat:@"%@_%@",t_Persons,mark];
}
-(void)fillFMResultSet:(FMResultSet *)resultSet{
    self.sid = [resultSet objectForColumnName:@"sid"];
    self.name = [resultSet objectForColumnName:@"name"];
    self.payPersonSid = [resultSet objectForColumnName:@"payPersonSid"];
    self.payPersonName = [resultSet objectForColumnName:@"payPersonName"];
}
@end
