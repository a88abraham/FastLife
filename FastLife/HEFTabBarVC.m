//
//  HEFTabBarVC.m
//  FastLife
//
//  Created by 99 on 15/12/25.
//  Copyright (c) 2015年 enfaHe. All rights reserved.
//

#import "HEFTabBarVC.h"

@interface HEFTabBarVC ()

@end

@implementation HEFTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addControllers];
}
/** 添加子视图控制器 */
- (void) addControllers{
    
    
    
    
    NSArray *nameArray = @[@"找服务",@"历史记录",@"个人中心"];
    NSArray *normalArray = @[@"Btn_ToolBar_0_Default",
                             @"Btn_ToolBar_1_Default",
                             @"Btn_ToolBar_2_Default"];
    NSArray *selectedArray = @[@"Btn_ToolBar_0_Selected",
                               @"Btn_ToolBar_1_Selected",
                               @"Btn_ToolBar_2_Selected"];
    
    NSArray *VCNameArray = @[@"SearchServiceVC",
                             @"HistoricalVC",
                             @"PersonalCenterVC"];
    
    for (int i = 0; i < nameArray.count; i++) {
        
        Class class = NSClassFromString(VCNameArray[i]);
        
        UIViewController *vc = [[class alloc] init];
        
        vc.title = nameArray[i];
        
        vc.tabBarItem.title = @"";
        

        
        [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(4, 0, -4, 0)];

        vc.tabBarItem.image = [[UIImage imageNamed:normalArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //设置导航栏
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.navigationBar.backgroundColor = [UIColor blackColor];
        //逐一添加ViewController
        [self addChildViewController:nav];
        
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
