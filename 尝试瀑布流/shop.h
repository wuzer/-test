//
//  shop.h
//  尝试瀑布流
//
//  Created by Jefferson on 15/10/9.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface shop : NSObject

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *price;

@property (nonatomic, assign) float w;
@property (nonatomic, assign) float h;

+ (instancetype)shopWithDict:(NSDictionary *)dict;
+ (NSArray *)shopWithIndex:(NSInteger)index;


@end
