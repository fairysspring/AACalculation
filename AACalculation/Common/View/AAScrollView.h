//
//  AAScrollView.h
//  JDHaiGo
//  少量数据的列表展示使用。
//  使用页面：商祥
//  Created by FairySong on 15/8/8.
//  Copyright (c) 2015年 云帆. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AAScrollView : UIScrollView
+(NSInteger)tag;
-(void)addToContentSubview:(UIView *)subview;
-(void)removeFromContentForSubview:(UIView *)subview;
- (void)reloadSubviews;
- (UIView *)subviewWithTag:(NSInteger)tag;
-(UIView *)spaceViewWithHeight:(CGFloat)height;
-(UIView *)spaceLineViewWithHeight:(CGFloat)height;
-(UIView *)lineView;
-(UIView *)sectionView;
- (void)removeAllSubViewsForScrollView;
@end
