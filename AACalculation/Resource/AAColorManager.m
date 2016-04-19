//
//  AAColorManager.m
//  AACalculation
//
//  Created by FairySong on 16/4/4.
//  Copyright © 2016年 云帆. All rights reserved.
//

#import "AAColorManager.h"

@implementation AAColorManager
+(UIColor *)colorForSeperator{
    return [[self class] getColorByHex:@"e3e3e3"];
}

+(UIColor *)colorForBackground{
    return [[self class] getColorByHex:@"e3e3e3"];
}

+(UIColor *)colorForTest{
    return [UIColor whiteColor];
}


+(UIColor *)getColorByHex:(NSString *)hexColor
{
    
    if (hexColor == nil) {
        return nil;
    }
    int strLen = (int)[hexColor length];
    if ( strLen < 6 || strLen > 7) {
        return nil;
    }
    
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    
    int offset = 1;
    if ( 6 == strLen )
        offset = 0;
    
    range.location = offset;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = offset + 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = offset + 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
    
    
}

@end
