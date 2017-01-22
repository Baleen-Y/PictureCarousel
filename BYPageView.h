//
//  BYPageView.h
//  图片轮播
//
//  Created by Baleen.Y on 10/17/16.
//  Copyright © 2016 Baleen.Y. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 页面指示器的位置

 - BYPageViewIndicatorLeft: 居左
 - BYPageViewIndicatorCenter: 居中
 - BYPageViewIndicatorRight: 居右 默认值
 */
typedef NS_ENUM(NSInteger, BYPageViewIndicatorAlign) {
    BYPageViewIndicatorRight = 0,
    BYPageViewIndicatorCenter,
    BYPageViewIndicatorLeft
};

@interface BYPageView : UIView

/**
 图片模型数组
 */
@property (nonatomic, strong) NSArray<UIImage *> *pictures;

/**
 页面指示器位置
 */
@property (nonatomic, assign) BYPageViewIndicatorAlign indicatorAlign;

/**
 延时时间
 */
@property (nonatomic, assign) NSTimeInterval delayTimeInterval;

/**
 快速创建对象方法
 */
+ (instancetype)pageView;
+ (instancetype)pageViewWithPictures: (NSArray<UIImage *> *)pictures delay: (NSTimeInterval)delay indicatorAlign:(BYPageViewIndicatorAlign)indicatorAlign;


@end
