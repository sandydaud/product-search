//
//  ProductViewModel.h
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 20/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductModel;

@interface ProductViewModel : NSObject


@property (strong, nonatomic) ProductModel *productList;
@property (nonatomic) double calculatedUpperPrice, calculatedLowerPrice;
@property (assign, nonatomic) BOOL isGoldStore, isOfficialStore, isWholeSale, isFirstLoad;
@property (copy, nonatomic) void (^didUpdate)(void);

@end
