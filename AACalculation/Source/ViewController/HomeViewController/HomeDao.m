//
//  HomeDao.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "HomeDao.h"
#import "ActivityModel.h"
#import "PersonsModel.h"
#import "PayModel.h"

@implementation HomeDao
+(NSArray *)homelist{
    NSString *select = [NSString stringWithFormat:@"select * from %@;",[ActivityModel tActivity]];
    FMResultSet *resultSet = [[FMDBManager sharedInstance] executeQuery:select];
        //遍历结果集合
    NSMutableArray *results = [[NSMutableArray alloc] initWithCapacity:10];
    while ([resultSet  next])
        {
            ActivityModel *model = [[ActivityModel alloc] init];
            [model fillFMResultSet:resultSet];
            [results addObject:model];
        }
    
    return [results copy];
}

+(BOOL)insertActivity:(ActivityModel *)model{
    model.time = @([[NSDate date] timeIntervalSince1970]);
    NSString *insert = [NSString stringWithFormat:@"INSERT INTO %@ (name, time) VALUES (\"%@\", %@);", [ActivityModel tActivity],model.name, model.time];
    BOOL result  = [[FMDBManager sharedInstance] executeUpdate:insert];
    if (!result) {
        return NO;
    }
    NSString *queryStr = [NSString stringWithFormat:@"select sid from %@ where name=\"%@\"",[ActivityModel tActivity],model.name];
    FMResultSet *resultSet = [[FMDBManager sharedInstance] executeQuery:queryStr];
    while ([resultSet next]) {
        model.sid = [resultSet objectForColumnName:@"sid"];
        NSLog(@"sid = %@",model.sid);
        break;
    }
    
    if (model.sid == nil) {
        return NO;
    }
    
    [[self class] initPersonsAndPayForSid:model.sid];
    //创建附属表PersonsModel
    result = [[FMDBManager sharedInstance] createTableWithQuery:[PersonsModel queryStringForCreateWithMark:model.sid.stringValue]];
    if (!result) {
        return NO;
    }
    result = [[FMDBManager sharedInstance] createTableWithQuery:[PayModel queryStringForCreateWithMark:model.sid.stringValue]];
    if (!result) {
        return NO;
    }
    
    return result;
}

+(BOOL)deleteActivity:(ActivityModel *)model{
    NSString *deleteActivity = [NSString stringWithFormat:@"delete from %@ where sid = %@", [ActivityModel tActivity],model.sid];
    NSString *deletePerson = [NSString stringWithFormat:@"delete from %@", [PersonsModel tPersonsWithMark:model.sid.stringValue]];
    NSString *deletePay = [NSString stringWithFormat:@"delete from %@", [PayModel tPayWithMark:model.sid.stringValue]];
    
   BOOL result = [[FMDBManager sharedInstance] executeUpdate:deletePerson];
    if (!result) {
//        return NO;
    }
    result =  [[FMDBManager sharedInstance] executeUpdate:deletePay];
    if (!result) {
//        return NO;
    }
    
    result = [[FMDBManager sharedInstance] executeUpdate:deleteActivity];
    if (!result) {
//        return NO;
    }
    
    return YES;
    
}

+(void)initPersonsAndPayForSid:(NSNumber *)sid{
    NSString *deletePerson = [NSString stringWithFormat:@"delete from %@", [PersonsModel tPersonsWithMark:sid.stringValue]];
    NSString *deletePay = [NSString stringWithFormat:@"delete from %@", [PayModel tPayWithMark:sid.stringValue]];
    
    BOOL result = [[FMDBManager sharedInstance] executeUpdate:deletePerson];
    if (!result) {
        //        return NO;
    }
    result =  [[FMDBManager sharedInstance] executeUpdate:deletePay];
    if (!result) {
        //        return NO;
    }

}
@end
