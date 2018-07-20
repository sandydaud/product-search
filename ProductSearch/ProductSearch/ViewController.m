//
//  ViewController.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ViewController.h"
#import "ProductSearchView.h"
#import "ProductCollectionViewCell.h"
#import "ProductModel.h"
#import "ProductFilterViewController.h"


@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, ProductFilterDelegate>

@property (strong, nonatomic) ProductSearchView *view;
@property (strong, nonatomic) ProductModel *productList;
@property (nonatomic) double calculatedUpperPrice, calculatedLowerPrice;
@property (assign, nonatomic) BOOL isGoldStore, isOfficialStore, isWholeSale, isFirstLoad;

@end

@implementation ViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Search";
    
    [self.view.productCollectionView registerNib:[UINib nibWithNibName:@"ProductCollectionViewCell" bundle:nil]
                            forCellWithReuseIdentifier:@"ProductCollectionViewCell"];
    self.view.productCollectionView.delegate = self;
    self.view.productCollectionView.dataSource = self;
    [self getData];
    self.isFirstLoad = YES;
}

- (void)getData {
    NSString *path = @"https://ace.tokopedia.com/search/v2.5/product?q=samsung&pmin=10000&pmax=100000&wholesale=true&official=true&fshop=2&start=0&rows=100";
    [self requestData:path];
}

- (IBAction)filterButtonTapped:(id)sender {
    ProductFilterViewController *filterVC = [[ProductFilterViewController alloc] initWithNibName:@"ProductFilterViewController" bundle:[NSBundle mainBundle]];
    filterVC.delegate = self;
    
    if (self.isFirstLoad) {
        filterVC.calculatedLowerPrice = 0;
        filterVC.calculatedUpperPrice = 10000000;
        filterVC.isOfficialStore = YES;
        filterVC.isGoldStore = YES;
        filterVC.isWholeSale = NO;
    }
    else {
        filterVC.calculatedLowerPrice = self.calculatedLowerPrice;
        filterVC.calculatedUpperPrice = self.calculatedUpperPrice;
        filterVC.isOfficialStore = self.isOfficialStore;
        filterVC.isGoldStore = self.isGoldStore;
        filterVC.isWholeSale = self.isWholeSale;
    }
    [self.navigationController presentViewController:filterVC animated:YES completion:nil];
}


#pragma request data
- (void)requestData:(NSString *)path {
    self.productList = [[ProductModel alloc] init];
    [self.productList requestData:path completion:^(ProductModel *result) {
        self.productList = result;
    }];
    if (self.productList.receivedProduct.count < 1) {
        self.view.productNotFoundLabel.hidden = NO;
    }
    else {
        self.view.productNotFoundLabel.hidden = YES;
    }
    
}

#pragma ProductFilterDelegate
- (void)prodcutFilterChanged:(BOOL)isWholeSale priceMin:(NSInteger)priceMin priceMax:(NSInteger)priceMax isGoldStore:(BOOL)isGoldStore isOfficialStore:(BOOL)isOfficialStore {
    self.isFirstLoad = NO;
    NSString *path;
    NSString *mainpath = @"https://ace.tokopedia.com/search/v2.5/product?q=samsung&start=0&rows=100";
    NSString *wholeSale, *priceMinimum, *priceMaximum, *officialStore, *goldStore;
    if (isWholeSale) {
        wholeSale = @"&wholesale=true";
    }
    else {
        wholeSale = @"&wholesale=false";
    }
    
    priceMinimum = [NSString stringWithFormat:@"&pmin=%ld", priceMin];
    priceMaximum = [NSString stringWithFormat:@"&pmax=%ld", priceMax];
    officialStore = [NSString stringWithFormat:@"&official=%@", isOfficialStore ? @"true" : @"false"];
    goldStore = isGoldStore ? @"&fshop=2" : @"";
    path = [NSString stringWithFormat:@"%@%@%@%@%@%@", mainpath, wholeSale, priceMinimum, priceMaximum, officialStore, goldStore];
    [self requestData:path];
    [self.view.productCollectionView reloadData];
    
    self.calculatedLowerPrice = priceMin;
    self.calculatedUpperPrice = priceMax;
    self.isOfficialStore = isOfficialStore;
    self.isGoldStore = isGoldStore;
    self.isWholeSale = isWholeSale;
}


#pragma UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.productCollectionView.frame.size.width / 2) - 12 , 250);
}

#pragma UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.productList.receivedProduct.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCollectionViewCell *cell = (ProductCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ProductCollectionViewCell" forIndexPath:indexPath];
    [cell configureProductCell:self.productList.receivedProduct[indexPath.row]];
    return cell;
}


@end
