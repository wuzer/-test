//
//  ShopViewModel.h
//  尝试瀑布流
//
//  Created by Jefferson on 15/10/9.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "shop.h"
#import "waterFallCell.h"

@interface ShopViewModel : NSObject

@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic, strong) shop *shopConfig;
@property (nonatomic, strong) waterFallCell *waterCell;

+ (instancetype)sharedShop;

@end
