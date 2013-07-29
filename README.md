# Tiling Scroll View
This project shows a tiled view (CATiledLayer) with a UIScrollView and a thumbnail view with a focus layer.

# Usage
0.0.1 version (2013/7/29)

## TSVTilingView

### Creation
> Use the normal designated initializer.

		- (id)initWithFrame:(CGRect)frame;

* Must set the properties of CATiledLayer, _levelsOfDetail_ and _levelsOfDetailBias_ properly.

## CIPhotoThumbnailView
Always combine with a UIScrollView.

### Creation
> This method is the designated initializer.

		- (id)initWithFrame:(CGRect)frame photo:(UIImage *)photo focusRect:(CGRect)rect;

### Public method

		- (void)moveFocusLayerWithContentOffset:(CGPoint)contentOffset andZoomScale:(CGFloat)zoomScale;
