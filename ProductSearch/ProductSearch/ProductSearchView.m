//
//  ProductSearchView.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 18/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "ProductSearchView.h"

@implementation ProductSearchView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.navigationTitle.title = @"Search";
    [self setFilterButton];
}

- (void)setFilterButton {
    [self.filterButton setTitle:@"Filter" forState:UIControlStateNormal];
    self.filterButton.layer.cornerRadius = 4.0f;
    
    self.filterButton.layer.masksToBounds = NO;
    self.filterButton.layer.shadowOffset = CGSizeMake(0, -2);
    self.filterButton.layer.shadowRadius = 10.0;
    self.filterButton.layer.shadowOpacity = 0.3;
    self.filterButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
}

@end
