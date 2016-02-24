//
//  HEFClassifyViewController.m
//  FastLife
//
//  Created by apple on 16/1/1.
//  Copyright © 2016年 enfaHe. All rights reserved.
//

#import "HEFClassifyViewController.h"
#import "HEFClassifyData.h"
#import "HEFCompanyInfoModel.h"
#import <AFNetworking.h>

@interface HEFClassifyViewController () <UITableViewDelegate,UITableViewDataSource>{

    UITableView *leftTableView;
    UITableView *rightTableView;
    NSString *string;
    HEFCompanyInfoModel *companyInfo;
}

@property (nonatomic, copy) NSMutableArray *leftDataArray;
@property (nonatomic, copy) NSMutableArray *rightDataArray;

@end

@implementation HEFClassifyViewController


- (NSMutableArray *)leftDataArray{

    if (_leftDataArray == nil) {
        _leftDataArray = [NSMutableArray array];
    }
    return _leftDataArray;
}

- (NSMutableArray *)rightDataArray{
    
    if (_rightDataArray == nil) {
        _rightDataArray = [NSMutableArray array];
    }
    return _rightDataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = _classifyTitle;
    
    leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftRowWidth, fDeviceHeight) style:UITableViewStylePlain];
    leftTableView.bounces = NO;
    leftTableView.dataSource = self;
    leftTableView.delegate = self;
    leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self loadLeftDataModel];
    
    rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(leftRowWidth, 64, fDeviceWidth - leftRowWidth, fDeviceHeight - 108) style:UITableViewStylePlain];
    rightTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    rightTableView.dataSource = self;
    rightTableView.delegate = self;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadRightDataModel:) name:@"classifyNumber" object:nil];
    
    [self.view addSubview:leftTableView];
    [self.view addSubview:rightTableView];
    
    
}


//左边部分数据model
- (void) loadLeftDataModel{
    if (!_leftDataArray) {
        _leftDataArray = [NSMutableArray array];
    }
    [_leftDataArray addObjectsFromArray:_classifyName];
}


//右边部分数据model
- (void) loadRightDataModel:(NSNotification *)number{
    if (!_rightDataArray) {
        _rightDataArray = [NSMutableArray array];
    }
    if (_chooseCityID == 0) {
        _chooseCityID = 32;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"text/xml", @"application/json", nil];
    //@{@"cityId":@(_chooseCityID),@"typeId":number.object,@"pageSize":@(20),@"key":APPKEY}
    NSLog(@"_chooseCityID = %ld,number.object = %@",_chooseCityID,number.object);
    NSString *urlString = [NSString stringWithFormat:@"%@?cityId=%@&typeId=%@&pageIndex=1&pageSize=%@&key=%@",companyPlist,@(_chooseCityID),number.object,@(20),APPKEY];
    NSLog(@"urlString = %@",urlString);
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dict = responseObject;
        if ([dict[@"error_code"] isEqual:@(10025)]) {
            NSLog(@"error = 没有查询到结果");

        }else if ([dict[@"error_code"] isEqual:@(207101)]) {
            NSLog(@"error = 参数错误");
            
        }else{
            for (NSDictionary *tempDict in dict[@"result"]) {
                HEFCompanyInfoModel *model = [[HEFCompanyInfoModel alloc] init];
                [model setValuesForKeysWithDictionary:tempDict];
                
                [_rightDataArray addObject:model];
            }
        
        }
        
        [rightTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error = %@",error);
    }];
    //这里要用到最后的classifyNumber的值
    
}
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([tableView isEqual:leftTableView]) {
        
        return _leftDataArray.count;
        
    }else if ([tableView isEqual:rightTableView]){
    
        return _rightDataArray.count;
    }
    
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:leftTableView]) {
        
        return leftRowHeight;
        
    }else if ([tableView isEqual:rightTableView]){
        
        return rightRowHeight;
    }
    
    return 0;


}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:leftTableView]) {
        static NSString *cellIdentifier = @"CELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        cell.textLabel.text = _leftDataArray[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.contentView.backgroundColor = [UIColor lightGrayColor];
        return cell;
    }else if ([tableView isEqual:rightTableView]){
    
        static NSString *cellIdentifier = @"CELL";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        }
        HEFCompanyInfoModel *model =_rightDataArray[indexPath.row];
        cell.textLabel.text = model.companyName;
        cell.detailTextLabel.text = model.title;
        
        return cell;
    
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击左边tableView返回的值
    if ([tableView isEqual:leftTableView]) {
        string = _leftDataArray[indexPath.row];
        NSArray *array = [HEFClassifyData arrayClassifyNumWithIndexPath:(long)_classifyNum];
        NSInteger classifyNumber = [array[indexPath.row] integerValue];//第二级分类的ID
        companyInfo = [[HEFCompanyInfoModel alloc] init];
        companyInfo.classifyID = classifyNumber;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"classifyNumber" object:array[indexPath.row]];
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
