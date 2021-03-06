//
//  PayListViewController.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PayListViewController.h"
#import "AABigListView.h"
#import "PayTableViewCell.h"
#import "PayDao.h"
#import "PayModel.h"
#import "WritePayView.h"
#import "PersonsViewController.h"

@interface PayListViewController ()<UITableViewDataSource, UITableViewDelegate, AABigListViewDelegate, MGSwipeTableCellDelegate>
@property(nonatomic, strong)AABigListView *listView;
@property(nonatomic, strong)NSArray *listDataArray;
@property(nonatomic, strong)PayDao *payDao;
@end

@implementation PayListViewController
-(instancetype)initWithActivitySid:(NSNumber *)sid{
    self = [super init];
    if (self) {
        self.activitySid = sid;
        self.payDao = [[PayDao alloc] initWithActivitySid:self.activitySid];
    }
    return self;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}
-(void)setup
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addActivity:)];

    //view
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    [_listView.tableView registerNib:[UINib nibWithNibName:@"PayTableViewCell" bundle:nil]
              forCellReuseIdentifier:@"cell"];
    [_listView loadData];
    
    
}

-(void)addActivity:(UIButton *)button{
    NSLog(@"add");
    WritePayView *payView = [WritePayView writePayViewWithSid:self.activitySid];
    payView.containerViewController = self;
    WS();
    payView.finishBlock = ^(PayModel *model){
        [weakself.payDao addPay:model];
        [weakself.listView reloadData];
    };

    [self.view addSubview:payView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    cell.model = self.listDataArray[indexPath.row];
    WS();
    cell.tapReferPersonsBlock = ^(NSArray *personsSidArray){
        PersonsViewController *personVC = [[PersonsViewController alloc] initWithActivitySid:self.activitySid];
        personVC.personsSidArray = personsSidArray;
        personVC.showStyle = PersonsViewShowStyleNormalLocal;
        [weakself.navigationController pushViewController:personVC animated:YES];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)requestData{
    self.listDataArray = [self.payDao payList];
    [self.listView.tableView reloadData];
}
- (BOOL)hasMore:(AABigListView *)bigListView{
    return NO;
}
- (void)fetchMore:(AABigListView *)bigListView page:(NSInteger)page complete:(AABigListViewBlock)block{
    [self requestData];
    block(page);
}
- (void)refresh:(AABigListView *)bigListView{
    self.listDataArray = nil;
}

-(BOOL) swipeTableCell:(MGSwipeTableCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    NSIndexPath *indexPath = [self.listView.tableView indexPathForCell:cell];
    if (indexPath.row < self.listDataArray.count && indexPath.row >= 0) {
        PayModel *model = self.listDataArray[indexPath.row];
        [self.payDao deletePay:model];
        [self.listView reloadData];
    }
    
    return YES;
}
@end
