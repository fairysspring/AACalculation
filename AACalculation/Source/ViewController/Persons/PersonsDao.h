//
//  PersonsDao.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PersonsModel;
@interface PersonsDao : NSObject
@property(nonatomic, strong)NSNumber *belongToActivitySid;
-(instancetype)initWithBelongToActivitySid:(NSNumber *)sid;

-(NSArray *)persons;
-(NSArray *)personsListWithPersonSidArray:(NSArray *)personSidArray;
-(BOOL)addPerson:(PersonsModel *)model;
-(BOOL)deletePerson:(PersonsModel *)model;
@end
