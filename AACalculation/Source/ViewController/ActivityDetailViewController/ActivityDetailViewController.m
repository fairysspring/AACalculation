//
//  ActivityDetailViewController.m
//  AACalculation
//
//  Created by FairySong on 16/4/4.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "AAScrollView.h"
#import "ActivityDetailItemView.h"
#import "PayListViewController.h"
#import "PersonsViewController.h"
#import "PersonPayViewController.h"
#import "PersonsDao.h"
#import "PayDao.h"

@interface ActivityDetailViewController ()

@property(nonatomic, strong)AAScrollView *contentScrollView;
@property(nonatomic, strong)ActivityDetailItemView *wPersons;
@property(nonatomic, strong)ActivityDetailItemView *wPay;
@property(nonatomic, strong)ActivityDetailItemView *wPersonPay;

@property(nonatomic, strong)PersonsDao *personsDao;
@property(nonatomic, strong)PayDao *payDao;
@end

@implementation ActivityDetailViewController

-(instancetype)initWithActivitySid:(NSNumber *)sid{
    self = [super init];
    if (self) {
        self.activitySid = sid;
        self.personsDao = [[PersonsDao alloc] initWithBelongToActivitySid:sid];
        self.payDao = [[PayDao alloc] initWithActivitySid:sid];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}
-(void)setup{
    
    self.contentScrollView = [[AAScrollView alloc] initWithFrame:CGRectMake(0, 0, AAScreenWidth, AAScreenHeight)];
    [self.view addSubview:self.contentScrollView];
    
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    
    [self setupPersons];
    [self setupPay];
    [self setupPerPersonPay];
    [self.contentScrollView addToContentSubview:self.wPersons];
    [self.contentScrollView addToContentSubview:self.wPay];
    [self.contentScrollView addToContentSubview:self.wPersonPay];
}

-(void)setupPersons{
    
    NSArray *persons = [self.personsDao persons];
    self.wPersons = [ActivityDetailItemView activityDetailItemView];
    self.wPersons.titleLabel.text = @"参与人";
    self.wPersons.contentLabel.text = [NSString stringWithFormat:@"%lu人",(unsigned long)persons.count];
    WS();
    self.wPersons.tapBlock = ^(){
        PersonsViewController *vc = [[PersonsViewController alloc] initWithActivitySid:weakself.activitySid];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
}
-(void)setupPay{
    NSNumber *allPay = [self.payDao allPayMoney];
    self.wPay = [ActivityDetailItemView activityDetailItemView];
    self.wPay.titleLabel.text = @"花销列表";
    self.wPay.contentLabel.text = [NSString stringWithFormat:@"总花费(%.2f元)",allPay.floatValue];
    WS();
    self.wPay.tapBlock = ^(){
        PayListViewController *vc = [[PayListViewController alloc] initWithActivitySid:weakself.activitySid];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
}
-(void)setupPerPersonPay{
    self.wPersonPay = [ActivityDetailItemView activityDetailItemView];
    self.wPersonPay.titleLabel.text = @"个人花销明细";
    self.wPersonPay.contentLabel.text = @"";
    WS();
    self.wPersonPay.tapBlock = ^(){
        PersonPayViewController *vc = [[PersonPayViewController alloc] initWithActivitySid:weakself.activitySid];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
}


@end
