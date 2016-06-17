# LHCarouseToolss
三张UIImageView实现无限轮播，可加载本地图片和网络图片，点击图片可触发回调
# 三方库
pod 'SDWebImage', '~> 3.8.1'
# 使用方法
初始化 轮播本地图片和网络图片
```
- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray<UIImage *> *)imagesArr timeInterval:(NSTimeInterval)timeInterval;
- (instancetype)initWithFrame:(CGRect)frame imagesUrlStringArray:(NSArray<NSString *> *)imagesUrlStringArr timeInterval:(NSTimeInterval)timeInterval;
```
点击图片触发代理回调
```
- (void)carouselTools:(LHCarouselTools *)carouselTools didSelectImageAtIndex:(NSInteger)index;
```
基本属性
```
@property (nonatomic, assign) BOOL showsVerticalScrollIndicator;    //default YES
@property (nonatomic, assign) BOOL showsHorizontalScrollIndicator;  //default YES
@property (nonatomic, assign) NSTimeInterval waitingTime;           //拖拽等待时间   defalut 2.0 sec min>0
@property (nonatomic, strong) UIImage *placeholder;                 //占位图片
@property (nonatomic, assign) id<LHCarouselToolsDelegate> delegate; //代理
```
