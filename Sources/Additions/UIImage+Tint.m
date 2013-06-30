//
// UIImage+Tint.m
//
// Based on: https://github.com/mattgemmell/MGImageUtilities
//

#import "UIImage+Tint.h"


@implementation UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)color {
    return [self imageWithTintColor:color alpha:0.0f];
}

- (UIImage *)imageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha {
    CGRect rect = (CGRect) { CGPointZero, self.size };
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    [color set];
    UIRectFill(rect);
    
    [self drawInRect:rect blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    if (alpha > 0.0f) {
        [self drawInRect:rect blendMode:kCGBlendModeSourceAtop alpha:alpha];
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
}

@end
