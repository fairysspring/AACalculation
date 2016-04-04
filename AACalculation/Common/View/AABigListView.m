//
//  AABigListView.m
//  JDHaiGo
//
//  Created by FairySong on 15/8/4.
//  Copyright (c) 2015年 京东商城. All rights reserved.
//

#import "AABigListView.h"
#import "MJRefresh.h"
#import "Masonry.h"

#define JD_DEFAULT_BG_COLOR [UIColor whiteColor]
#define WK(object,name) __typeof__(object) __weak name = object
@implementation AABigListView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initWithView];
    }
    return self;
}

-(void)initVariable
{
    /// 当前访问最大的页数
    _currentPage = 0;
    
    /// 是否需要下拉刷新
    _isNeedRefresh = true;
    
    /// 是否正在获取数据中
    _isFetching = false;
    
    /// 是否有更多
    _isHasMore = false;
    
    /// 是否第一次加载
    _isFirstLoad = true;
}
-(void)initWithView
{
    [self initVariable];
    
    self.backgroundColor = JD_DEFAULT_BG_COLOR;
    self.tableView = [[UITableView alloc] init];
    [self addSubview:_tableView];
    self.tableView.backgroundColor = JD_DEFAULT_BG_COLOR;
    
    __weak typeof(self) weakSelf = self;
    
    // 设置tableview的布局
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
      
    self.noDataView = [[UIView alloc] init];
    _noDataView.alpha = 0;
    
    // 暂无数据时，进行暂无数据的视图显示
    [self addSubview:_noDataView];
    [_noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    UILabel *noMoreDataLabel = [[UILabel alloc] init];
    noMoreDataLabel.text = @"暂无数据";
    noMoreDataLabel.textAlignment = NSTextAlignmentCenter;
    [_noDataView addSubview:noMoreDataLabel];
    [noMoreDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(weakSelf);
    }];
    
    // 初始化footer
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadData];
    }];
    // 设置刷新图片
    footer.refreshingTitleHidden = YES;
    [footer setTitle:@"" forState:(MJRefreshStateNoMoreData)];
    footer.stateLabel.font = [UIFont systemFontOfSize:12];
    
    // 设置尾部
    _tableView.mj_footer = footer;
    
    // 添加刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        if(nil != weakSelf.listDelegate)
        {
            weakSelf.currentPage = 0;
            [weakSelf.listDelegate refresh:weakSelf];
            [weakSelf reloadData];
        }
        
    }];
    _tableView.mj_header.automaticallyChangeAlpha = YES;
}

/**
 当需要手动重新刷时，调用此方法
 */
-(void)reloadData
{
    _currentPage = 0;
    _noDataView.alpha = 0;
    self.isFirstLoad = true;
    [self endRfreshAnimation ];
    [self.tableView reloadData];
    
    [self loadData];
}



#pragma mark view
-(void)didMoveToSuperview{
    if (self.isFirstLoad) {
        [self loadData];
    }
}


/**
 *
 *  @brief  开始获取数据
 */
-(void)loadData
{
    NSLog(@"-----loadData");
    if (nil != self.listDelegate)
    {
        self.isFetching = true;
        
        // 开始转圈动画
//        [_activitiView startAnimating];
        
        // 获取delegate的更多数据，page+1
        [_listDelegate fetchMore:self page:_currentPage complete:^(NSInteger page) {
            // 重新加载 tableview 数据
            [self.tableView reloadData];
            
            // 第一次获取完数据后，调用是否还有更多，如果有，显示底部的加载更多视图，否则隐藏
            if([self.listDelegate hasMore:self])
            {
                self.isHasMore = true;
                [self.tableView.mj_footer resetNoMoreData];
            }
            else
            {
                self.isHasMore = false;
                [self endLoadAnimation];
            }
            self.currentPage++;
            // 如果已经加载显示了数据，则isFirstLoad为false
            self.isFirstLoad = false;
        }];
        
    }
    
}


/**
 *
 *  @brief  设置是否隐藏暂无数据视图
 *
 *  @param isHide 是否隐藏
 */
-(void)setNoMoreDataViewHide:(BOOL)isHide
{
    if(isHide)
    {
        _noDataView.alpha = 0;
        _tableView.alpha = 1;
        [self bringSubviewToFront:_tableView];
    }
    else
    {
        _tableView.alpha = 0;
        _noDataView.alpha = 1;
        [self bringSubviewToFront:_noDataView];
    }
}

/**
 *
 *  @brief  隐藏刷新Header
 */
-(void)endRfreshAnimation
{
    [_tableView.mj_header endRefreshing];
}


-(void)endLoadAnimation
{
    [_tableView.mj_footer endRefreshingWithNoMoreData];
}




@end
