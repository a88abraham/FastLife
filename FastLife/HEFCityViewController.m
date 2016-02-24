//
//  HEFCityViewController.m
//  MyProject1
//
//  Created by 成都千锋 on 15/11/23.
//  Copyright (c) 2015年 fazi. All rights reserved.
//

#import "HEFCityViewController.h"

@interface HEFCityViewController () <UITableViewDelegate,UITableViewDataSource>{
    
    
    
    UITableView *myTableView;
    NSMutableArray *dataArray;
    NSMutableDictionary *allCityDict;
    NSArray *titleArray;
    NSString *currentCity;
    BOOL folded[24];
    
    
}

@end

@implementation HEFCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (!titleArray) {
        titleArray =@[@" 热门城市",@" A",@" B",@" C",@" D",@" E",@" F",@" G",@" H",@" J",@" K",@" L",@" M",@" N",@" P",@" Q",@" R",@" S",@" T",@" W",@" X",@" Y",@" Z"];
    }
    [self setupLeftBarButton];//定制左边项按钮

    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLeftBarButton];
    NSString *cityStr = [NSString stringWithFormat:@"当前城市[%@]",_city];
    self.navigationItem.title = cityStr;
    
    myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,fDeviceWidth, fDeviceHeight) style:UITableViewStylePlain];
    
    myTableView.dataSource = self;
    myTableView.delegate = self;
    [self loadDataModel];
    
    [self.view addSubview:myTableView];
    
}

- (void) loadDataModel{
    if (!dataArray) {
        
        dataArray = [NSMutableArray array];
    }if (!allCityDict) {
        allCityDict = [NSMutableDictionary dictionary];
    }
    
    NSArray *hotArray = @[@"北京",@"上海",@"成都",@"重庆",@"广州",@"深圳"];
    [dataArray insertObject:hotArray atIndex:0];
    NSString *file = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:file];
    
    NSArray *sectionArr = @[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];
        for (int i = 0; i < sectionArr.count; i++) {
        NSMutableArray *tempArray = [NSMutableArray array];
        NSMutableArray *tempArrayId = [NSMutableArray array];
        for (NSDictionary *tempDict in dict[sectionArr[i]]) {
            
            [tempArray addObject:tempDict[@"city_name"]];
            [tempArrayId addObject:tempDict[@"id"]];
            
        }
        NSDictionary *tempDict = [NSDictionary dictionaryWithObjects:tempArray forKeys:tempArrayId];
        [allCityDict addEntriesFromDictionary:tempDict];
        [dataArray addObject:tempArray];
    }
    

}

- (void) setupLeftBarButton{
    NSString *title = @"返回";
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setTitle:title forState:UIControlStateNormal];
    [leftButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    CGSize size = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
    leftButton.frame = CGRectMake(0, 0, size.width, size.height);
    leftButton.titleLabel.font = [UIFont systemFontOfSize:16];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
    [leftButton addTarget:self action:@selector(goBackMovieVC:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) goBackMovieVC:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}
// 定制分组标题
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, fDeviceWidth, 30)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = titleArray[section];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont systemFontOfSize:16];
    label.tag = 300 + section;
    label.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(foldedAll:)];
    [label addGestureRecognizer:tapR];
    return label;
}

- (void) foldedAll:(UITapGestureRecognizer *)sender{
    NSInteger index = sender.view.tag - 300;
    folded[index] = !folded[index];
    [myTableView reloadData];
    
}
//定制右边检索
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return @[@"热门",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z"];;
}

//定制分组的标题
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return titleArray[section];
}
//指定分组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return dataArray.count;
}


//指定每个分区里面有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *tempArray = dataArray[section];
    return folded[section] ? 0 : tempArray.count;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 35;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"CELL";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = dataArray[indexPath.section][indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cityName = dataArray[indexPath.section][indexPath.row];
    NSInteger cityNumber = [[allCityDict allKeysForObject:cityName][0] integerValue];
    
    if (self.cityBlock) {
        self.cityBlock(cityName,cityNumber);
    }
    [self.navigationController popViewControllerAnimated:YES];
}



@end
