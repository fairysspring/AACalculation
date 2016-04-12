//
//  PersonPayViewController.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PersonPayViewController.h"
#import "AABigListView.h"
#import "PersonPayTableViewCell.h"
#import "PersonPayDao.h"
#import "PayModel.h"
#import "PersonsModel.h"

@interface PersonPayViewController ()<UITableViewDataSource, UITableViewDelegate, AABigListViewDelegate>
@property(nonatomic, strong)AABigListView *listView;
@property(nonatomic, strong)PersonPayDao *personPayDao;
@property(nonatomic, strong)NSArray *personsPayArray;
@end

@implementation PersonPayViewController
-(instancetype)initWithActivitySid:(NSNumber *)activitiSid{
    self = [super init];
    if (self) {
        self.activitiSid = activitiSid;
        self.personPayDao = [[PersonPayDao alloc] initWithActivitySid:self.activitiSid];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup
{
//    self.navigationItem.rightBarButtonItem = nil;[[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addActivity:)];
    
    //view
    self.view.backgroundColor = [UIColor redColor];
    //listview
    self.listView = [[AABigListView alloc] init];
    [self.view addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _listView.tableView.dataSource = self;
    _listView.tableView.delegate = self;
    _listView.listDelegate = self;
    
    
    _listView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.tableView.backgroundColor = [AAColorManager  colorForTest];
    
    [_listView.tableView registerNib:[UINib nibWithNibName:@"PersonPayTableViewCell" bundle:nil]
              forCellReuseIdentifier:@"cell"];
    [_listView loadData];
    
}

-(void)addActivity:(UIButton *)button{
    NSLog(@"add");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PersonPayDetail *personPayDetail = self.personsPayArray[section];
    return personPayDetail.referPay.count + personPayDetail.selfPay.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.personsPayArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonPayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    PersonPayDetail *personPayDetail = self.personsPayArray[indexPath.section];
    NSLog(@"person %@",personPayDetail);
    if (indexPath.row < personPayDetail.referPay.count) {
        //refer
        NSLog(@"refer %@",personPayDetail.referPay);
        PayModel *referPay = personPayDetail.referPay[indexPath.row];
        referPay.isSelfPayStyle = NO;
        cell.payModel = referPay;
    }else{
        //pay
        NSLog(@"pay %@",personPayDetail.referPay);
        PayModel *selfPay = personPayDetail.selfPay[indexPath.row-personPayDetail.referPay.count];
        selfPay.isSelfPayStyle = YES;
        cell.payModel = selfPay;
    }

    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
     PersonPayDetail *personPayDetail = self.personsPayArray[section];
    NSString *content = [NSString stringWithFormat:@"%@(需付款：%@)",personPayDetail.person.name, personPayDetail.money];
    return content;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 25;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)requestPersonPayDetail{
    self.personsPayArray = [self.personPayDao personPayList];
    [self.listView.tableView reloadData];
}
- (BOOL)hasMore:(AABigListView *)bigListView{
    return NO;
}
- (void)fetchMore:(AABigListView *)bigListView page:(NSInteger)page complete:(AABigListViewBlock)block{
    [self requestPersonPayDetail];
    block(page);
}
- (void)refresh:(AABigListView *)bigListView{
    self.personsPayArray = nil;
}

@end
