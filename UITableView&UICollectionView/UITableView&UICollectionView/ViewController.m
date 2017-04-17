//
//  ViewController.m
//  UITableView&UICollectionView
//
//  Created by 刘怀轩 on 2017/4/14.
//  Copyright © 2017年 刘怀轩. All rights reserved.
//

#import "ViewController.h"
#define KWidth [UIScreen mainScreen].bounds.size.width
#import "MJRefresh.h"

@interface ViewController ()<UITableViewDelegate , UITableViewDataSource , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout>
@property (nonatomic , strong) UITableView *tableView;
@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray arrayWithObjects:@"1", @"1" , @"1" , @"1" , @"1", @"1" , @"1" , @"1" , @"1", @"1" , @"1" , @"1" , @"1", @"1" , @"1" , @"1" , nil];
    }
    return _dataArray;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
}

- (void)footRefresh {
    [self.tableView.mj_footer endRefreshing];
    for (int i = 0; i < 10; i++) {
        [self.dataArray addObject:@"1"];
    }
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        return self.dataArray.count / 2 * 200;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    if (indexPath.row != 3) {
        cell.textLabel.text = @"测试";
    } else {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KWidth, self.dataArray.count / 2 * 200) collectionViewLayout:layout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        layout.itemSize = CGSizeMake( (KWidth - 10) / 2, 200);
        layout.minimumLineSpacing = 5;
        layout.minimumInteritemSpacing = 0;
        collectionView.scrollEnabled = NO;
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
        [cell.contentView addSubview:collectionView];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate , UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"collection";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UICollectionViewCell alloc] init];
    }
    cell.contentView.backgroundColor = [UIColor redColor];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 2, 2, 2);
}


@end
