//
//  ActivityModel.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "ActivityModel.h"

@implementation ActivityModel
-(void)fillFMResultSet:(FMResultSet *)resultSet{
    self.sid = [resultSet objectForColumnName:@"sid"];
    self.name = [resultSet objectForColumnName:@"name"];
    self.time = [resultSet objectForColumnName:@"time"];
//    self.personslist = [resultSet objectForColumnName:@"personslist"];
//    self.paylist = [resultSet objectForColumnName:@"paylist"];
}

+(NSString *)queryStringForCreate{
    NSString *t_activity_create = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (sid integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, time NSDate NOT NULL)", [[self class] tActivity]];
    return t_activity_create;
}
+(NSString *)tActivity{
    return @"t_Activity";
}
@end
