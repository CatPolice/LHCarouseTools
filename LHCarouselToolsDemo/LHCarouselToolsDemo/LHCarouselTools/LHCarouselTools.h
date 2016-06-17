//
//  LHCarouselTools.h
//  LHCarouselDemo
//
//  Created by 刘虎 on 16/6/1.
//  Copyright © 2016年 liuhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LHCarouselTools;

@protocol LHCarouselToolsDelegate <NSObject>

@optional
- (void)carouselTools:(LHCarouselTools *)carouselTools didSelectImageAtIndex:(NSInteger)index;

@end

@interface LHCarouselTools : UIView

@property (nonatomic, assign) BOOL showsVerticalScrollIndicator;    //default YES
@property (nonatomic, assign) BOOL showsHorizontalScrollIndicator;  //default YES
@property (nonatomic, assign) NSTimeInterval waitingTime;           //拖拽等待时间   defalut 2.0 sec min>0
@property (nonatomic, strong) UIImage *placeholder;                 //占位图片

@property (nonatomic, assign) id<LHCarouselToolsDelegate> delegate; //代理

- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray<UIImage *> *)imagesArr timeInterval:(NSTimeInterval)timeInterval;
- (instancetype)initWithFrame:(CGRect)frame imagesUrlStringArray:(NSArray<NSString *> *)imagesUrlStringArr timeInterval:(NSTimeInterval)timeInterval;


@end
