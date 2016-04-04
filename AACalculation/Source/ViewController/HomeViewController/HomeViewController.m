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

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource, AABigListViewDelegate>
@property(nonatomic, strong)AABigListView *listView;
@property(nonatomic, strong)UIButton *addButton;

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
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityDetailViewController *vc = [[ActivityDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (BOOL)hasMore:(AABigListView *)bigListView{
    return YES;
}
- (void)fetchMore:(AABigListView *)bigListView page:(NSInteger)page complete:(AABigListViewBlock)block{
    block(page);
}
- (void)refresh:(AABigListView *)bigListView{
    
}

@end
