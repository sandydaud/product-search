//
//  ProductViewModel.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 20/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ProductViewModel.h"
#import "ProductModel.h"

@implementation ProductViewModel

- (void)requestData:(NSString *)path {
    self.productList = [[ProductModel alloc] init];
    [self.productList requestData:path completion:^(ProductModel *result) {
        self.productList = result;
    }];
}

@end
