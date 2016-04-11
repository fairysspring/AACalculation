//
//  HomeViewController.m
//  AACalculation
//
//  Created by FairySong on 16/4/1.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "HomeViewController.h"
#import "AABigListView.h"
#import "ActivityTableViewCell.h"
#import "ActivityDetailViewController.h"
#import "HomeDao.h"
#import "ActivityModel.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, AABigListViewDelegate, MGSwipeTableCellDelegate>
@property(nonatomic, strong)AABigListView *listView;
@property(nonatomic, strong)UIButton *addButton;
@property(nonatomic, strong)NSArray *listDataArray;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setup];
}

-(void)setup{
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
    
    [_listView.tableView registerNib:[UINib nibWithNibName:@"ActivityTableViewCell" bundle:nil]
              forCellReuseIdentifier:@"cell"];
    [_listView loadData];
    [self setupAdd];
}

-(void)setupAdd{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addActivity:)];
}


-(void)addActivity:(UIButton *)button{
    [self showAddAlertView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model = self.listDataArray[indexPath.row];
    cell.delegate = self;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityModel *model = self.listDataArray[indexPath.row];
    ActivityDetailViewController *vc = [[ActivityDetailViewController alloc] initWithActivitySid:model.sid];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)requestData{
    self.listDataArray = [HomeDao homelist];
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


-(void)showAddAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithMessage:@"添加活动" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"]];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    WS();
    [alert showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSString *activityName = nil;
            UITextField *tf=[alertView textFieldAtIndex:0];
            if (tf) {
                activityName = tf.text;
                if (activityName != nil && activityName.length > 0) {
                    ActivityModel *model = [[ActivityModel alloc] init];
                    model.name = activityName;
                    [HomeDao insertActivity:model];
                    [weakself.listView reloadData];
                }
            }
        }
    }];
}

#pragma mark MGSwipeTableCellDelegate
-(BOOL) swipeTableCell:(ActivityTableViewCell*) cell tappedButtonAtIndex:(NSInteger) index direction:(MGSwipeDirection)direction fromExpansion:(BOOL) fromExpansion{
    NSIndexPath *indexPath = [self.listView.tableView indexPathForCell:cell];
    if (indexPath.row < self.listDataArray.count && indexPath.row >= 0) {
        ActivityModel *model = self.listDataArray[indexPath.row];
        [HomeDao deleteActivity:model];
        [self.listView reloadData];
    }
    
    return YES;
}
@end
