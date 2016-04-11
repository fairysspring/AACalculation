//
//  PersonsModel.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PersonsModel : NSObject
@property(nonatomic, strong)NSNumber *sid;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, assign)BOOL isSelected;

-(void)fillFMResultSet:(FMResultSet *)resultSet;

+(NSString *)queryStringForCreateWithMark:(NSString *)mark;
+(NSString *)tPersonsWithMark:(NSString *)mark;
@end