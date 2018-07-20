//
//  ProductFilterViewController.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ProductFilterViewController.h"
#import "ProductFilterView.h"
#import "PriceRangeSlider.h"
#import "SecondProductFilterViewController.h"

static NSInteger minimumPrice = 0;
static NSInteger maximumPrice = 10000000;

@interface ProductFilterViewController () <PriceSliderDelegate, UITextFieldDelegate, SecondProductFilterDelegate>

@property (strong, nonatomic) ProductFilterView *view;

@end

@implementation ProductFilterViewController
@dynamic view;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.slider.delegate = self;
    self.view.minimumPriceTextField.delegate = self.view.maximumPriceTextField.delegate = self;
    [self addDoneButtonWhenKeyboardShowing];
    [self setUpInitialView];
}

- (void)setUpInitialView {
    [self updatePriceTextFields];
    [self.view.wholeSaleToggleButton setOn:self.isWholeSale];
    self.view.officialStoreView.hidden = !self.isOfficialStore;
    self.view.goldStoreView.hidden = !self.isGoldStore;
}

- (void)addDoneButtonWhenKeyboardShowing {
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Selesai", nil)
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(doneButtonTapped:)];
    doneButton.accessibilityIdentifier = @"common.keyboard-toolbar.button.done";
    
    UIToolbar *textViewToolbar = [[UIToolbar alloc] init];
    textViewToolbar.backgroundColor = [UIColor whiteColor];
    textViewToolbar.items = @[flexibleSpace, doneButton];
    [textViewToolbar sizeToFit];
    
    self.view.minimumPriceTextField.inputAccessoryView = textViewToolbar;
    self.view.maximumPriceTextField.inputAccessoryView = textViewToolbar;
}

#pragma mark - done button when keyboard showing
- (void)doneButtonTapped:(id)sender {
    [self.view.minimumPriceTextField resignFirstResponder];
    [self.view.maximumPriceTextField resignFirstResponder];
}

#pragma mark - button actions
- (IBAction)applyButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(prodcutFilterChanged:priceMin:priceMax:isGoldStore:isOfficialStore:)]) {
        [self.delegate prodcutFilterChanged:self.view.wholeSaleToggleButton.isOn priceMin:self.calculatedLowerPrice priceMax:self.calculatedUpperPrice isGoldStore:self.isGoldStore isOfficialStore:self.isOfficialStore];
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)closeButtonTapped:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)resetButtonTapped:(id)sender {
    [self.view.wholeSaleToggleButton setOn:NO];
    self.calculatedLowerPrice = 0;
    self.calculatedUpperPrice = 10000000;
    [self updatePriceTextFields];
}

- (IBAction)removeGoldStoreButtonTapped:(id)sender {
    self.view.goldStoreView.hidden = YES;
    self.isGoldStore = NO;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.officialStoreView.frame = CGRectMake(self.view.goldStoreView.frame.origin.x, self.view.officialStoreView.frame.origin.y, self.view.officialStoreView.frame.size.width, self.view.officialStoreView.frame.size.height);
    }];
}

- (IBAction)removeOfficialStoreButtonTapped:(id)sender {
    self.view.officialStoreView.hidden = YES;
    self.isOfficialStore = NO;
}

#pragma mark - price filter
- (NSInteger) priceFinalRounding:(NSInteger)price {
    NSInteger roundedPrice = 0;
    if (price > 10000000) {
        roundedPrice = (price / 1000000) * 1000000;
    }
    else if (price > 1000000) {
        roundedPrice = (price / 100000) * 100000;
    }
    else if (price > 100000) {
        roundedPrice = (price / 10000) * 10000;
    }
    else if (price > 10000) {
        roundedPrice = (price / 1000) * 1000;
    }
    else if (price > 1000) {
        roundedPrice = (price / 100) * 100;
    }
    else if (price > 100) {
        roundedPrice = (price / 10) * 10;
    }
    else {
        roundedPrice = (price / 1) * 1;
    }
    
    return roundedPrice;
}

- (double)calculatePriceRangeWithCenterX:(double)viewX
                         wholeTrackWidth:(double)wholeTrackWidth {
    double returnedPrice = 0.0;
    if (viewX <= wholeTrackWidth / 2) {
        returnedPrice = viewX / (wholeTrackWidth * 0.5) * 0.05;
    }
    else if (viewX <= 3 * (wholeTrackWidth / 4)) {
        returnedPrice = 0.05 + (((viewX - wholeTrackWidth * 0.5) / (wholeTrackWidth * 0.25)) * 0.20);
    }
    else {
        returnedPrice = 0.05 + 0.20 + (((viewX - 0.75 * wholeTrackWidth) / (wholeTrackWidth * 0.25)) * 0.75);
    }
    
    returnedPrice = (returnedPrice - fmod(returnedPrice, 0.001)) * 10000000;
    return returnedPrice;
}

- (void)rangeSliderValueChanged:(PriceRangeSlider *)rangeSlider {
    [self.view.minimumPriceTextField resignFirstResponder];
    [self.view.maximumPriceTextField resignFirstResponder];
    
    NSString *upperPriceRange = nil;
    NSString *lowerPriceRange = nil;
    
    if (rangeSlider.leftCursorView.center.x - 20 == 0) {
        self.calculatedLowerPrice = 0;
    }
    else {
        self.calculatedLowerPrice = [self calculatePriceRangeWithCenterX:rangeSlider.leftCursorView.center.x - 20 wholeTrackWidth:CGRectGetWidth(rangeSlider.wholeTrackView.frame)];
        self.calculatedLowerPrice = [self priceFinalRounding:self.calculatedLowerPrice];
    }
    if (rangeSlider.rightCursorView.center.x - 20 == CGRectGetWidth(rangeSlider.wholeTrackView.frame)) {
        self.calculatedUpperPrice = maximumPrice;
    }
    else {
        self.calculatedUpperPrice = [self calculatePriceRangeWithCenterX:rangeSlider.rightCursorView.center.x - 20 wholeTrackWidth:CGRectGetWidth(rangeSlider.wholeTrackView.frame)];
        self.calculatedUpperPrice = [self priceFinalRounding:self.calculatedUpperPrice];
    }
    
    lowerPriceRange = [self formattedCurrencyWithCurrencySign:@"IDR" value:self.calculatedLowerPrice showSign:YES];
    if (self.calculatedUpperPrice == maximumPrice) {
        upperPriceRange = [self formattedCurrencyWithCurrencySign:@"IDR" value:self.calculatedUpperPrice showSign:YES];
    }
    else {
        upperPriceRange = [self formattedCurrencyWithCurrencySign:@"IDR" value:self.calculatedUpperPrice showSign:YES];
    }
    
    self.view.minimumPriceTextField.text = lowerPriceRange;
    self.view.maximumPriceTextField.text = upperPriceRange;
}

- (void)updatePriceTextFields {
    NSString *lowerPriceRange, *upperPriceRange;
    lowerPriceRange = [self formattedCurrencyWithCurrencySign:@"IDR" value:self.calculatedLowerPrice showSign:YES];
    
    if (self.calculatedUpperPrice >= maximumPrice) {
        self.calculatedUpperPrice = maximumPrice;
        upperPriceRange = [self formattedCurrencyWithCurrencySign:@"IDR" value:self.calculatedUpperPrice  showSign:YES];
    }
    else {
        upperPriceRange = [self formattedCurrencyWithCurrencySign:@"IDR" value:self.calculatedUpperPrice showSign:YES];
    }
    
    self.view.minimumPriceTextField.text = lowerPriceRange;
    self.view.maximumPriceTextField.text = upperPriceRange;
    
    [self updatePriceSliderWithView:self.view.slider.leftCursorView withPrice:self.calculatedLowerPrice];
    [self updatePriceSliderWithView:self.view.slider.rightCursorView withPrice:self.calculatedUpperPrice];
}

- (void)updatePriceSliderWithView:(UIView *)sliderView
                        withPrice:(double)price {
    if (price > maximumPrice) {
        price = maximumPrice;
    }
    else if (price < 0) {
        price = 0;
    }
    CGRect frame = sliderView.frame;
    double expectedPoint = price / maximumPrice;
    
    if (expectedPoint < 0.05) {
        frame.origin.x = expectedPoint * 20 * (0.5 * CGRectGetWidth(self.view.slider.wholeTrackView.frame));
    }
    else if (expectedPoint >= 0.05 && expectedPoint < 0.25) {
        frame.origin.x = (0.5 * CGRectGetWidth(self.view.slider.wholeTrackView.frame)) + ((expectedPoint - 0.05) * 5) * (0.25 * CGRectGetWidth(self.view.slider.wholeTrackView.frame));
    }
    else {
        frame.origin.x = (0.75 * CGRectGetWidth(self.view.slider.wholeTrackView.frame)) + ((expectedPoint - 0.25) * 10 / 7.5) * (0.25 * CGRectGetWidth(self.view.slider.wholeTrackView.frame));
    }
    if (!isnan(frame.origin.x)) {
        if (sliderView == self.view.slider.leftCursorView ) {
            self.view.slider.leftCursorViewLeadingConstraint.constant = frame.origin.x;
            if (self.view.slider.leftCursorViewLeadingConstraint.constant < 0 ) {
                self.view.slider.leftCursorViewLeadingConstraint.constant = 0;
            }
            else if (self.view.slider.leftCursorViewLeadingConstraint.constant > CGRectGetWidth(self.view.slider.wholeTrackView.frame)) {
                self.view.slider.leftCursorViewLeadingConstraint.constant = CGRectGetWidth(self.view.slider.wholeTrackView.frame);
            }
        }
        else {
            self.view.slider.rightCursorViewTrailingConstraint.constant = CGRectGetWidth(self.view.slider.wholeTrackView.frame) - frame.origin.x;
            if (self.view.slider.rightCursorViewTrailingConstraint.constant < 0 ) {
                self.view.slider.rightCursorViewTrailingConstraint.constant = 0;
            }
            else if (self.view.slider.rightCursorViewTrailingConstraint.constant > CGRectGetWidth(self.view.slider.wholeTrackView.frame)) {
                self.view.slider.rightCursorViewTrailingConstraint.constant = CGRectGetWidth(self.view.slider.wholeTrackView.frame);
            }
            
        }
    }
    [self.view layoutIfNeeded];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSString *currencySign = @"IDR";
    
    if (textField == self.view.minimumPriceTextField) {
        if (self.calculatedLowerPrice == 0) {
            textField.text = @"0";
        }
        else {
            NSString *shownPriceString= [NSString stringWithFormat:@"%ld", (long)(self.calculatedLowerPrice)];
            textField.text = [self formattedCurrencyWithCurrencySign:currencySign value:[shownPriceString integerValue] showSign:NO];
        }
    }
    else if (textField == self.view.maximumPriceTextField) {
        if (self.calculatedUpperPrice == 0) {
            textField.text = @"0";
        }
        else {
            NSString *shownPriceString = [NSString stringWithFormat:@"%ld", (long)(self.calculatedUpperPrice)];
            textField.text = [self formattedCurrencyWithCurrencySign:currencySign value:[shownPriceString integerValue] showSign:NO];
        }
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    NSString *allNumberPriceString = [[textField.text componentsSeparatedByCharactersInSet:
                                       [[NSCharacterSet decimalDigitCharacterSet] invertedSet]]
                                      componentsJoinedByString:@""];
    if (textField == self.view.minimumPriceTextField) {
        self.calculatedLowerPrice = [allNumberPriceString doubleValue];
        
        if (self.calculatedLowerPrice >= self.calculatedUpperPrice) {
            self.calculatedUpperPrice = ceil(self.calculatedLowerPrice + (self.calculatedLowerPrice * 0.25));
        }
        
        if (self.calculatedLowerPrice >= maximumPrice) {
            self.calculatedLowerPrice = ceil(maximumPrice - (maximumPrice * 0.05));
        }
        
        [self.view.slider bringSubviewToFront:self.view.slider.leftCursorView];
    }
    else if (textField == self.view.maximumPriceTextField) {
        self.calculatedUpperPrice = [allNumberPriceString doubleValue];
        
        if (self.calculatedUpperPrice <= minimumPrice) {
            self.calculatedUpperPrice = ceil(minimumPrice * 0.05);
        }
        
        if (self.calculatedLowerPrice >= self.calculatedUpperPrice) {
            self.calculatedLowerPrice = ceil(self.calculatedUpperPrice - (self.calculatedUpperPrice * 0.25));
        }
        
        [self.view.slider bringSubviewToFront:self.view.slider.rightCursorView];
    }
    [self updatePriceTextFields];
}

#pragma mark - currency settings
- (NSString *)formattedCurrencyWithCurrencySign:(NSString *)currencySign value:(NSInteger)value  showSign:(BOOL)isShowSign {
    NSNumberFormatter *numberFormatter = [self numberFormatterForCurrencySign:@"IDR"];
    
    NSNumber *number = [NSNumber numberWithDouble:((double)value / pow(10, 0))];
    if (isShowSign) {
        BOOL isMinus = value < 0;
        
        if (isMinus) {
            number = [NSNumber numberWithDouble:ABS([number doubleValue])];
        }
        
        NSString *prefix = isMinus ? @"-" : @"";
        NSString *numberString = [numberFormatter stringFromNumber:number];
        
        return [NSString stringWithFormat:@"%@%@ %@", prefix, currencySign, numberString];
        
    }
    else {
        return [numberFormatter stringFromNumber:number];
    }
}

- (NSNumberFormatter *)numberFormatterForCurrencySign:(NSString *)currencySign {
    static NSNumberFormatter *numberFormatter;
    
    if (numberFormatter == nil) {
        numberFormatter = [[NSNumberFormatter alloc] init];
        numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
        numberFormatter.usesGroupingSeparator = YES;
    }
    
    numberFormatter.minimumFractionDigits = 0;
    numberFormatter.groupingSeparator = @".";
    numberFormatter.decimalSeparator = @",";
    
    
    return numberFormatter;
}

#pragma mark - navigation
- (UIViewController*) topMostController {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    
    return topController;
}

- (IBAction)shopTypeDetailTapped:(id)sender {
    SecondProductFilterViewController *secondVC = [[SecondProductFilterViewController alloc] initWithNibName:@"SecondProductFilterViewController" bundle:[NSBundle mainBundle]];
    secondVC.delegate = self;
    secondVC.isGoldStore = self.isGoldStore;
    secondVC.isOfficialStore = self.isOfficialStore;
    UIViewController *top = [self topMostController];
    [top presentViewController:secondVC animated:YES completion: nil];
}

#pragma mark - secondProductFilterDelegate
- (void)secondProdcutFilterChanged:(BOOL)isGoldStore isOfficialStore:(BOOL)isOfficialStore {
    self.isGoldStore = isGoldStore;
    self.view.goldStoreView.hidden = !isGoldStore;
    self.isOfficialStore = isOfficialStore;
    self.view.officialStoreView.hidden = !isOfficialStore;
    
    if (self.isGoldStore) {
        self.view.officialStoreView.frame = CGRectMake(165, self.view.officialStoreView.frame.origin.y, self.view.officialStoreView.frame.size.width, self.view.officialStoreView.frame.size.height);
    }
    else {
        if (self.isOfficialStore) {
            self.view.officialStoreView.frame = CGRectMake(self.view.goldStoreView.frame.origin.x, self.view.officialStoreView.frame.origin.y, self.view.officialStoreView.frame.size.width, self.view.officialStoreView.frame.size.height);
        }
    }
}


@end
