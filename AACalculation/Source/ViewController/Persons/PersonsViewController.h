//
//  PersonsViewController.h
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "BaseViewController.h"
typedef NS_ENUM(NSInteger,PersonsViewShowStyle) {
    PersonsViewShowStyleNormal,
    PersonsViewShowStyleSelectedPayPerson,
    PersonsViewShowStyleSelectedReferPersons,
    PersonsViewShowStyleNormalLocal
    
};

@interface PersonsViewController : BaseViewController

@property(nonatomic, strong)NSNumber *activitySid;
@property(nonatomic, assign)PersonsViewShowStyle showStyle;
//||
/**
 *  当前已经被选择的单元
 */
@property(nonatomic, strong)NSArray *selectedSidArray;//NSNumber
/**
 *  付款人的sid
 */
@property(nonatomic, strong)NSNumber *payPersonSid;
/**
 *  付款人的姓名
 */
@property(nonatomic, strong)NSString *payPersonName;
/**
 *  选择列表点击确定时调用
 */
@property(nonatomic, copy)void (^selectedReferPersonsFinish)(NSArray *persons);
/**
 *  选择列表点击关闭时调用
 */
@property(nonatomic, copy)void (^selectedPayPersonsFinish)(NSNumber *payPerson,NSString *name);

//||
-(instancetype)initWithActivitySid:(NSNumber *)sid;

@property(nonatomic, strong)NSArray *personsSidArray;

@end
