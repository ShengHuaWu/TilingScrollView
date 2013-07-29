//
//  UIScrollView+CIHelper.m
//  TilingScrollView
//
//  Created by shenghua wu on 13/7/26.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "UIScrollView+CIHelper.h"

@implementation UIScrollView (CIHelper)

- (CGPoint)scaleContentOffsetWithThumbnailSize:(CGSize)thumbnailSize
{
    CGPoint ratio = CGPointMake(self.bounds.size.width * self.zoomScale / thumbnailSize.width, self.bounds.size.height * self.zoomScale / thumbnailSize.height);
    return CGPointMake(self.contentOffset.x / ratio.x, self.contentOffset.y / ratio.y);
}

@end
