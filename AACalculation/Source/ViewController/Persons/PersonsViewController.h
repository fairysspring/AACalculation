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
    PersonsViewShowStyleSelectedReferPersons
};

@interface PersonsViewController : BaseViewController

@property(nonatomic, strong)NSNumber *activitySid;
@property(nonatomic, assign)PersonsViewShowStyle showStyle;
@property(nonatomic, copy)void (^selectedReferPersonsFinish)(NSArray *persons);
@property(nonatomic, copy)void (^selectedPayPersonsFinish)(NSNumber *payPerson,NSString *name);

-(instancetype)initWithActivitySid:(NSNumber *)sid;

@property(nonatomic, strong)NSArray *selectedSidArray;//NSNumber
@property(nonatomic, strong)NSNumber *payPersonSid;
@property(nonatomic, strong)NSString *payPersonName;

@end
