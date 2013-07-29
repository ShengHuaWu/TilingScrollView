//
//  CIPhotoThumbnailView.h
//  TilingScrollView
//
//  Created by shenghua wu on 13/7/26.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CIPhotoThumbnailView : UIView
@property (nonatomic, strong, readonly) UIImageView *imageView;
/* ---
 This is the designated initializer.
 --- */
- (id)initWithFrame:(CGRect)frame photo:(UIImage *)photo focusRect:(CGRect)rect;
/* --- Public method --- */
- (void)moveFocusLayerWithContentOffset:(CGPoint)contentOffset andZoomScale:(CGFloat)zoomScale;
@end
