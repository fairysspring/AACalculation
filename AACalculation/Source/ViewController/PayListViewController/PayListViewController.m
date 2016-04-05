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

@interface PayListViewController ()
@property(nonatomic, strong)AABigListView *listView;
@end

@implementation PayListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
}
-(void)setup
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:(UIBarButtonSystemItemAdd) target:self action:@selector(addActivity:)];

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
    
    [_listView.tableView registerNib:[UINib nibWithNibName:@"PayTableViewCell" bundle:nil]
              forCellReuseIdentifier:@"cell"];
    
}

-(void)addActivity:(UIButton *)button{
    NSLog(@"add");
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
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
