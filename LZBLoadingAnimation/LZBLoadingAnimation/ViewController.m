//
//  ViewController.m
//  LZBLoadingAnimation
//
//  Created by zibin on 16/10/27.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "LZBLoadingView.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray <NSString *>*methodKeys;
@property (nonatomic, strong) NSArray <NSString *>*methodValues;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.methodKeys = @[@"fourRoundAnimation",
                     @"fourRoundAnimation",
                     @"fourRoundAnimation",
                     @"fourRoundAnimation",
                     @"fourRoundAnimation",
                     @"fourRoundAnimation",];
    //显示文字
    self.methodValues = @[@"BOSS直聘加载动画",
                        @"fourRoundAnimation",
                        @"fourRoundAnimation",
                        @"fourRoundAnimation",
                        @"fourRoundAnimation",
                        @"fourRoundAnimation",];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark- tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.methodKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"loadAnimaitonCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    cell.textLabel.text = self.methodValues[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *method = self.methodKeys[indexPath.row];
    SEL methodSel = NSSelectorFromString(method);
    if([self respondsToSelector:methodSel])
    [self performSelector:methodSel];
}



#pragma mark - 加载动画处理
//BOSS直聘加载动画
- (void)fourRoundAnimation
{
    [LZBLoadingView showLoadingViewFourRoundInView:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [LZBLoadingView dismissLoadingFourRoundView];
    });
}



#pragma mark - 懒加载
- (UITableView *)tableView
{
  if(_tableView == nil)
  {
      _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
      _tableView.dataSource = self;
      _tableView.delegate = self;
  }
    return _tableView;
}

@end
