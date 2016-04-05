//
//  PersonsViewController.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "PersonsViewController.h"
#import "AABiglistView.h"
#import "PersonTableViewCell.h"
#import "PersonsDao.h"
#import "PersonsModel.h"

@interface PersonsViewController ()<UITableViewDataSource, UITableViewDelegate, AABigListViewDelegate, MGSwipeTableCellDelegate>
@property(nonatomic, strong)AABigListView *listView;
@property(nonatomic, strong)NSArray *listDataArray;
@property(nonatomic, strong)PersonsDao *personDao;
@end

@implementation PersonsViewController

-(instancetype)initWithActivitySid:(NSNumber *)sid{
    self = [super init];
    if (self) {
        self.activitySid = sid;
    }
    return self;
}
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
    
    [_listView.tableView registerNib:[UINib nibWithNibName:@"PersonTableViewCell" bundle:nil]
              forCellReuseIdentifier:@"cell"];
    
    self.personDao = [[PersonsDao alloc] initWithBelongToActivitySid:self.activitySid];
    [self.listView loadData];
    [self setupAdd];
}

-(void)setupAdd{
    //    self.addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    //    self.addButton.frame = CGRectMake(0, 0, 44, 44);
    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addActivity:)];
}
-(void)addActivity:(UIButton *)button{
    NSLog(@"add");
    [self showAddAlertView];
}
-(void)showAddAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithMessage:@"添加活动" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"]];
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    WS();
    [alert showUsingBlock:^(UIAlertView *alertView, NSInteger buttonIndex) {
        if (buttonIndex == 1) {
            NSString *name = nil;
            UITextField *tf=[alertView textFieldAtIndex:0];
            if (tf) {
                name = tf.text;
                if (name != nil && name.length > 0) {
                    PersonsModel *model = [[PersonsModel alloc] init];
                    model.name = name;
                    [self.personDao addPerson:model];
                    [weakself.listView reloadData];
                }
            }
        }
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listDataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    cell.model = self.listDataArray[indexPath.row];

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

-(void)requestData{
    self.listDataArray = [self.personDao persons];
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
        PersonsModel *model = self.listDataArray[indexPath.row];
        [self.personDao deletePerson:model];
        [self.listView reloadData];
    }
    
    return YES;
}

@end
