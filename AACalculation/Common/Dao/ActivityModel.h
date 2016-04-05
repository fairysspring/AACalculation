//
//  ActivityModel.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ActivityModel : NSObject
@property(nonatomic, strong)NSNumber *sid;
@property(nonatomic, strong)NSString *name;
@property(nonatomic, strong)NSNumber *time;
//@property(nonatomic, strong)NSString *personslist;
//@property(nonatomic, strong)NSString *paylist;

-(void)fillFMResultSet:(FMResultSet *)resultSet;
+(NSString *)queryStringForCreate;
+(NSString *)tActivity;
@end
