//
//  ProductCollectionViewCell.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ProductCollectionViewCell.h"
#import "ProductModel.h"

@implementation ProductCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 4.0f;
}

- (void)configureProductCell:(ProductDetail *)productDetail {
    self.productName.text = productDetail.name;
    self.productPrice.text = productDetail.price;
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:productDetail.imageUrl]];
    self.productImage.image = [UIImage imageWithData:imageData];
    
    
}

@end
