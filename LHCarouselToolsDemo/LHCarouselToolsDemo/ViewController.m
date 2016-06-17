//
//  ViewController.m
//  LHCarouseTools
//
//  Created by 刘虎 on 16/6/2.
//  Copyright © 2016年 liuhu. All rights reserved.
//

#import "ViewController.h"
#import "LHCarouselTools.h"


@interface ViewController ()<LHCarouselToolsDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *photosMArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 5; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg", i]];
        [photosMArr addObject:image];
    }
    
    LHCarouselTools *imageTest = [[LHCarouselTools alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200.f) imagesArray:photosMArr timeInterval:2.f];
    imageTest.waitingTime = 2.f;
    [self.view addSubview:imageTest];
    imageTest.delegate = self;
    
    
    
    NSArray *photosUrlArr = @[@"http://images.lanj.tv/abc.jpg", @"http://images.lanj.tv/abc1.jpg", @"http://images.lanj.tv/abc2.jpg"];
    LHCarouselTools *urlTest = [[LHCarouselTools alloc] initWithFrame:CGRectMake(0, 250.f, self.view.frame.size.width, 200.f) imagesUrlStringArray:photosUrlArr timeInterval:2.f];
    urlTest.waitingTime = 2.f;
    [self.view addSubview:urlTest];
    urlTest.delegate = self;
    
}

- (void)carouselTools:(LHCarouselTools *)carouselTools didSelectImageAtIndex:(NSInteger)index {
    
    NSLog(@"%@----%ld", carouselTools, index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
