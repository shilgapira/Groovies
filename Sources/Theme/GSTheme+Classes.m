//
// GSTheme+Classes.m
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

#import "GSTheme+Classes.h"


@implementation GSTheme (Classes)

- (void)addViewStyle:(id<NSCopying>)style block:(void(^)(UIView *o))block {
    [self addStyle:style forClass:UIView.class block:block];
}

- (void)addLabelStyle:(id<NSCopying>)style block:(void(^)(UILabel *o))block {
    [self addStyle:style forClass:UILabel.class block:block];
}

- (void)addButtonStyle:(id<NSCopying>)style block:(void(^)(UIButton *o))block {
    [self addStyle:style forClass:UIButton.class block:block];
}

- (void)addTextFieldStyle:(id<NSCopying>)style block:(void(^)(UITextField *o))block {
    [self addStyle:style forClass:UITextField.class block:block];
}

- (void)addImageViewStyle:(id<NSCopying>)style block:(void(^)(UIImageView *o))block {
    [self addStyle:style forClass:UIImageView.class block:block];
}

- (void)addTableStyle:(id<NSCopying>)style block:(void(^)(UITableView *o))block {
    [self addStyle:style forClass:UITableView.class block:block];
}

- (void)addCellStyle:(id<NSCopying>)style block:(void(^)(UITableViewCell *o))block {
    [self addStyle:style forClass:UITableViewCell.class block:block];
}

@end
