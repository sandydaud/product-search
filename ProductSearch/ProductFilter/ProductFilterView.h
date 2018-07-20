//
//  ProductFilterView.h
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PriceRangeSlider;
@interface ProductFilterView : UIView

@property (strong, nonatomic) PriceRangeSlider *slider;
@property (weak, nonatomic) IBOutlet UIButton *applyButton;
@property (weak, nonatomic) IBOutlet UISwitch *wholeSaleToggleButton;
@property (weak, nonatomic) IBOutlet UITextField *minimumPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *maximumPriceTextField;
@property (weak, nonatomic) IBOutlet UIView *priceSliderView;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UIButton *shopTypeDetailButton;

@property (weak, nonatomic) IBOutlet UIView *goldStoreView;
@property (weak, nonatomic) IBOutlet UIButton *removeGoldStoreButton;
@property (weak, nonatomic) IBOutlet UIView *officialStoreView;
@property (weak, nonatomic) IBOutlet UIButton *removeOfficialStoreButton;


@end
