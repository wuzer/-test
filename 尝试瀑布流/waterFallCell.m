//
//  waterFallCell.m
//  尝试瀑布流
//
//  Created by Jefferson on 15/10/10.
//  Copyright © 2015年 Jefferson. All rights reserved.
//

#import "waterFallCell.h"
#import <UIImageView+WebCache.h>
#import "ShopViewModel.h"

@implementation waterFallCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    [self baseConfig];
    
    return self;
}

- (void)baseConfig {
    
    [self.contentView addSubview:self.iconView];
    [self.iconView addSubview:self.priceTag];
    
    _iconView.translatesAutoresizingMaskIntoConstraints = NO;
    _priceTag.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewDict = @{@"icon": _iconView,
                               @"tag": _priceTag};
    
    // iconView
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[icon]-0-|" options:0 metrics:nil views:viewDict]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[icon]-0-|" options:0 metrics:nil views:viewDict]];
    
    // priceTag
    [self.iconView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tag]-0-|" options:0 metrics:nil views:viewDict]];
    [self.iconView addConstraint:[NSLayoutConstraint constraintWithItem:_priceTag attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_iconView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
    [self.iconView addConstraint:[NSLayoutConstraint constraintWithItem:_priceTag attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:30]];
}

- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
//        _iconView.backgroundColor = [UIColor redColor];
        
//        NSURL *url = [NSURL URLWithString:[ShopViewModel sharedShop].shopConfig.img];
//        [self.iconView sd_setImageWithURL:url];
    }
    return _iconView;
}

- (UILabel *)priceTag {
    
    if (!_priceTag) {
        _priceTag = [[UILabel alloc] init];
        _priceTag.textColor = [UIColor blackColor];
        _priceTag.textAlignment = NSTextAlignmentCenter;
        _priceTag.backgroundColor = [UIColor clearColor];
        _priceTag.font = [UIFont systemFontOfSize:14];
    }
    return _priceTag;
}

@end
