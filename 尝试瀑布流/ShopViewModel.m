//
//  ShopViewModel.m
//  尝试瀑布流
//
//  Created by Jefferson on 15/10/9.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import "ShopViewModel.h"
#import <UIImageView+WebCache.h>
#import "waterFallCell.h"

@interface ShopViewModel ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation ShopViewModel

+ (instancetype)sharedShop {
    
    static id instance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (NSMutableArray *)shops {
    
    if (!_shops) {
        _shops = [[NSMutableArray alloc] init];
        [self.shops addObjectsFromArray:[shop shopWithIndex:self.index]];
        
        self.index ++;
    }
    return _shops;
}

- (waterFallCell *)waterCell {
    
    if (!_waterCell) {
        _waterCell = [[waterFallCell alloc] init];
        
        NSURL *url = [NSURL URLWithString:self.shopConfig.img];
        [_waterCell.iconView sd_setImageWithURL:url];
    }
    return _waterCell;
}

@end
