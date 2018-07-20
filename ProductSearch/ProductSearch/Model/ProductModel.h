//
//  ProductModel.h
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ProductDetail;

@interface ProductModel : NSObject

@property (strong, nonatomic) NSMutableArray<ProductDetail *> *receivedProduct;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
- (void)requestData:(NSString *)path completion:(void (^)(ProductModel *))completion;

@end


@interface ProductDetail : NSObject


@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *imageUrl;

- (instancetype)initWithProductDictionary:(NSDictionary *)dictionary;

@end
