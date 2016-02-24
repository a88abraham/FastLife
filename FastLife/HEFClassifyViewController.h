//
//  HEFClassifyViewController.h
//  FastLife
//
//  Created by apple on 16/1/1.
//  Copyright © 2016年 enfaHe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HEFClassifyViewController : UIViewController
/**分组名称*/
@property (nonatomic, copy) NSArray *classifyName;
/**分组序号*/
@property (nonatomic, assign) NSInteger classifyNum;
/**分组的title*/
@property (nonatomic, copy) NSString *classifyTitle;
/**选取的城市名ID*/
@property (nonatomic, assign) NSInteger chooseCityID;
@end
