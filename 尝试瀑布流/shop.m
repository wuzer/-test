//
//  shop.m
//  尝试瀑布流
//
//  Created by Jefferson on 15/10/9.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import "shop.h"

@implementation shop

+ (instancetype)shopWithDict:(NSDictionary *)dict {
    
    shop *object = [[self alloc] init];
    [object setValuesForKeysWithDictionary:dict];
    return object;
}

+ (NSArray *)shopWithIndex:(NSInteger)index {
    
    NSString *plistName = [NSString stringWithFormat:@"%zd.plist",(index % 3) + 1];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    
    NSArray *array = [NSArray arrayWithContentsOfFile:plistPath];
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tempArray addObject:[self shopWithDict:obj]];
    }];
    
    return tempArray.copy;
}

@end
