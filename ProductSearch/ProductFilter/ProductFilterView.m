//
//  ProductFilterView.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ProductFilterView.h"
#import "PriceRangeSlider.h"

@implementation ProductFilterView

- (void)awakeFromNib {
    [super awakeFromNib];
    _slider = [[PriceRangeSlider alloc] init];
    _slider.translatesAutoresizingMaskIntoConstraints = NO;
    [self.priceSliderView addSubview:self.slider];
    [self.priceSliderView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceSliderView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.slider attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [self.priceSliderView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceSliderView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.slider attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    [self.priceSliderView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceSliderView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.slider attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    [self.priceSliderView addConstraint:[NSLayoutConstraint constraintWithItem:self.priceSliderView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.slider attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:0.0f]];
    [self.slider updateConstraints];
    
    self.goldStoreView.layer.cornerRadius = self.officialStoreView.layer.cornerRadius = 5.0f;
}

@end
