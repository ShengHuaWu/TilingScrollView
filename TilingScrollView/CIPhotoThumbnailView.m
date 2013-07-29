//
//  CIPhotoThumbnailView.m
//  TilingScrollView
//
//  Created by shenghua wu on 13/7/26.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "CIPhotoThumbnailView.h"
#import <QuartzCore/QuartzCore.h>

@interface CIPhotoThumbnailView ()
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@property (nonatomic, strong) CAShapeLayer *focusLayer;
@end

@implementation CIPhotoThumbnailView

#pragma mark - Designated initializer
- (id)initWithFrame:(CGRect)frame photo:(UIImage *)photo focusRect:(CGRect)rect
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.image = photo;
        [self addSubview:_imageView];
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:frame];
        CAShapeLayer *marginLayer = [CAShapeLayer layer];
        marginLayer.path = path.CGPath;
        marginLayer.strokeColor = [UIColor whiteColor].CGColor;
        marginLayer.fillColor = [UIColor clearColor].CGColor;
        [self.layer addSublayer:marginLayer];
        
        path = [UIBezierPath bezierPathWithRect:rect];
        _focusLayer = [CAShapeLayer layer];
        _focusLayer.path = path.CGPath;
        _focusLayer.fillColor = [UIColor colorWithRed:1.0f green:0 blue:0 alpha:0.3f].CGColor;
        _focusLayer.strokeColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:_focusLayer];
    }
    return self;
}

#pragma mark - Public method
- (void)moveFocusLayerWithContentOffset:(CGPoint)contentOffset andZoomScale:(CGFloat)zoomScale
{
    CGRect rect = self.bounds;
    // Scale the rect
    CGSize zoomSize = CGSizeMake(rect.size.width / zoomScale, rect.size.height / zoomScale);
    rect = CGRectInset(rect, (rect.size.width - zoomSize.width) / 2.0f, (rect.size.height - zoomSize.height) / 2.0f);
    // move the rect
    rect.origin.x = contentOffset.x;
    rect.origin.y = contentOffset.y;
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:rect];
    self.focusLayer.path = path.CGPath;
}

@end
