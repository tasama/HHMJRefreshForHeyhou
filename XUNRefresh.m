//
//  XUNRefresh.m
//  ViperArchitective
//
//  Created by xun on 17/5/1.
//  Copyright © 2017年 Xun. All rights reserved.
//

#import "XUNRefresh.h"

@interface XUNRefresh ()

@property (nonatomic, strong) UIView *view;
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, assign) id target;
@property (nonatomic, assign) SEL selector;

@property (nonatomic, copy) void (^FreshBlock)();

@end

@implementation XUNRefresh

+ (instancetype)refresh {
    
    XUNRefresh *refresh = [[XUNRefresh alloc] init];
    
    [refresh addSubview:refresh.lab];
    [refresh addSubview:refresh.view];
    
    return refresh;
}

+ (instancetype)refreshWithBlock:(void (^)())freshBlock {
    
    XUNRefresh *refresh = [XUNRefresh refresh];
    
    refresh.FreshBlock = freshBlock;
    
    return refresh;
}

+ (instancetype)refreshWithTarget:(id)target selector:(SEL)selector {
    
    XUNRefresh *refresh = [XUNRefresh refresh];
    
    refresh.target = target;
    refresh.selector = selector;
    
    return refresh;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    self.lab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    CGRect frame = self.frame;
    
    frame.origin.y = -_ignoreContentInsetHeight - frame.size.height;
    
    self.frame = frame;
}

- (void)setIgnoreContentInsetHeight:(CGFloat)ignoreContentInsetHeight {
    
    _ignoreContentInsetHeight = ignoreContentInsetHeight;
    
    [self layoutIfNeeded];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    
    [self.superview removeObserver:self forKeyPath:@"contentOffset"];
    
    [newSuperview addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    [super willMoveToSuperview:newSuperview];
    
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        CGPoint new = [change[@"new"] CGPointValue];
        
        if (new.y < self.frame.origin.y) {
            
            if (self.scrollView.isDragging) {
                
                self.lab.text = @"释放刷新数据";
            }
            else {
                
                self.lab.text = @"";
                
                [self showAnimation];
                
            }
        }
    }
}

- (void)showAnimation {
    
//    CABasicAnimation *animation = [CABasicAnimation animation];
//    
//    animation.keyPath = @"frame";
//
//    animation.fromValue = [NSValue valueWithCGRect:CGRectMake(self.frame.size.width / 2, self.frame.size.height / 2 - 10, 0, 0)];
//    
//    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, self.frame.size.height / 2 - 10, self.frame.size.width, 20)];
    
//    animation.duration = 1.f;
//    
//    animation.repeatCount = CGFLOAT_MAX;
//    
//    [self.view.layer addAnimation:animation forKey:nil];
    
    self.view.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    [UIView animateWithDuration:0.25f delay:0 options:UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveLinear animations:^{
        
        self.view.frame = CGRectMake(0, self.frame.size.height / 2 - 10, self.frame.size.width, 20);
        
    } completion:nil];
    
    [self performSelector:@selector(endAnimation) withObject:nil afterDelay:5];
    
    !_FreshBlock?:_FreshBlock();
    if (_target) {
        
        [_target performSelector:_selector];
    }
}

- (void)endAnimation {
    
    [self.view.layer removeAllAnimations];
    self.view.frame = CGRectMake(0, self.frame.size.height / 2 - 10, 0, 20);
    
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - Setter & Getter

- (UIView *)view
{
    if(!_view)
    {
        _view = [UIView new];
    
        _view.frame = CGRectMake(0, 0, 0, 20);
        
        _view.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:1];
    }
    return _view;
}


- (UILabel *)lab
{
    if(!_lab)
    {
        _lab = [UILabel new];
        
        _lab.textColor = [UIColor redColor];
        
        _lab.textAlignment = NSTextAlignmentCenter;
    }
    return _lab;
}

- (UIScrollView *)scrollView {
    
    return (id)self.superview;
}

@end
