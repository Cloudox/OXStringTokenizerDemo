//
//  ViewController.m
//  OXStringTokenizerDemo
//
//  Created by csdc-iMac on 2017/6/5.
//  Copyright © 2017年 Cloudox. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *keywords;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 要分词的字符串
    NSString *string = @"故事的小黄花，从出生那年就飘着，童年的荡秋千，随记忆一直晃到现在";
    
    self.keywords = [[NSMutableArray alloc] init];
    CFStringTokenizerRef ref = CFStringTokenizerCreate(NULL,  (__bridge CFStringRef)string, CFRangeMake(0, string.length), kCFStringTokenizerUnitWord, NULL);// 创建分词器
    CFRange range;// 当前分词的位置
    // 获取第一个分词的范围
    CFStringTokenizerAdvanceToNextToken(ref);
    range = CFStringTokenizerGetCurrentTokenRange(ref);
    
    // 循环遍历获取所有分词并记录到数组中
    NSString *keyWord;
    while (range.length>0) {
        keyWord = [string substringWithRange:NSMakeRange(range.location, range.length)];
        [self.keywords addObject:keyWord];
        CFStringTokenizerAdvanceToNextToken(ref);
        range = CFStringTokenizerGetCurrentTokenRange(ref);
    }
    
    // 显示分词的列表
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-20)];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.keywords count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.text = [self.keywords objectAtIndex:indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
