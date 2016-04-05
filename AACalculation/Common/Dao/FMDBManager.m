//
//  FMDBManager.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "FMDBManager.h"
#import "ActivityModel.h"

static FMDBManager* _instance;
@interface FMDBManager()


@end
@implementation FMDBManager

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone
{
    return _instance;
}

-(FMDatabase *)dataBase{
    if (!_dataBase) {
        NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
        
        NSString *fileName = [doc stringByAppendingPathComponent:@"AACalculation.sqlite"];
        NSLog(@"db path %@",fileName);
        _dataBase = [FMDatabase databaseWithPath:fileName];
    }
    
    return _dataBase;
    
}

-(BOOL)openDB{
    BOOL result = [self.dataBase open];
    if (result)
    {
        //todo
        result = [self createTableWithQuery:[ActivityModel queryStringForCreate]];
        if (!result) {
            NSLog(@"activity table error %@", _dataBase.lastError);
        }
    }else{
        NSLog(@"open DB error %@", _dataBase.lastError);
    }
    return result;
}

-(BOOL)createTableWithQuery:(NSString *)query{
    BOOL result = [_dataBase executeUpdate:query];
    if (result)
    {
//        NSLog(@"!创建表成功%@",query);
    }else{
        NSLog(@"create tables%@ error = %@",query,[_dataBase lastErrorMessage]);
    }
    
    return result;
}

-(void)closeDB{
    if(![_dataBase close]){
        NSLog(@"close error = %@", [_dataBase lastErrorMessage]);
    }
}


- (FMResultSet *)executeQuery:(NSString*)sql{
    BOOL result = [self openDB];
    if (!result) {
        NSLog(@"open error %@",[self.dataBase lastError]);
    }
    
    FMResultSet *set = [self.dataBase executeQuery:sql];
    if (!set) {
        NSLog(@"query:%@ error%@",sql,[self.dataBase lastError]);
    }
    return set;
}

- (BOOL)executeUpdate:(NSString*)sql{
    BOOL result = [self openDB];
    if (!result) {
        NSLog(@"open error %@",[self.dataBase lastError]);
        return result;
    }
    
    result = [self.dataBase executeUpdate:sql];
    if (!result) {
        NSLog(@"update sql %@ \n error %@",sql, self.dataBase.lastError);
    }
    
    return result;
}

@end
