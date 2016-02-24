//
//  SearchServiceVC.m
//  FastLife
//
//  Created by 成都千锋 on 15/12/25.
//  Copyright (c) 2015年 enfaHe. All rights reserved.
//

#import "SearchServiceVC.h"
#import "AdvertisingColumn.h"
#import "CollectionViewCell.h"
#import "HEFClassifyViewController.h"
#import "HEFClassifyData.h"
#import "HEFCityViewController.h"

#ifndef W_H_
#define W_H_
#define WIDTH self.view.bounds.size.width
#define HEIGHT self.view.bounds.size.height
#endif

#define ADV_H HEIGHT / 3.0


@interface SearchServiceVC ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    AdvertisingColumn *_headerView;
    UIScrollView *myScrollView;
    UICollectionView *myCollView;
    NSMutableArray *dataArray;
    NSMutableArray *advDataArray;
    NSArray *classifyArray;
    UIButton *leftButton;
    NSString *cityTitle;
    NSInteger cityNumber;
}



@end

@implementation SearchServiceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    self.navigationController.navigationBar.barTintColor = [UIColor cyanColor];//不能放init处
//    self.navigationController.navigationBar.tintColor = [UIColor greenColor];
    
    float AD_height = 180;//广告栏高度
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.headerReferenceSize = CGSizeMake(fDeviceWidth, AD_height+10);//头部
    myCollView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, fDeviceWidth, fDeviceHeight) collectionViewLayout:flowLayout];
    
    //设置代理
    myCollView.delegate = self;
    myCollView.dataSource = self;
    [self.view addSubview:myCollView];
    [self addLeftTabBarButton];
    
    
    myCollView.backgroundColor = [UIColor whiteColor];
    
    //注册cell和ReusableView（相当于头部）
    [myCollView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [myCollView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView"];
    
    
    /*
     ***广告栏
     */
    _headerView = [[AdvertisingColumn alloc]initWithFrame:CGRectMake(5, 5, fDeviceWidth-10, AD_height)];
    _headerView.backgroundColor = [UIColor redColor];
    
    /*
     ***加载的数据
     */
    NSArray *imgArray = [NSArray arrayWithObjects:@"01.jpg",@"02.jpg",@"03.jpg",@"04.jpg",@"05.jpg",@"06.jpg",@"07.jpg", nil];
    [_headerView setArray:imgArray];
}
//-------------------------------------------------------------------------------------------
#pragma mark 定时滚动scrollView
-(void)viewDidAppear:(BOOL)animated{//显示窗口
    [super viewDidAppear:animated];
    //    [NSThread sleepForTimeInterval:3.0f];//睡眠，所有操作都不起作用
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [_headerView openTimer];//开启定时器
    });
}
-(void)viewWillDisappear:(BOOL)animated{//将要隐藏窗口  setModalTransitionStyle=UIModalTransitionStyleCrossDissolve时是不隐藏的，故不执行
    [super viewWillDisappear:animated];
    if (_headerView.totalNum>1) {
        [_headerView closeTimer];//关闭定时器
    }
}
#pragma mark - scrollView也是适用于tableView的cell滚动 将开始和将要结束滚动时调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [_headerView closeTimer];//关闭定时器
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (_headerView.totalNum>1) {
        [_headerView openTimer];//开启定时器
    }
}
//===========================================================================================

#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    NSArray *iconArray = @[@"CategoryIcon_jz",
                           @"CategoryIcon_qc",
                           @"CategoryIcon_zx",
                           @"CategoryIcon_hq",
                           @"CategoryIcon_ly",
                           @"CategoryIcon_xx",
                           @"CategoryIcon_sw",
                           @"CategoryIcon_jy"];
    
    classifyArray = @[@"家政服务",
                      @"汽车服务", 
                      @"装修建材",
                      @"婚庆摄影",
                      @"旅游度假",
                      @"休闲娱乐",
                      @"商务服务",
                      @"教育培训"];
    
    cell.imgView.image = [UIImage imageNamed:iconArray[indexPath.row]];
    
    cell.text.text = classifyArray[indexPath.row];
    
    return cell;
}
//头部显示的内容
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:
                                            UICollectionElementKindSectionHeader withReuseIdentifier:@"ReusableView" forIndexPath:indexPath];
    
    [headerView addSubview:_headerView];//头部广告栏
    return headerView;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20
    return CGSizeMake((fDeviceWidth-20)/4, (fDeviceWidth-20)/4+20);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    cell.backgroundColor = [UIColor redColor];
    HEFClassifyViewController *classifyVC = [[HEFClassifyViewController alloc] init];
    classifyVC.classifyName = [HEFClassifyData arrayClassifyNameWithIndexPath:indexPath.row];
    classifyVC.classifyNum = (long)indexPath.row;
    classifyVC.classifyTitle = classifyArray[indexPath.row];
    classifyVC.chooseCityID = cityNumber;
    
    [self.navigationController pushViewController:classifyVC animated:YES];
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark 城市显示按钮

- (void)addLeftTabBarButton{
    
    
    
    if (!cityTitle) {
        cityTitle = @"成都";
    }
    
    leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:cityTitle forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [leftButton setImage:[UIImage imageNamed:@"city_Down"] forState:UIControlStateNormal];
    CGSize size = [cityTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    leftButton.frame = CGRectMake(0, 0, size.width + 50, size.height);
    leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(showCityMenu:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) showCityMenu:(UIButton *) sender{
    
    HEFCityViewController *cityVC = [[HEFCityViewController alloc] init];
    
    cityVC.cityBlock = ^(NSString *str,NSInteger num){
        [leftButton setTitle:str forState:UIControlStateNormal];
        cityTitle = str;
        cityNumber = num;
    };
    
    cityVC.city = cityTitle;
    
    cityVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cityVC animated:YES];
    
}

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, ADV_H)];
    myScrollView.contentSize = CGSizeMake(WIDTH * 7, 0);
    myScrollView.bounces = NO;
    myScrollView.showsHorizontalScrollIndicator =NO;
    myScrollView.pagingEnabled = YES;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.itemSize = CGSizeMake(100, 150);
    myCollView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, ADV_H, WIDTH, HEIGHT - ADV_H) collectionViewLayout:layout];
    
    [myCollView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    myCollView.dataSource = self;
    myCollView.delegate =self;
    [self loadDataModel];
    
    [self loadAdvDataModel];
    [self.view addSubview:myScrollView];
    [self.view addSubview:myCollView];



}

- (void) loadAdvDataModel{
    if (!advDataArray) {
        advDataArray = [NSMutableArray array];
    }
    
    NSString *file = [[NSBundle mainBundle] pathForResource:@"placeholder" ofType:@"plist"];
    NSArray *array = [NSArray arrayWithContentsOfFile:file];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *imageName = obj[@"imageName"];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
        UIImage *image = [UIImage imageWithContentsOfFile:filePath];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * WIDTH, 0, WIDTH, ADV_H)];
        imageView.image = image;
        [myScrollView addSubview:imageView];

    }];
    
}

- (void) loadDataModel{
    if (!dataArray) {
        dataArray = [NSMutableArray array];
    }
    NSString *fileName = [[NSBundle mainBundle] pathForResource:@"classify" ofType:@"plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:fileName];
    [dataArray addObjectsFromArray:dic.allKeys];


}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    //防止重复的向单元格中添加UIImageView
    if ([cell viewWithTag:200]) {
        [[cell viewWithTag:200] removeFromSuperview];
    }
    
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 150)];
    
    imageView.tag = 200;
    NSString *imageFilename = [[NSBundle mainBundle] pathForResource:dataArray[indexPath.row] ofType:nil];
    imageView.image = [UIImage imageWithContentsOfFile:imageFilename];
    // 将自定义的视图添加到集合视图单元格的视图中作为其子视图
    [cell.contentView addSubview:imageView];
    
    return cell;


}
*/
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
