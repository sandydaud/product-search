//
//  ProductSearchTests.m
//  ProductSearchTests
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ProductModel.h"

@interface ProductSearchTests : XCTestCase

@end

@implementation ProductSearchTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testProductDetailInitWithDictionary {
    NSDictionary *dictionary = @{
                                 @"name":@"hp samsung",
                                 @"price":@"Rp 100000",
                                 @"image_uri":@"www.image.com"
                                 };
    ProductDetail *productDetail = [[ProductDetail alloc] initWithProductDictionary:dictionary];
    XCTAssertEqual(@"hp samsung", productDetail.name, @"");
    XCTAssertEqual(@"Rp 100000", productDetail.price, @"");
    XCTAssertEqual(@"www.image.com", productDetail.imageUrl, @"");
}

- (void)testProductModelInitWithDictionary {
    NSDictionary *dictionary = @{ @"data": @[
                                          @{
                                              @"name":@"hp samsung",
                                              @"price":@"Rp 100000",
                                              @"image_uri":@"www.image.com"
                                              },
                                          @{
                                              @"name":@"tab samsung",
                                              @"price":@"Rp 200000",
                                              @"image_uri":@"www.image2.com"
                                              },
                                          @{
                                              @"name":@"kulkas samsung",
                                              @"price":@"Rp 300000",
                                              @"image_uri":@"www.image3.com"
                                              }
                                          ]};
    
    ProductModel *productModel = [[ProductModel alloc] initWithDictionary:dictionary];
    XCTAssertEqual(3, productModel.receivedProduct.count, @"");
    XCTAssertEqual(@"hp samsung", [productModel.receivedProduct objectAtIndex:0].name, @"");
    XCTAssertEqual(@"Rp 100000", [productModel.receivedProduct objectAtIndex:0].price, @"");
    XCTAssertEqual(@"www.image.com", [productModel.receivedProduct objectAtIndex:0].imageUrl, @"");
    
    XCTAssertEqual(@"tab samsung", [productModel.receivedProduct objectAtIndex:1].name, @"");
    XCTAssertEqual(@"Rp 200000", [productModel.receivedProduct objectAtIndex:1].price, @"");
    XCTAssertEqual(@"www.image2.com", [productModel.receivedProduct objectAtIndex:1].imageUrl, @"");
    
    XCTAssertEqual(@"kulkas samsung", [productModel.receivedProduct objectAtIndex:2].name, @"");
    XCTAssertEqual(@"Rp 300000", [productModel.receivedProduct objectAtIndex:2].price, @"");
    XCTAssertEqual(@"www.image3.com", [productModel.receivedProduct objectAtIndex:2].imageUrl, @"");
}

@end
