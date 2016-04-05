//
//  FMDBManager.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBManager : NSObject
+ (instancetype)sharedInstance;
@property(nonatomic, strong)FMDatabase *dataBase;

- (FMResultSet *)executeQuery:(NSString*)sql;
- (BOOL)executeUpdate:(NSString*)sql;
-(BOOL)createTableWithQuery:(NSString *)query;
@end
