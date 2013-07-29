//
//  TSVViewController.m
//  TilingScrollView
//
//  Created by shenghua wu on 13/7/5.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "TSVViewController.h"
#import "TSVTilingView.h"
#import "CIPhotoThumbnailView.h"
#import "UIScrollView+CIHelper.h"

#define ThumbnailViewWidth 200.0f
#define ThumbnailViewHeight 150.0f

#define ScaleFormat @"scale %f"

@interface TSVViewController () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) TSVTilingView *tilingView;
@property (nonatomic, strong) CIPhotoThumbnailView *thumbnailView;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *scaleLabel;
@end

@implementation TSVViewController

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
        _scrollView.delegate = self;
        
        _scrollView.contentSize = CGSizeMake(1024, 768);
        _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _scrollView.minimumZoomScale = 1.0;
        _scrollView.maximumZoomScale = 4.0;
    }
    return _scrollView;
}

- (TSVTilingView *)tilingView
{
    if (!_tilingView) {
        _tilingView = [[TSVTilingView alloc] initWithFrame:self.scrollView.bounds];
        _tilingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _tilingView;
}

- (CIPhotoThumbnailView *)thumbnailView
{
    if (!_thumbnailView) {
        CGRect frame = CGRectMake(0, 0, ThumbnailViewWidth, ThumbnailViewHeight);
        _thumbnailView = [[CIPhotoThumbnailView alloc] initWithFrame:frame photo:[UIImage imageNamed:@"earth.png"] focusRect:frame];
    }
    return _thumbnailView;
}

- (UISlider *)slider
{
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:CGRectMake(0, 0, ThumbnailViewHeight, 20.0f)];
        _slider.minimumValue = 1.0f;
        _slider.maximumValue = 4.0f;
        [_slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

- (UILabel *)scaleLabel
{
    if (!_scaleLabel) {
        _scaleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return _scaleLabel;
}

#pragma mark - View life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.tilingView];
        
    [self.view addSubview:self.thumbnailView];
    [self.view addSubview:self.slider];
    [self.view addSubview:self.scaleLabel];
}

- (void)viewDidLayoutSubviews
{
    self.thumbnailView.frame = CGRectMake(20.0f, self.view.bounds.size.height - 20.0f - ThumbnailViewHeight, ThumbnailViewWidth, ThumbnailViewHeight);
    self.slider.frame = CGRectMake(CGRectGetMaxX(self.thumbnailView.frame) - 30.0f, CGRectGetMidY(self.thumbnailView.frame) - 10.0f, ThumbnailViewHeight, 20.0f); // Set position properly
    self.slider.transform = CGAffineTransformRotate(self.slider.transform, -M_PI_2); // Turn vertical
    self.scaleLabel.text = [NSString stringWithFormat:ScaleFormat, 1.0f];
    [self.scaleLabel sizeToFit];
}

#pragma mark - Button action
- (void)valueChanged:(UISlider *)sender
{
    self.scrollView.zoomScale = sender.value;
    self.scaleLabel.text = [NSString stringWithFormat:ScaleFormat, sender.value];
    [self.scaleLabel sizeToFit];
    CGPoint contentOffset = [self.scrollView scaleContentOffsetWithThumbnailSize:CGSizeMake(ThumbnailViewWidth, ThumbnailViewHeight)];
    [self.thumbnailView moveFocusLayerWithContentOffset:contentOffset andZoomScale:sender.value];
}

#pragma mark - Scroll view delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint contentOffset = [scrollView scaleContentOffsetWithThumbnailSize:CGSizeMake(ThumbnailViewWidth, ThumbnailViewHeight)];
    [self.thumbnailView moveFocusLayerWithContentOffset:contentOffset andZoomScale:scrollView.zoomScale];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        CGPoint contentOffset = [scrollView scaleContentOffsetWithThumbnailSize:CGSizeMake(ThumbnailViewWidth, ThumbnailViewHeight)];
        [self.thumbnailView moveFocusLayerWithContentOffset:contentOffset andZoomScale:scrollView.zoomScale];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.tilingView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    self.slider.value = scale;
    self.scaleLabel.text = [NSString stringWithFormat:ScaleFormat, scale];
    [self.scaleLabel sizeToFit];
    CGPoint contentOffset = [scrollView scaleContentOffsetWithThumbnailSize:CGSizeMake(ThumbnailViewWidth, ThumbnailViewHeight)];
    [self.thumbnailView moveFocusLayerWithContentOffset:contentOffset andZoomScale:scrollView.zoomScale];
}

@end
