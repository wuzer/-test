//
//  waterfallLayout.m
//  尝试瀑布流
//
//  Created by Jefferson on 15/10/9.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import "waterfallLayout.h"
#import "ShopViewModel.h"
#import "shop.h"


#define columnCount 3

@interface waterfallLayout ()

@property (nonatomic, strong) NSArray *layoutAttributes;

@end

@implementation waterfallLayout

- (void)prepareLayout {
    
    self.footerReferenceSize = CGSizeMake(self.collectionView.bounds.size.width, 60);
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.dataList = [ShopViewModel sharedShop].shops;
    // item 的宽度
    CGFloat contentWidth = self.collectionView.frame.size.width - self.sectionInset.left - self.sectionInset.right;
    CGFloat itemWidth = (contentWidth - (columnCount - 1) * self.minimumInteritemSpacing) / columnCount;
    [self attributes:itemWidth];
}

- (void)attributes:(CGFloat)itemWidth {
    
    // 列高数组
    CGFloat colHeight[columnCount];
    NSInteger colCount[columnCount];
    
    for (int i=0; i < columnCount; ++i) {
        colHeight[i] = self.sectionInset.top;
        colCount[i] = 0;
    }
    
    // 总 item 高
    CGFloat totalItemHeight = 0;
    
    //
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:self.dataList.count];
    
    NSInteger index = 0;
    for (shop *obj in self.dataList) {
        
        // 建立布局属性
        NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:0];
        UICollectionViewLayoutAttributes *attrinutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:path];
        
        // 计算列数
//        NSInteger col = index % columnCount;
        NSInteger col = [self shortestCol:colHeight];
        
        colCount[col]++;
        
        // 设置 frame
        CGFloat x = self.sectionInset.left + col * (itemWidth + self.minimumInteritemSpacing);
        CGFloat y = colHeight[col];
        
        CGFloat height = [self itemHeightWith:CGSizeMake(obj.w, obj.h) itemWidth:itemWidth];
        
        totalItemHeight += height;
        
        attrinutes.frame = CGRectMake(x, y, itemWidth, height);
        // 累加高度
        colHeight[col] += height + self.minimumInteritemSpacing;
        index ++;
        
        [tempArray addObject:attrinutes];
    }
    
    // 设置 item 大小
    NSInteger highestCol = [self highestCol:colHeight];
    CGFloat hight = (colHeight[highestCol] - colCount[highestCol] * self.minimumInteritemSpacing) / colCount[highestCol];
    
    self.itemSize = CGSizeMake(itemWidth, hight);
    
    // 添加页脚属性
    UICollectionViewLayoutAttributes *footer = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    footer.frame = CGRectMake(0, colHeight[highestCol], self.collectionView.bounds.size.width, 50);
    
    [tempArray addObject:footer];
   
    // 给属性数组设置数值
    self.layoutAttributes = tempArray.copy;
}

// 计算最高列
- (NSInteger)highestCol:(CGFloat *)colHeight {
    
    CGFloat max = 0;
    NSInteger col = 0;
    
    for (int i=0; i < columnCount; ++i) {
        if (colHeight[i] > max) {
            max = colHeight[i];
            col = i;
        }
    }
    return col;
}

// 计算最短列
- (NSInteger)shortestCol:(CGFloat *)colHeight {

    CGFloat min = MAXFLOAT;
    NSInteger col = 0;
    
    for (int i=0; i < columnCount; ++i) {
        if (colHeight[i] < min) {
            min = colHeight[i];
            col = i;
        }
    }
    return col;
}


// 计算 itemsize等比例宽高
- (CGFloat)itemHeightWith:(CGSize)size itemWidth:(CGFloat)width {
    
    return size.height * width / size.width;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    
    NSLog(@"%@",array);
    // 返回计算好的属性数组
    return self.layoutAttributes;
}

@end
