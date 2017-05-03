//
//  UIScrollView+XUNRefresh.h
//  ViperArchitective
//
//  Created by xun on 17/5/1.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XUNRefresh;

@interface UIScrollView (XUNRefresh)

@property (nonatomic, strong) XUNRefresh *headerRefresh;

@property (nonatomic, strong) XUNRefresh *footerRefresh;

@end
