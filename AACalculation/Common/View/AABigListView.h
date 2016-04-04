//
//  AABigListView.h
//  JDHaiGo
//
//  Created by FairySong on 15/8/4.
//  Copyright (c) 2015年 京东商城. All rights reserved.
//

#import  <UIKit/UIKit.h>

typedef void(^AABigListViewBlock)(NSInteger);
@class AABigListView;


/**
 *
 *  @brief  大数据列表的回调接口
 */
@protocol AABigListViewDelegate

/**
 *
 *  @brief  是否函有更多页的数据
 *
 *  @param bigListView 当前的大数据列表实例
 *
 *  @return 如果有更多数据则返回true
 */
- (BOOL)hasMore:(AABigListView *)bigListView;

/**
 *
 *  @brief  回调方法，当用户界面滑动到最底部时，则触发此加载更多数据方法。
 *     由于我们的数据获取大部分为网络异步，所以在获取完数据后，一定要调用此方法。
 *     此方法会计算当前大数据列表视图的分页信息，加载更多视图动画等状态
 *
 *  @param bigListView 当前使用的大数据列表实例
 *  @param page        需要获取的页数
 *  @param block       获取成功后的回调方法
 */
- (void)fetchMore:(AABigListView *)bigListView page:(NSInteger)page complete:(AABigListViewBlock)block;

/**
 *
 *  @brief  当下拉刷新下，回调此方法
 *
 *  @param bigListView 当前使用的大数据列表实例
 */
- (void)refresh:(AABigListView *)bigListView;
@end


/**
 *
 *  京东大数据列表UIView，数据显示引用UITableView视图，也就是说所有的数据显示还是走UITableView的所有接口，并不做任何修改。其中也包括UITableViewDelegate，UITableViewDataSource的使用。
 *  把视图组合在一起，增加了如下功能：
 *   1) 添加了下接刷新功能，并且没有使用UITableView的delegate
 *   2) 添加了下滑到底部自动显示加载动画，并调用fetchMore接口
 *   3) 在获取并显示完数据后，会调用hasMore接口，如果返回false则不显示尾部的加载行
 *   4) 如果首页数据在获取hasMore时，数据为空，则显示可配制的暂无数据页面，默认为空
 *
 *   流程为：
 *   1) 当添加到父View后，会自动调用delegate的fetchMore接口
 *   2) 第一次fetchMore接口调用后，如果无数据返回或返回数据为空，则显示暂无数据页面
 *   3) 如果有数据，显示完数据后，会调用hasMore接口，如果有更多，则显示底部的加载动画行，如果没有，则隐藏。并更新isHasMore状态
 *   4) 每一次成功加载数据后，currentPage自动加 1
 *   5) 第一次成功加载数据后，isFirstLoad置为 false
 *   4) 也可以直接调用loadData方法加载数据
 */
@interface AABigListView : UIView

@property(nonatomic, weak)id<AABigListViewDelegate>     listDelegate;
@property(nonatomic, strong)UITableView                 *tableView;
@property(nonatomic, strong)UIActivityIndicatorView     *activitiView;
@property(nonatomic, strong)UIImageView                 *loadingView;
@property(nonatomic, strong)UIView                      *noDataView;

@property(nonatomic, assign)BOOL            isNeedShowFooterView;
@property(nonatomic, assign)BOOL            isNeedRefresh;
@property(nonatomic, assign)BOOL            isFetching;
@property(nonatomic, assign)BOOL            isHasMore;
@property(nonatomic, assign)BOOL            isFirstLoad;
@property(nonatomic, assign)BOOL            isNeedNoDataView;

@property(nonatomic, assign)NSInteger       currentPage;
@property(nonatomic, assign)NSInteger       totalPage;

/**
 *
 *  @brief  开始获取数据
 */
-(void)loadData;

/**
 *
 *  @brief  重新获取数据
 */
-(void)reloadData;

/**
 *
 *  @brief  初始化对像
 */
-(void)initWithView;

@end
