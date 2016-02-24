//
//  HEFCityViewController.h
//  MyProject1
//
//  Created by 成都千锋 on 15/11/23.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HEFCityBlock)(NSString *,NSInteger);

@interface HEFCityViewController : UIViewController

@property (nonatomic, copy) NSString *city;

@property (nonatomic, copy) HEFCityBlock cityBlock;

@end
