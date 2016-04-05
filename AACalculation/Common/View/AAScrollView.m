//
//  AAScrollView.m
//  JDHaiGo
//
//  Created by FairySong on 15/8/8.
//  Copyright (c) 2015年 云帆. All rights reserved.
//

#import "AAScrollView.h"


@interface AAScrollView()
@property(nonatomic, strong)NSMutableArray *contentSubviews;
@property(nonatomic, assign)CGFloat currentOffsetY;
@end

@implementation AAScrollView



-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.tag = [AAScrollView tag];
        self.showsVerticalScrollIndicator = YES;
        [self configureTestInfo];
    }
    
    return self;
}



+(NSInteger)tag{
    return 5000;
}


-(void)addToContentSubview:(UIView *)subview{
    if (subview == nil) {
        return;
    }
    
    if (nil == self.contentSubviews) {
        self.contentSubviews = [[NSMutableArray alloc] initWithCapacity:10];
        self.currentOffsetY = 0;
    }
    
    subview.top = self.currentOffsetY;
    [self addSubview:subview];
    [self.contentSubviews addObject:subview];
    self.currentOffsetY += subview.height;
    self.contentSize = CGSizeMake(self.width, self.currentOffsetY);
}
- (void)removeAllSubViewsForScrollView{
    [self removeAllSubViews];
    self.currentOffsetY = 0;
    self.contentSize = CGSizeZero;
}

-(void)removeFromContentForSubview:(UIView *)subview{
    if (subview == nil) {
        return;
    }
    
    [self.contentSubviews removeObject:subview];
    [self reloadSubviews];
}


- (void)reloadSubviews{
    self.currentOffsetY = 0;
    [self removeAllSubViews];
    for (UIView *theSubview in self.contentSubviews) {
        theSubview.top = self.currentOffsetY;
        [self addSubview:theSubview];
        self.currentOffsetY += theSubview.height;
    }
    self.contentSize = CGSizeMake(self.width, self.currentOffsetY);
}


- (UIView *)subviewWithTag:(NSInteger)tag{
    for (UIView *theView in self.contentSubviews) {
        if (theView.tag == tag) {
            return theView;
        }
    }
    return nil;
}

-(UIView *)spaceViewWithHeight:(CGFloat)height{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
    view.backgroundColor = [AAColorManager colorForTest];
    return view;
}
-(UIView *)spaceLineViewWithHeight:(CGFloat)height{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, height)];
    view.backgroundColor = [AAColorManager colorForTest];
    UIView *line0 = [self lineView];
    line0.top = view.top;
    line0.left = view.left;
     UIView *line1 = [self lineView];
    line0.bottom = view.bottom;
    line0.left = view.left;
    
    [view addSubview:line0];
    [view addSubview:line1];
    return view;
}
-(UIView *)lineView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    view.backgroundColor = [AAColorManager colorForSeperator];
    return view;
}
-(UIView *)sectionView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 5)];
    view.backgroundColor = [AAColorManager colorForTest];
    return view;
}
- (void)configureTestInfo{
    
}
-(void)removeAllSubViews{
    for( UIView *v in [self subviews]){
        [v removeFromSuperview];
    }
}


@end
