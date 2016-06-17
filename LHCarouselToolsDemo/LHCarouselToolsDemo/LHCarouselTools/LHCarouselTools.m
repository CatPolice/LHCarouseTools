//
//  LHCarouselTools.m
//  LHCarouselDemo
//
//  Created by 刘虎 on 16/6/1.
//  Copyright © 2016年 liuhu. All rights reserved.
//

#import "LHCarouselTools.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LHCarouselTools ()<UIScrollViewDelegate>

@property (nonatomic, assign) BOOL isUrlImagesArr;
@property (nonatomic, strong) NSMutableArray *dataSourceMArr;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger currentImageIndex;

@end

@implementation LHCarouselTools


#pragma mark - -----初始化-----
- (instancetype)initWithFrame:(CGRect)frame imagesArray:(NSArray<UIImage *> *)imagesArr timeInterval:(NSTimeInterval)timeInterval {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        if (imagesArr.count == 0 || !imagesArr) {
            
            return nil;
        }
        self.isUrlImagesArr = NO;
        self.dataSourceMArr = [imagesArr mutableCopy];
        self.currentImageIndex = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(carousel) userInfo:nil repeats:YES];
        [self addSubview:self.scrollView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame imagesUrlStringArray:(NSArray<NSString *> *)imagesUrlStringArr timeInterval:(NSTimeInterval)timeInterval {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        if (imagesUrlStringArr.count == 0 || !imagesUrlStringArr) {
            
            return nil;
        }
        self.isUrlImagesArr = YES;
        self.dataSourceMArr = [NSMutableArray array];
        for (NSString *urlStr in imagesUrlStringArr) {
            
            [self.dataSourceMArr addObject:[NSURL URLWithString:urlStr]];
        }
        self.currentImageIndex = 0;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(carousel) userInfo:nil repeats:YES];
        [self addSubview:self.scrollView];
    }
    return self;
}



#pragma mark - -----定时器回调-----
- (void)carousel {
    
    [self.scrollView setContentOffset:CGPointMake(self.frame.size.width*2, 0) animated:YES];
}

#pragma mark - -----scrollView delegate-----
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.scrollView.contentOffset.x == self.frame.size.width * 2) {
        
        self.currentImageIndex++;
        self.leftImageView.image = self.middleImageView.image;
        self.middleImageView.image = self.rightImageView.image;
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        NSInteger rightImageIndex = 0;
        if (self.currentImageIndex == self.dataSourceMArr.count-1) {
            
            rightImageIndex = 0;
        } else if (self.currentImageIndex == self.dataSourceMArr.count) {
            
            self.currentImageIndex = 0;
            rightImageIndex = self.dataSourceMArr.count>1?1:0;
        } else {
            
            rightImageIndex = self.currentImageIndex+1;
        }
        if (self.isUrlImagesArr) {
            
            [self.rightImageView sd_setImageWithURL:self.dataSourceMArr[rightImageIndex] placeholderImage:self.placeholder];
        } else {
            
            self.rightImageView.image = self.dataSourceMArr[rightImageIndex];
        }
        
    }
    if (self.scrollView.contentOffset.x == 0) {
        
        self.currentImageIndex--;
        self.rightImageView.image = self.middleImageView.image;
        self.middleImageView.image = self.leftImageView.image;
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        NSInteger leftImageIndex = 0;
        if (self.currentImageIndex == 0) {
            
            leftImageIndex = self.dataSourceMArr.count-1;
        } else if (self.currentImageIndex < 0) {
            
            self.currentImageIndex = self.dataSourceMArr.count-1;
            leftImageIndex = self.dataSourceMArr.count > 1 ? (self.currentImageIndex - 1) : 0;
        } else {
            
            leftImageIndex = self.currentImageIndex - 1;
        }
        if (self.isUrlImagesArr) {
            
            [self.leftImageView sd_setImageWithURL:self.dataSourceMArr[leftImageIndex] placeholderImage:self.placeholder];
        } else {
            
            self.leftImageView.image = self.dataSourceMArr[leftImageIndex];
        }
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self.timer setFireDate:[NSDate distantFuture]];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:self.waitingTime>0?self.waitingTime:2.0]];
}
#pragma mark - -----点击图片回调-----
- (void)didSelectImage {
    
    if ([self.delegate respondsToSelector:@selector(carouselTools:didSelectImageAtIndex:)]) {
        
        [self.delegate carouselTools:self didSelectImageAtIndex:self.currentImageIndex];
    }
}

#pragma mark - -----属性懒加载-----
- (UIImageView *)leftImageView {
    
    if (!_leftImageView) {
        
        _leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    
    if (!_middleImageView) {
        
        _middleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
        _middleImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectImage)];
        [_middleImageView addGestureRecognizer:tapGesture];
    }
    return _middleImageView;
}

- (UIImageView *)rightImageView {
    
    if (!_rightImageView) {
        
        _rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width*2.0, 0, self.frame.size.width, self.frame.size.height)];
    }
    return _rightImageView;
}


- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.contentSize = CGSizeMake(self.frame.size.width * 3, self.frame.size.height);
        _scrollView.contentOffset = CGPointMake(self.frame.size.width, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = self.showsVerticalScrollIndicator;
        _scrollView.showsHorizontalScrollIndicator = self.showsHorizontalScrollIndicator;
        _scrollView.bounces = NO;
        if (self.isUrlImagesArr) {
            
            [self.leftImageView sd_setImageWithURL:[self.dataSourceMArr lastObject] placeholderImage:self.placeholder];
            [self.middleImageView sd_setImageWithURL:[self.dataSourceMArr firstObject] placeholderImage:self.placeholder];
            [self.rightImageView sd_setImageWithURL:[self.dataSourceMArr objectAtIndex:self.dataSourceMArr.count>1?1:0] placeholderImage:self.placeholder];
        } else {
            
            self.leftImageView.image = [self.dataSourceMArr lastObject];
            self.middleImageView.image = [self.dataSourceMArr firstObject];
            self.rightImageView.image = [self.dataSourceMArr objectAtIndex:self.dataSourceMArr.count>1?1:0];
        }
        [_scrollView addSubview:self.leftImageView];
        [_scrollView addSubview:self.middleImageView];
        [_scrollView addSubview:self.rightImageView];
    }
    return _scrollView;
}



@end
