//
//  JFCollectionViewController.m
//  尝试瀑布流
//
//  Created by Jefferson on 15/10/9.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import "JFCollectionViewController.h"
#import "waterfallLayout.h"
#import "ShopViewModel.h"
#import "waterFallCell.h"
#import <UIImageView+WebCache.h>

@interface JFCollectionViewController () <UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) waterfallLayout *flowLayout;
@property (nonatomic, strong) UICollectionReusableView *reusableView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
//@property (nonatomic, strong) NSMutableArray *shops;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UICollectionReusableView *footerView;
@property (nonatomic, assign, getter = isLoading) BOOL loading;

@end

@implementation JFCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static NSString * const footer = @"foot";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[waterFallCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    ShopViewModel *viewmodel = [ShopViewModel sharedShop];
    
    NSLog(@"%@",viewmodel.shops);
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[ShopViewModel sharedShop] shops].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    waterFallCell *cell = (waterFallCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1];
    
    shop *shopData = [ShopViewModel sharedShop].shops[indexPath.row];
    
    cell.priceTag.text = shopData.price;
    
    NSURL *url = [NSURL URLWithString:shopData.img];
    
    [cell.iconView sd_setImageWithURL:url];
    
    
    // Configure the cell
    
    return cell;
}

// 初始化 控件 frame
- (instancetype)init {
    
    waterfallLayout *flowlayout = [[waterfallLayout alloc] init];
    
    return [super initWithCollectionViewLayout:flowlayout];
}

// 来我组成头部和尾部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    if (kind == UICollectionElementKindSectionFooter) {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer forIndexPath:indexPath];
        footerView.backgroundColor = [UIColor orangeColor];
        
        [footerView addSubview:self.activityIndicator];
        
        CGPoint point = CGPointMake(footerView.bounds.size.width * 0.5, footerView.bounds.size.height * 0.5);
        self.activityIndicator.center = point;
        
        self.activityIndicator.hidden = NO;
        [self.activityIndicator startAnimating];
        
        
        self.footerView = footerView;
        return footerView;
    }
    
    return nil;
}

// 刷新控件
- (UIActivityIndicatorView *)activityIndicator {
    
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicator.color = [UIColor blackColor];
    }
    return _activityIndicator;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.footerView == nil || self.isLoading) {
        return;
    }
    
    if ((scrollView.contentOffset.y + scrollView.bounds.size.height) > self.footerView.frame.origin.y) {
        NSLog(@"开始刷新。。。");
        
        self.loading = YES;
        [self.activityIndicator startAnimating];
        
        // 模拟数据刷新
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            // 释放 footer
            self.footerView = nil;
            
//            [self ];
            self.loading = NO;
            
        });
        
    }

}


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
