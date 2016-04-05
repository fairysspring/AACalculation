//
//  WritePayView.m
//  AACalculation
//
//  Created by FairySong on 16/4/5.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "WritePayView.h"

@implementation WritePayView

+(WritePayView *)writePayView{
    WritePayView *view = [[[NSBundle mainBundle] loadNibNamed:@"WritePayView" owner:self options:nil]objectAtIndex:0];
    view.backgroundColor = [UIColor purpleColor];
    view.width = AAScreenWidth;
    view.height = 226;
    return view;
}

@end
