## 图片轮播器
### 图片轮播器，传入图片数组。显示图片轮播，默认页面指示器显示在右侧，可以进行更改,播放的延时时间可以进行设置，默认为 2 秒。欢迎大神提出建议。
```objc
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
```
![](https://github.com/Baleen-Y/PictureCarousel/blob/master/show.gif)





