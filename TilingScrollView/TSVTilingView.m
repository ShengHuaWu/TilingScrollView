//
//  TSVTilingView.m
//  TilingScrollView
//
//  Created by shenghua wu on 13/7/5.
//  Copyright (c) 2013年 shenghua wu. All rights reserved.
//

#import "TSVTilingView.h"
#import <QuartzCore/QuartzCore.h>

#define DefaultTileSizeWidth 512
#define DefaultTileSizeHeight 512

@implementation TSVTilingView

+ (Class)layerClass
{
    return [CATiledLayer class];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {        
        CATiledLayer *tiledLayer = (CATiledLayer *)self.layer;
        tiledLayer.tileSize = CGSizeMake(DefaultTileSizeWidth, DefaultTileSizeHeight);
        tiledLayer.levelsOfDetail = 3;
        tiledLayer.levelsOfDetailBias = 2;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGFloat scale = CGContextGetCTM(UIGraphicsGetCurrentContext()).a / [[UIScreen mainScreen] scale];
    CGSize tileSize = ((CATiledLayer *)self.layer).tileSize;
    tileSize.width /= scale;
    tileSize.height /= scale;
    NSInteger row = CGRectGetMinX(rect) / tileSize.width;
    NSInteger col = CGRectGetMinY(rect) / tileSize.height;
//    DLog(@"row: %d\ncol: %d", row, col);
    
    UIImage *tileImage = [self imageForTileWithScale:scale col:col andRow:row]; // Get the image.
    if (tileImage) {
        CGRect tileRect = CGRectMake(tileSize.width * row, tileSize.height * col, tileSize.width, tileSize.height);
        tileRect = CGRectIntersection(self.bounds, tileRect);
//        DLog(@"Drawing image at %@", NSStringFromCGRect(tileRect));
        [tileImage drawInRect:tileRect];
    }
}

- (UIImage *)imageForTileWithScale:(CGFloat)scale col:(NSInteger)col andRow:(NSInteger)row
{
    NSString *fileName = [NSString stringWithFormat:@"earth3_%dx_%d_%d.png", (NSInteger)scale, col, row];
    // TODO: If image does not exist, try to download.
    return [UIImage imageNamed:fileName];
}

@end
