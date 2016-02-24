//
//  UIImage+HEF.m
//  1116LimitFree
//
//  Created by 成都千锋 on 15/11/16.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "UIImage+HEF.h"

@implementation UIImage (HEF)

//实现图片伸缩功能
+ (UIImage *)imageAutoResizeWithName:(NSString *)imageName
{

    return [self imageAutoResizeWithName:imageName andWidthRatio:0.5 andHeightRatio:0.5];
}

+ (UIImage *)imageAutoResizeWithName:(NSString *)imageName andWidthRatio:(CGFloat)wr andHeightRatio:(CGFloat)hr{

    UIImage *image = [UIImage imageNamed:imageName];
    CGSize imageSize =image.size;
    
    return [image stretchableImageWithLeftCapWidth:imageSize.width * wr topCapHeight:imageSize.height * hr];
}

@end
