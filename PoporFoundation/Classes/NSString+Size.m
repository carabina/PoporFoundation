//
//  NSString+Size.m
//  Wanzi
//
//  Created by popor on 2016/10/20.
//  Copyright © 2016年 popor. All rights reserved.
//

#import "NSString+Size.h"

@implementation NSString (Size)

- (CGSize)sizeInFont:(UIFont *)font{
    if (!self || self.length==0) {
        return CGSizeZero;
    }
    
    NSDictionary * attributes = @{NSFontAttributeName : font};
    CGSize contentSize=[self sizeWithAttributes:attributes];
    /**
     ceil
     返回大于或等于指定的十进制数的最小整数
     */
    contentSize = CGSizeMake(ceil(contentSize.width), ceil(contentSize.height));
    
    return contentSize;
}

- (CGSize)sizeInFont:(UIFont *)font width:(float)width
{
    if (!self || self.length==0) {
        return CGSizeZero;
    }
    CGSize size = CGSizeMake(width, 200000.0f);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    size = CGSizeMake(ceil(size.width), ceil(size.height));
    return size;
}

-(CGSize)sizeAttrSpace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc]initWithString:self];
    
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
//    paraStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paraStyle.lineSpacing = lineSpeace;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    
    [attr addAttributes:dic range:NSMakeRange(0, self.length)];
    
    CGSize size = [attr boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine context:nil].size;
    size = CGSizeMake(ceil(size.width), ceil(size.height));
    return size;
}

@end
