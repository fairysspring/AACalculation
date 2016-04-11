//
//  PayModel.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayModel : NSObject
@property(nonatomic, strong)NSNumber *sid;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSNumber *money;
@property(nonatomic, strong)NSNumber *payPersonSid;
@property(nonatomic, strong)NSString *payPersonName;
@property(nonatomic, strong)NSNumber *time;
@property(nonatomic, strong)NSString *referPersonsSid;

-(void)fillFMResultSet:(FMResultSet *)resultSet;

+(NSString *)queryStringForCreateWithMark:(NSString *)mark;
+(NSString *)tPayWithMark:(NSString *)mark;
-(NSArray *)referPersonsSidArray;
@end
