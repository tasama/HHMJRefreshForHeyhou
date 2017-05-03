//
//  UIScrollView+XUNRefresh.m
//  ViperArchitective
//
//  Created by xun on 17/5/1.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import "UIScrollView+XUNRefresh.h"
#import <objc/runtime.h>
#import "XUNRefresh.h"

#define kXUNHeaderRefreshKey   "XUN_HEADER_REFRESH_KEY"

@implementation UIScrollView (XUNRefresh)

- (void)setHeaderRefresh:(XUNRefresh *)headerRefresh {
    
    headerRefresh.frame = CGRectMake(0, -headerRefresh.frame.size.height - headerRefresh.ignoreContentInsetHeight, self.frame.size.width, 40);
    [self addSubview:headerRefresh];
    objc_setAssociatedObject(self, kXUNHeaderRefreshKey, headerRefresh, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (XUNRefresh *)headerRefresh {
    
    return objc_getAssociatedObject(self, kXUNHeaderRefreshKey);
}

@end
