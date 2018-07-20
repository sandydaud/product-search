//
//  ProductModel.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ProductModel.h"

@implementation ProductModel

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.receivedProduct = [[NSMutableArray alloc] init];
        NSObject *receivedProduct = [dictionary objectForKey:@"data"];
        for (NSDictionary *item in (NSArray *)receivedProduct) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                ProductDetail *productDetail = [[ProductDetail alloc] initWithProductDictionary:item];
                [self.receivedProduct addObject:productDetail];
            }
        }
    }
    return self;
}

- (void)requestData:(NSString *)path completion:(void (^)(ProductModel *))completion {
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    ProductModel *productModel = [[ProductModel alloc] initWithDictionary:dict];
    if (completion) {
        completion(productModel);
    }
}

@end

@implementation ProductDetail

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (instancetype)initWithProductDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = [self objectOrNilForKey:@"name" fromDictionary:dictionary];
        self.price = [self objectOrNilForKey:@"price" fromDictionary:dictionary];
        self.imageUrl = [self objectOrNilForKey:@"image_uri" fromDictionary:dictionary];
    }
    return self;
}
@end
