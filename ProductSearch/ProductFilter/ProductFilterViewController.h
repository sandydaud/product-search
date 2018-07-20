//
//  ProductFilterViewController.h
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ProductFilterDelegate <NSObject>
@optional

- (void)prodcutFilterChanged:(BOOL)isWholeSale priceMin:(NSInteger)priceMin priceMax:(NSInteger)priceMax isGoldStore:(BOOL)isGoldStore isOfficialStore:(BOOL)isOfficialStore;

@end

@interface ProductFilterViewController : UIViewController
@property (weak, nonatomic) id<ProductFilterDelegate> delegate;
@property (nonatomic) double calculatedUpperPrice, calculatedLowerPrice;
@property (assign, nonatomic) BOOL isGoldStore, isOfficialStore, isWholeSale;

@end
