//
// UIImage+Crop.m
//
// Copyright (c) 2012 Gil Shapira
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "UIImage+Crop.h"


@implementation UIImage (Crop)

// Based on: http://stackoverflow.com/a/7704399
- (UIImage *)imageByCroppingToRect:(CGRect)rect {
	CGFloat scale = self.scale;
	rect = CGRectMake(rect.origin.x * scale, rect.origin.y * scale, rect.size.width * scale, rect.size.height * scale);
	
	CGImageRef cgresult = CGImageCreateWithImageInRect(self.CGImage, rect);
    if (!cgresult) {
        return nil;
    }

	UIImage *result = [UIImage imageWithCGImage:cgresult scale:scale orientation:self.imageOrientation];
	CGImageRelease(cgresult);
    
	return result;
}

- (UIImage *)imageByCroppingToSquare {
	CGSize size = self.size;
    
	CGFloat edge = fminf(size.width, size.height);
    CGFloat x = roundf((size.width - edge) / 2.0f);
    CGFloat y = roundf((size.height - edge) / 2.0f);
    
    CGRect rect = CGRectMake(x, y, edge, edge);
    
	return [self imageByCroppingToRect:rect];
}

@end
