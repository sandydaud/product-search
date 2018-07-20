//
//  SecondProductFilterView.m
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 19/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import "SecondProductFilterView.h"

@implementation SecondProductFilterView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.goldStoreButton.layer.cornerRadius = self.officialStoreButton.layer.cornerRadius = 5.0f;
}

@end
