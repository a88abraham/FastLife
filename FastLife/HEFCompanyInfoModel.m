//
//  HEFBusinessInfoModel.m
//  FastLife
//
//  Created by apple on 16/1/8.
//  Copyright © 2016年 enfaHe. All rights reserved.
//

#import "HEFCompanyInfoModel.h"

@implementation HEFCompanyInfoModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    //第一种
//    static NSDictionary *dict = nil;
//    if (!dict) {
//        //key 为原名 value为新名
//        dict = @{@"id":@"companyID",@"phone":@"phoneNumber",@"title":@"companyTitle"};
//    }
//    if (dict[key]) {
//        [self setValuesForKeysWithDictionary:dict];
//    }
//    [self setValuesForKeysWithDictionary:dict];

    if ([key isEqualToString:@"id"]) {
        self.companyID = value;
    }

}




@end
