//
//  HomeDao.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ActivityModel;

@interface HomeDao : NSObject
/**
 *  获取创建的活动对象数组
 *
 *  @return 活动的对象数组
 */
+(NSArray *)homelist;
/**
 *  只需要输入sid 和 name
 *
 *  @param model 活动的对象
 *
 *  @return 是否创建成功
 */
+(BOOL)insertActivity:(ActivityModel *)model;
/**
 *  删除活动
 *
 *  @param model <#model description#>
 *
 *  @return <#return value description#>
 */
+(BOOL)deleteActivity:(ActivityModel *)model;
@end
