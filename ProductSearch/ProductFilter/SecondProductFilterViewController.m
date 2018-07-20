//
//  SecondProductFilterViewController.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 19/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "SecondProductFilterViewController.h"
#import "SecondProductFilterView.h"

@interface SecondProductFilterViewController ()
@property (strong, nonatomic) SecondProductFilterView *view;

@end

@implementation SecondProductFilterViewController
@dynamic view;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setButtonColor:self.view.goldStoreButton selected:self.isGoldStore];
    [self setButtonColor:self.view.officialStoreButton selected:self.isOfficialStore];
}

- (IBAction)goldStoreButtonTapped:(UIButton *)sender {
    self.isGoldStore = !self.isGoldStore;
    [self setButtonColor:sender selected:self.isGoldStore];
}

- (IBAction)officialStoreButtonTapped:(UIButton *)sender {
    self.isOfficialStore = !self.isOfficialStore;
    [self setButtonColor:sender selected:self.isOfficialStore];
}

- (IBAction)resetButtonTapped:(id)sender {
    self.isGoldStore = self.isOfficialStore = NO;
    [self setButtonColor:self.view.goldStoreButton selected:NO];
    [self setButtonColor:self.view.officialStoreButton selected:NO];
}

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)applyButtonTapped:(id)sender {
    if ([self.delegate respondsToSelector:@selector(secondProdcutFilterChanged:isOfficialStore:)]) {
        [self.delegate secondProdcutFilterChanged:self.isGoldStore isOfficialStore:self.isOfficialStore];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)setButtonColor:(UIButton *)sender selected:(BOOL)selected{
    if (selected) {
        [self setButtonSelected:sender];
    }
    else {
        [self setButtonUnselected:sender];
    }
}

- (void)setButtonSelected:(UIButton *)sender {
    [sender setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:1] forState:UIControlStateNormal];
    [sender setBackgroundColor:[UIColor colorWithRed:99.0/256.0 green:208.0/256.0 blue:81.0/256.0 alpha:1.0]];
}

- (void)setButtonUnselected:(UIButton *)sender {
    [sender setTitleColor:[[UIColor darkGrayColor] colorWithAlphaComponent:1] forState:UIControlStateNormal];
    [sender setBackgroundColor:[UIColor whiteColor]];
}


@end
