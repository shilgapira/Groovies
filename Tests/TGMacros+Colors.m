//
// TGMacros+Colors.m
//
// Copyright (c) 2013 Gil Shapira
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

#import "TGMacros+Colors.h"
#import "GSMacros+Colors.h"


@implementation TGMacros_Colors

- (void)testColor0 {
    UIColor *clear = GSColor();
    TGAssertEqualObjects(clear, UIColor.clearColor);
}

- (void)testColor1 {
    UIColor *white = GSColor(0xff);
    TGAssertEqualObjects(white, UIColor.whiteColor);
    
    white = GSColor(1.0);
    TGAssertEqualObjects(white, UIColor.whiteColor);
    
    white = GSColor(1);
    TGAssertEqualObjects(white, UIColor.whiteColor);
    
    UIColor *notwhite = GSColor(0x01);
    TGAssertNot([notwhite isEqual:UIColor.whiteColor]);
    
    UIColor *black = GSColor(0x00);
    TGAssertEqualObjects(black, UIColor.blackColor);
    
    black = GSColor(0);
    TGAssertEqualObjects(black, UIColor.blackColor);
    
    UIColor *gray = GSColor(0.5f);
    TGAssertEqualObjects(gray, UIColor.grayColor);
    
    UIColor *red = GSColor(0xff0000);
    TGAssertEqualObjects(red, UIColor.redColor);
    
    UIColor *green = GSColor(0x00ff00);
    TGAssertEqualObjects(green, UIColor.greenColor);
    
    UIColor *blue = GSColor(0x0000ff);
    TGAssertEqualObjects(blue, UIColor.blueColor);
    
    TGAssertNot([blue isEqual:red]);
    TGAssertNot([green isEqual:red]);
    TGAssertNot([red isEqual:blue]);
}

- (void)testColor2 {
    UIColor *clear1 = GSColor(0x00, 0);
    TGAssertEqualObjects(clear1, UIColor.clearColor);
    
    UIColor *white = GSColor(1.0f, 1.0);
    TGAssertEqualObjects(white, UIColor.whiteColor);
    
    UIColor *clear2 = GSColor(0.0, 0);
    TGAssertEqualObjects(clear2, UIColor.clearColor);
    
    UIColor *clear3 = GSColor(0.0f, 0);
    TGAssertEqualObjects(clear3, UIColor.clearColor);
    
    UIColor *black = GSColor(0, 1);
    TGAssertEqualObjects(black, UIColor.blackColor);
    
    white = GSColor(255, 1);
    TGAssertEqualObjects(white, UIColor.whiteColor);
}

- (void)testColor3f {
    UIColor *white = GSColor(1.0, 1.0, 1.0);
    TGAssertEqualObjects(white, [UIColor colorWithRed:1.0 green:1.0 blue:1.0f alpha:1.0f]);
    
    UIColor *black = GSColor(0, 0, 0);
    TGAssertEqualObjects(black, [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f]);
    
    UIColor *red = GSColor(255, 0, 0);
    TGAssertEqualObjects(red, UIColor.redColor);
    
    UIColor *green = GSColor(0, 0xff, 0);
    TGAssertEqualObjects(green, UIColor.greenColor);
    
    UIColor *blue = GSColor(0, 0, 1.0f);
    TGAssertEqualObjects(blue, UIColor.blueColor);
    
    UIColor *purple = GSColor(0.5f, 0, 0.5f);
    TGAssertEqualObjects(purple, UIColor.purpleColor);
    
    UIColor *orange = GSColor(1.0f, 0.5f, 0);
    TGAssertEqualObjects(orange, UIColor.orangeColor);
    
    TGAssertNot([blue isEqual:red]);
    TGAssertNot([green isEqual:red]);
    TGAssertNot([red isEqual:blue]);
}

- (void)testColor4 {
    UIColor *clear = GSColor(0, 0, 0, 0);
    TGAssertEqualObjects(clear, [UIColor colorWithRed:0 green:0 blue:0 alpha:0]);
    
    UIColor *purple = GSColor(0.5f, 0, 0.5f, 0.5f);
    TGAssertEqualObjects(purple, [[UIColor purpleColor] colorWithAlphaComponent:0.5f]);
    
    UIColor *black = GSColor(0, 0, 0, 1);
    TGAssertEqualObjects(black, [UIColor colorWithRed:0 green:0 blue:0 alpha:1.0f]);
}

@end
