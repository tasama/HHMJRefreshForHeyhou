//
//  XUNRefresh.h
//  ViperArchitective
//
//  Created by xun on 17/5/1.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XUNRefresh : UIView

@property (nonatomic, readonly) UIScrollView *scrollView;

@property (nonatomic, assign) CGFloat ignoreContentInsetHeight;

+ (instancetype)refresh;

+ (instancetype)refreshWithTarget:(id)target
                         selector:(SEL)selector;

+ (instancetype)refreshWithBlock:(void (^)())freshBlock;

- (void)showAnimation;

- (void)endAnimation;

@end
