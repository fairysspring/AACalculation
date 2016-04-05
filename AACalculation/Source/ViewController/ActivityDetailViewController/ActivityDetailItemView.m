//
//  ActivityDetailItemView.m
//  AACalculation
//
//  Created by FairySong on 16/4/4.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "ActivityDetailItemView.h"

@implementation ActivityDetailItemView
+(ActivityDetailItemView *)activityDetailItemView{
    ActivityDetailItemView *view = [[[NSBundle mainBundle] loadNibNamed:@"ActivityDetailItemView" owner:self options:nil]objectAtIndex:0];
    view.backgroundColor = [UIColor purpleColor];
    view.width = AAScreenWidth;
    view.height = 50;
    
    
    UIControl *control = [[UIControl alloc] initWithFrame:view.bounds];
    [control addTarget:view action:@selector(tapControl) forControlEvents:(UIControlEventTouchUpInside)];
    [view addSubview:control];
    return view;

}

-(void)tapControl{
    self.tapBlock();
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
