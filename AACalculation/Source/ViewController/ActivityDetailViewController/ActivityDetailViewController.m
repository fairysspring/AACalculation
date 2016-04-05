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

@interface ActivityDetailViewController ()
@property(nonatomic, strong)AAScrollView *contentScrollView;
@property(nonatomic, strong)ActivityDetailItemView *wPersons;
@property(nonatomic, strong)ActivityDetailItemView *wPay;
@property(nonatomic, strong)ActivityDetailItemView *wPersonPay;
@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}
-(void)setup{
    self.title = @"活动1";
    
    self.contentScrollView = [[AAScrollView alloc] initWithFrame:CGRectMake(0, 0, AAScreenWidth, AAScreenHeight)];
    [self.view addSubview:self.contentScrollView];
    
    self.contentScrollView.backgroundColor = [UIColor redColor];
    
    [self setupPersons];
    [self setupPay];
    [self setupPerPersonPay];
    [self.contentScrollView addToContentSubview:self.wPersons];
    [self.contentScrollView addToContentSubview:self.wPay];
    [self.contentScrollView addToContentSubview:self.wPersonPay];
}

-(void)setupPersons{
    self.wPersons = [ActivityDetailItemView activityDetailItemView];
    self.wPersons.titleLabel.text = @"参与人";
    self.wPersons.contentLabel.text = @"18个";
    WS();
    self.wPersons.tapBlock = ^(){
        PersonsViewController *vc = [[PersonsViewController alloc] initWithActivitySid:@(22)];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
}
-(void)setupPay{
    self.wPay = [ActivityDetailItemView activityDetailItemView];
    self.wPay.titleLabel.text = @"花销列表";
    self.wPay.contentLabel.text = @"¥2000";
    WS();
    self.wPay.tapBlock = ^(){
        PayListViewController *vc = [[PayListViewController alloc] initWithActivitySid:@(22)];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
}
-(void)setupPerPersonPay{
    self.wPersonPay = [ActivityDetailItemView activityDetailItemView];
    self.wPersonPay.titleLabel.text = @"个人花销明细";
    self.wPersonPay.contentLabel.text = @"";
    WS();
    self.wPersonPay.tapBlock = ^(){
        PersonPayViewController *vc = [[PersonPayViewController alloc] init];
        [weakself.navigationController pushViewController:vc animated:YES];
    };
}


@end
