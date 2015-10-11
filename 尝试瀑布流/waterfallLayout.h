//
//  waterfallLayout.h
//  尝试瀑布流
//
//  Created by Jefferson on 15/10/9.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface waterfallLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) NSInteger columnCount;
@property (nonatomic, strong) NSArray *dataList;

@end
