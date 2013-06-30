//
// UIView+Hierarchy.m
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

#import "UIView+Hierarchy.h"


const UIViewAutoresizing GSViewAutoresizingStretch = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
const UIViewAutoresizing GSViewAutoresizingStretchAtTop = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
const UIViewAutoresizing GSViewAutoresizingStretchAtBottom = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
const UIViewAutoresizing GSViewAutoresizingStretchAtLeft = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
const UIViewAutoresizing GSViewAutoresizingStretchAtRight = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;

const UIViewAutoresizing GSViewAutoresizingStayHorizontally = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
const UIViewAutoresizing GSViewAutoresizingStayVertically = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
const UIViewAutoresizing GSViewAutoresizingStay = GSViewAutoresizingStayHorizontally | GSViewAutoresizingStayVertically;

const UIViewAutoresizing GSViewAutoresizingStayAtTopLeft = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
const UIViewAutoresizing GSViewAutoresizingStayAtTopRight = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin;
const UIViewAutoresizing GSViewAutoresizingStayAtBottomLeft = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin;
const UIViewAutoresizing GSViewAutoresizingStayAtBottomRight = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin;

const UIViewAutoresizing GSViewAutoresizingStayAtTop = UIViewAutoresizingFlexibleBottomMargin | GSViewAutoresizingStayHorizontally;
const UIViewAutoresizing GSViewAutoresizingStayAtBottom = UIViewAutoresizingFlexibleTopMargin | GSViewAutoresizingStayHorizontally;
const UIViewAutoresizing GSViewAutoresizingStayAtLeft = UIViewAutoresizingFlexibleRightMargin | GSViewAutoresizingStayVertically;
const UIViewAutoresizing GSViewAutoresizingStayAtRight = UIViewAutoresizingFlexibleLeftMargin | GSViewAutoresizingStayVertically;


@implementation UIView (Hierarchy)

- (NSString *)hierarchyDescription {
    // This is performed using a private UIView method, so when we're building
    // the library for release we fallback to a regular description call
#ifdef DEBUG
    SEL selector = NSSelectorFromString(@"recursiveDescription");
    if ([self respondsToSelector:selector]) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [self performSelector:selector];
        #pragma clang diagnostic pop
    }
#endif
    return [self description];
}

- (UIView *)findFirstResponder {
    if (self.isFirstResponder) {
        return self;
    }
    
    for (UIView *subview in self.subviews) {
        UIView *responder = [subview findFirstResponder];
        if (responder) {
            return responder;
        }
    }
    
    return nil;
}

@end
