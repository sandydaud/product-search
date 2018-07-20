//
//  PriceRangeSlider.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "PriceRangeSlider.h"

static CGFloat padding = 0.0f;

@interface PriceRangeSlider ()
@property (weak, nonatomic) IBOutlet UIView *selectedRangeTrackedView;
@property (weak, nonatomic) IBOutlet UIPanGestureRecognizer *leftCursorGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIPanGestureRecognizer *rightCursorGestureRecognizer;
@property (weak, nonatomic) IBOutlet UIView *staticLeftView;
@property (weak, nonatomic) IBOutlet UIView *staticRightView;



@property (assign, nonatomic) CGFloat startLeftThumbTranslationLeading;
@property (assign, nonatomic) CGFloat startRightThumbTranslationTrailing;
@property (strong, nonatomic) NSArray *pointViews;
@property (strong, nonatomic) NSArray *pointLayers;
@end

@implementation PriceRangeSlider


- (instancetype)init {
    self = [[[UINib nibWithNibName:@"PriceRangeSlider" bundle:[NSBundle mainBundle]] instantiateWithOwner:nil options:nil] firstObject];
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    CALayer *greenLayer = [CALayer layer];
    greenLayer.frame = CGRectMake((CGRectGetHeight(self.leftCursorView.frame) - 25.0f) /2.0f, (CGRectGetHeight(self.leftCursorView.frame) - 25.0f) /2.0f, 25.0f, 25.0f);
    greenLayer.backgroundColor = self.selectedRangeTrackedView.backgroundColor.CGColor;
    greenLayer.cornerRadius = CGRectGetHeight(greenLayer.frame) / 2.0f;
    [self.leftCursorView.layer addSublayer:greenLayer];
    CALayer *greenLayer2 = [CALayer layer];
    greenLayer2.frame = CGRectMake((CGRectGetHeight(self.leftCursorView.frame) - 25.0f) /2.0f, (CGRectGetHeight(self.leftCursorView.frame) - 25.0f) /2.0f, 25.0f, 25.0f);
    greenLayer2.backgroundColor = self.selectedRangeTrackedView.backgroundColor.CGColor;
    greenLayer2.cornerRadius = CGRectGetHeight(greenLayer.frame) / 2.0f;
    [self.rightCursorView.layer addSublayer:greenLayer2];
    self.staticLeftView.layer.cornerRadius = CGRectGetHeight(self.staticLeftView.frame) / 2;
    self.staticRightView.layer.cornerRadius = CGRectGetHeight(self.staticRightView.frame) / 2;
    [self bringSubviewToFront:self.leftCursorView];
    [self bringSubviewToFront:self.rightCursorView];
}

- (IBAction)leftCursorDraged:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self bringSubviewToFront:self.leftCursorView];
        self.startLeftThumbTranslationLeading = self.leftCursorViewLeadingConstraint.constant;
    }
    else {
        CGPoint translation = [sender translationInView:self];
        CGFloat endX = self.startLeftThumbTranslationLeading + translation.x;
        CGFloat rightLimit = self.frame.size.width - self.rightCursorViewTrailingConstraint.constant - self.rightCursorView.frame.size.width - 4;
        endX = endX < padding ? padding : endX > rightLimit ? rightLimit : endX;
        self.leftCursorViewLeadingConstraint.constant = endX;
        [self layoutIfNeeded];
        if ([self.delegate respondsToSelector:@selector(rangeSliderValueChanged:)]) {
            [self.delegate rangeSliderValueChanged:self];
        }
        
    }
    
}

- (IBAction)rightCursorDraged:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self bringSubviewToFront:self.rightCursorView];
        self.startRightThumbTranslationTrailing = self.rightCursorViewTrailingConstraint.constant;
    }
    else if (sender.state != UIGestureRecognizerStateEnded) {
        CGPoint translation = [sender translationInView:self];
        CGFloat endTrailing = self.startRightThumbTranslationTrailing - translation.x;
        CGFloat leftLimit = self.frame.size.width - self.leftCursorViewLeadingConstraint.constant - self.rightCursorView.frame.size.width - 4;
        endTrailing = endTrailing < padding ? padding : endTrailing > leftLimit ? leftLimit : endTrailing;
        self.rightCursorViewTrailingConstraint.constant = endTrailing;
        [self layoutIfNeeded];
        if ([self.delegate respondsToSelector:@selector(rangeSliderValueChanged:)]) {
            [self.delegate rangeSliderValueChanged:self];
        }
    }
}

- (BOOL)resignFirstResponder {
    self.leftCursorGestureRecognizer.enabled = self.rightCursorGestureRecognizer.enabled = NO;
    self.leftCursorGestureRecognizer.enabled = self.rightCursorGestureRecognizer.enabled = YES;
    return YES;
}

@end
