//
//  UIImage+HEF.h
//  1116LimitFree
//
//  Created by 成都千锋 on 15/11/16.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (HEF)

/**
 *  根据图片名称来创建一个自动拉伸的图片
 */
+ (UIImage *)imageAutoResizeWithName:(NSString *)imageName;


/**
 *  传入宽度和高度的百分比拉伸图片
 */

+ (UIImage *)imageAutoResizeWithName:(NSString *)imageName andWidthRatio:(CGFloat)wr andHeightRatio:(CGFloat)hr;
@end
