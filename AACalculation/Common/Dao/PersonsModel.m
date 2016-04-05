//
//  PersonsModel.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PersonsModel.h"

@implementation PersonsModel
+(NSString *)queryStringForCreateWithMark:(NSString *)mark{
    NSString *persons = [[self class] tPersonsWithMark:mark];
    NSString *t_persons_create =[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (sid integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL)", persons];
    return t_persons_create;
}
+(NSString *)tPersonsWithMark:(NSString *)mark{
    const NSString *t_Persons = @"t_Persons";
    return [NSString stringWithFormat:@"%@_%@",t_Persons,mark];
}

-(void)fillFMResultSet:(FMResultSet *)resultSet{
    self.sid = [resultSet objectForColumnName:@"sid"];
    self.name = [resultSet objectForColumnName:@"name"];
}
@end
