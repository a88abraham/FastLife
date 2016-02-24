//
//  HEFBusinessInfoModel.h
//  FastLife
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 enfaHe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEFCompanyInfoModel : NSObject
/**公司名称*/
@property (nonatomic, copy) NSString *companyName;
/**标题*/
@property (nonatomic, copy) NSString *title;
/**关键字*/
@property (nonatomic, copy) NSString *keywords;
/**联系电话*/
@property (nonatomic, copy) NSString *phone;
/**更新时间*/
@property (nonatomic, copy) NSString *timeString;
/**公司名称ID*/
@property (nonatomic, copy) NSString *companyID;

@property (nonatomic, assign) NSInteger classifyID;


@end
