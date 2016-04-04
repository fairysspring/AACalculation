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
}
-(void)setupPay{
    self.wPay = [ActivityDetailItemView activityDetailItemView];
    self.wPay.titleLabel.text = @"花销列表";
    self.wPay.contentLabel.text = @"¥2000";
}
-(void)setupPerPersonPay{
    self.wPersonPay = [ActivityDetailItemView activityDetailItemView];
    self.wPersonPay.titleLabel.text = @"个人花销明细";
    self.wPersonPay.contentLabel.text = @"";
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
