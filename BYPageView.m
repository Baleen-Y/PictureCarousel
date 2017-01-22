//
//  BYPageView.m
//  图片轮播
//
//  Created by Baleen.Y on 10/17/16.
//  Copyright © 2016 Baleen.Y. All rights reserved.
//

#import "BYPageView.h"

@interface BYPageView ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageController;

@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic, weak) NSTimer *timer;

@end

static const CGFloat pageIndicatorW = 20;
static const CGFloat pageIndicatorH = 15;
static const CGFloat pageIndicatorXRatioR = 0.9;
static const CGFloat pageIndicatorXRatioL = 0.1;
static const CGFloat pageIndicatorXRatioC = 0.5;
static const CGFloat pageIndicatorYRatio = 0.95;
static const NSTimeInterval duration = 1;

@implementation BYPageView

#pragma mark -  加载 BYPageView
+ (instancetype)pageView {
    BYPageView *pageV = [[BYPageView alloc] init];
    // 默认值
    pageV.indicatorAlign = BYPageViewIndicatorRight;
    pageV.delayTimeInterval = 2;
    [pageV setUI];
    return pageV;
}
+ (instancetype)pageViewWithPictures: (NSArray<UIImage *> *)pictures delay: (NSTimeInterval)delay indicatorAlign:(BYPageViewIndicatorAlign)indicatorAlign {
    BYPageView *pageView = [[BYPageView alloc] init];
    pageView.pictures = pictures;
    if (!delay) {
        pageView.delayTimeInterval = 2;
    }
    pageView.delayTimeInterval = delay;
    pageView.indicatorAlign = indicatorAlign;
    [pageView setUI];
    return pageView;
}

#pragma mark - 初始化操作
- (void)setUI {
    
    // 添加 scrollView
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    // 设置页面开启
    scrollView.pagingEnabled = YES;
    // 将指示器关闭
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    // 设置内边距为0
    scrollView.contentInset = UIEdgeInsetsZero;
    // 设置代理
    scrollView.delegate = self;
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 添加 pageController
    UIPageControl *pageController = [[UIPageControl alloc] init];
    pageController.pageIndicatorTintColor = [UIColor greenColor];
    pageController.currentPageIndicatorTintColor = [UIColor redColor];
    // 添加
    [self addSubview:pageController];
    self.pageController = pageController;
    
}

#pragma mark - 定时器相关
- (void)startTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.delayTimeInterval target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 下一页
- (void)nextPage {
    // 取出当前页
    int index = (int)self.pageController.currentPage;
    if (++index == self.pictures.count) {
        index = 0;
    }
    [UIView animateWithDuration:duration animations:^{
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width*index, 0) animated:NO];
    }];
    
}

#pragma mark - 代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 根据偏移量设置页码
    NSInteger index = (self.scrollView.contentOffset.x / self.frame.size.width)+0.5;
    // 设置页码
    self.pageController.currentPage = index;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startTimer];
}

/**设置contentSize*/
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.scrollView.frame = self.bounds;
    NSInteger count = (NSInteger)self.pictures.count;
    // 拿到当前view的尺寸
    CGFloat viewW = self.frame.size.width;
    CGFloat viewH = self.frame.size.height;
    // 添加图片
    for (int i = 0; i<count; i++) {
        // 创建图片
        UIImage *image = self.pictures[i];
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = image;
        // 添加图片
        [self.scrollView addSubview:imageView];
        // 设置图片位置
        CGFloat imageX = viewW * i;
        imageView.frame = CGRectMake(imageX, 0, viewW, viewH);
        
    }
    // 设置页数
    self.pageController.numberOfPages = count;
    // 设置页码指示器位置
    CGFloat pageW = count * pageIndicatorW;
    CGFloat pageH = pageIndicatorH;
    CGFloat pageY = (viewH - pageH) * pageIndicatorYRatio;
    CGFloat pageX;
    switch (self.indicatorAlign) {
        case BYPageViewIndicatorLeft:
            pageX = (viewW - pageW) * pageIndicatorXRatioL;
            break;
        case BYPageViewIndicatorCenter:
            pageX = (viewW - pageW) * pageIndicatorXRatioC;
            break;
        case BYPageViewIndicatorRight:
            pageX = (viewW - pageW) * pageIndicatorXRatioR;
            break;
    }
    self.pageController.frame = CGRectMake(pageX, pageY, pageW, pageH);
    // 设置contentSize
    self.scrollView.contentSize = CGSizeMake(count*viewW, viewH);
    // 开始定时
    if (self.timer == nil) {
        [self startTimer];
    }
    
}

@end
