//
//  SecondProductFilterViewController.h
//  ProductSearch
//
//  Created by Daud Sandy Christianto on 19/07/18.
//  Copyright © 2018 Daud Sandy Christianto. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SecondProductFilterDelegate <NSObject>
@optional

- (void)secondProdcutFilterChanged:(BOOL)isGoldStore isOfficialStore:(BOOL)isOfficialStore;

@end

@interface SecondProductFilterViewController : UIViewController

@property (weak, nonatomic) id<SecondProductFilterDelegate> delegate;
@property (assign, nonatomic) BOOL isGoldStore, isOfficialStore;

@end
