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
@property(nonatomic, strong)NSMutableArray *currentSelectedSidArray;
@property(nonatomic, strong)PersonsModel *currentSelectedPayPerson;

@end

@implementation PersonsViewController

-(instancetype)initWithActivitySid:(NSNumber *)sid{
    self = [super init];
    if (self) {
        self.activitySid = sid;
        self.showStyle = PersonsViewShowStyleNormal;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

-(void)setup{
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
    if (self.showStyle == PersonsViewShowStyleNormal) {
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addActivity:)];
    }else if (self.showStyle == PersonsViewShowStyleSelectedReferPersons){
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(finishReferSelected:)];
    }else if (self.showStyle == PersonsViewShowStyleSelectedPayPerson){
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemDone) target:self action:@selector(finishPaySelected:)];
    }else if (self.showStyle == PersonsViewShowStyleNormalLocal) {
        self.navigationItem.rightBarButtonItem = nil;
    }
   
}
-(void)addActivity:(UIButton *)button{
    NSLog(@"add");
    if (self.showStyle == PersonsViewShowStyleNormalLocal) {
        return;
    }
    [self showAddAlertView];
}
-(void)finishReferSelected:(UIButton *)button{
    NSLog(@"finish");
    if (self.selectedReferPersonsFinish) {
        self.selectedReferPersonsFinish([self.currentSelectedSidArray copy]);
    }
}
-(void)finishPaySelected:(UIButton *)button{
    if (self.selectedPayPersonsFinish) {
        self.selectedPayPersonsFinish(self.currentSelectedPayPerson.sid, self.currentSelectedPayPerson.name);
    }
}
-(void)showAddAlertView{
    UIAlertView *alert = [[UIAlertView alloc] initWithMessage:@"添加参与人" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"]];
    
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
    PersonsModel *person = self.listDataArray[indexPath.row];
    if ([self isSelectedPerson:self.listDataArray[indexPath.row]]) {
        person.isSelected = YES;
    }else{
        person.isSelected = NO;
    }
    cell.model = person;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(void)setSelectedSidArray:(NSArray *)selectedSidArray{
    _selectedSidArray = selectedSidArray;
    _currentSelectedSidArray = [_selectedSidArray mutableCopy];
}
-(NSArray *)currentSelectedSidArray{
    if (!_currentSelectedSidArray) {
        _currentSelectedSidArray = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _currentSelectedSidArray;
}
-(void)setPayPersonSid:(NSNumber *)payPersonSid{
    _payPersonSid = payPersonSid;
    self.currentSelectedPayPerson.sid = payPersonSid;
}
-(void)setPayPersonName:(NSString *)payPersonName{
    _payPersonName = payPersonName;
    self.currentSelectedPayPerson.name = _payPersonName;
}

-(PersonsModel *)currentSelectedPayPerson{
    if (!_currentSelectedPayPerson) {
        _currentSelectedPayPerson = [[PersonsModel alloc] init];
    }
    return _currentSelectedPayPerson;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.showStyle == PersonsViewShowStyleSelectedReferPersons) {
        PersonsModel *person = self.listDataArray[indexPath.row];
        person.isSelected = !person.isSelected;
        if (person.isSelected) {
            [self.currentSelectedSidArray addObject:person.sid];
        }else{
            for (NSNumber *theSid in self.currentSelectedSidArray) {
                if (theSid.integerValue == person.sid.integerValue) {
                    [self.currentSelectedSidArray removeObject:theSid];
                    break;
                }
            }
        }
        [self.listView.tableView reloadData];
    }else if (self.showStyle == PersonsViewShowStyleSelectedPayPerson){
        PersonsModel *person = self.listDataArray[indexPath.row];
        person.isSelected = !person.isSelected;
        if (person.isSelected) {
            self.currentSelectedPayPerson.sid = person.sid;
            self.currentSelectedPayPerson.name = person.name;
        }else{
            self.currentSelectedPayPerson = nil;
        }
        [self.listView.tableView reloadData];
    }else if (self.showStyle == PersonsViewShowStyleNormalLocal){
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(BOOL)isSelectedPerson:(PersonsModel *)person{
    if (self.showStyle == PersonsViewShowStyleSelectedReferPersons) {
        for (NSNumber *selectedSid in self.currentSelectedSidArray) {
            if(selectedSid.integerValue == person.sid.integerValue){
                return YES;
            }
        }
    }else if (self.showStyle == PersonsViewShowStyleSelectedPayPerson){
        if (person.sid.integerValue == self.currentSelectedPayPerson.sid.integerValue) {
            return YES;
        }
    }
    
    return NO;
}

-(void)requestData{
    if (self.showStyle == PersonsViewShowStyleNormalLocal) {
        self.listDataArray = [self.personDao personsListWithPersonSidArray:self.personsSidArray];
        return;
    }else{
        self.listDataArray = [self.personDao persons];
    }
    
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
    if (self.showStyle == PersonsViewShowStyleNormalLocal) {
        return NO;
    }
    NSIndexPath *indexPath = [self.listView.tableView indexPathForCell:cell];
    if (indexPath.row < self.listDataArray.count && indexPath.row >= 0) {
        //存在花费 不能删除
        PersonsModel *model = self.listDataArray[indexPath.row];
        BOOL result = [self.personDao deletePerson:model];
        if (!result) {
            UIAlertView *alert = [[UIAlertView alloc] initWithMessage:@"跟钱打交道了,还想跑路～ 这样不好" cancelButtonTitle:@"钻帐篷"];
            [alert show];
            return YES;
        }
        [self.listView reloadData];
    }
    
    return YES;
}

@end
