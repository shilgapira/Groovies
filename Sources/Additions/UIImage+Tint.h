//
// UIImage+Tint.h
//
// Based on: https://github.com/mattgemmell/MGImageUtilities
//

#import <UIKit/UIKit.h>


@interface UIImage (Tint)

- (UIImage *)imageWithTintColor:(UIColor *)color;

- (UIImage *)imageWithTintColor:(UIColor *)color alpha:(CGFloat)alpha;

@end
