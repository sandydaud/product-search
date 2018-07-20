//
//  PriceRangeSlider.h
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PriceRangeSlider;
@protocol PriceSliderDelegate <NSObject>

- (void)rangeSliderValueChanged:(PriceRangeSlider *)rangeSlider;

@end

@interface PriceRangeSlider : UIView
@property (weak, nonatomic) IBOutlet UIView *wholeTrackView;
@property (weak, nonatomic) IBOutlet UIView *leftCursorView;
@property (weak, nonatomic) IBOutlet UIView *rightCursorView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCursorViewLeadingConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightCursorViewTrailingConstraint;

@property (weak, nonatomic) id<PriceSliderDelegate> delegate;

@end
