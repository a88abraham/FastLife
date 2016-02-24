//
//  HEFClassifyData.m
//  FastLife
//
//  Created by apple on 16/1/1.
//  Copyright © 2016年 enfaHe. All rights reserved.
//

#import "HEFClassifyData.h"

@implementation HEFClassifyData

+ (NSArray *)arrayClassifyNameWithIndexPath:(NSInteger)indexPath{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"classify" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
    NSMutableArray *muArray = [NSMutableArray array];
    if (indexPath == 0) {
        NSArray *array = dict[@"家政服务"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"name"]];
        }
    }
    if (indexPath == 1) {
        NSArray *array = dict[@"汽车服务"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"name"]];
        }
    }
    if (indexPath == 2) {
        NSArray *array = dict[@"装修建材"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"name"]];
        }
    }
    if (indexPath == 3) {
        NSArray *array = dict[@"婚庆摄影"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"name"]];
        }
    }
    if (indexPath == 4) {
        NSArray *array = dict[@"旅游度假"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"name"]];
        }
    }
    if (indexPath == 5) {
        NSArray *array = dict[@"休闲娱乐"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"name"]];
        }
    }
    if (indexPath == 6) {
        NSArray *array = dict[@"商务服务"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"name"]];
        }
    }
    if (indexPath == 7) {
        NSArray *array = dict[@"教育培训"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"name"]];
        }
    }
    NSArray *array = [NSArray arrayWithArray:muArray];
    return array;
}

+ (NSArray *)arrayClassifyNumWithIndexPath:(NSInteger)indexPath{
    NSString *file = [[NSBundle mainBundle] pathForResource:@"classify" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
    NSMutableArray *muArray = [NSMutableArray array];
    if (indexPath == 0) {
        NSArray *array = dict[@"家政服务"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"classify_id"]];
        }
    }
    if (indexPath == 1) {
        NSArray *array = dict[@"汽车服务"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"classify_id"]];
        }
    }
    if (indexPath == 2) {
        NSArray *array = dict[@"装修建材"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"classify_id"]];
        }
    }
    if (indexPath == 3) {
        NSArray *array = dict[@"婚庆摄影"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"classify_id"]];
        }
    }
    if (indexPath == 4) {
        NSArray *array = dict[@"旅游度假"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"classify_id"]];
        }
    }
    if (indexPath == 5) {
        NSArray *array = dict[@"休闲娱乐"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"classify_id"]];
        }
    }
    if (indexPath == 6) {
        NSArray *array = dict[@"商务服务"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"classify_id"]];
        }
    }
    if (indexPath == 7) {
        NSArray *array = dict[@"教育培训"];
        for (NSDictionary *tempDict in array) {
            [muArray addObject:tempDict[@"classify_id"]];
        }
    }
    NSArray *array = [NSArray arrayWithArray:muArray];
    return array;
}

@end
