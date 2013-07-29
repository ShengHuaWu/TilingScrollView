//
//  UIScrollView+CIHelper.h
//  TilingScrollView
//
//  Created by shenghua wu on 13/7/26.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (CIHelper)
/* ---
 This method is used to scale the content offset by the given thumbnail size.
 --- */
- (CGPoint)scaleContentOffsetWithThumbnailSize:(CGSize)thumbnailSize;
@end
