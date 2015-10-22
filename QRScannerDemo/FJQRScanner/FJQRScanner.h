// Copyright (c) 2013 FJBannerView
// Author fengjun
// Blog:http://devfeng.com/
// Url :https://github.com/fengarenas/FJQRScanner
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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FJQRScanner;

@protocol FJQRScannerDelegate <NSObject>
- (void)FJQRScanner:(FJQRScanner *)scanner didCapture:(NSString *)result;
@end

typedef void (^captured)(NSString *result);

@interface FJQRScanner : UIView

/**
 *  遍历构造一个扫描的view
 */
+ (instancetype)scannerWithFrame:(CGRect)frame;
+ (instancetype)scannerWithFrame:(CGRect)frame delegate:(id<FJQRScannerDelegate>)delegate;

/**
 *  开始扫描
 */
- (void)start;

/**
 *  停止扫描
 */
- (void)stop;

/**
 *  设置扫描二维码成功后的回调
 */
- (void)setCaptured:(captured)captured;

/**
 *  代理
 */
@property (nonatomic, weak) id<FJQRScannerDelegate>delegate;


/**
 *  打开关闭手电筒
 */
+ (void)openTorch:(BOOL)open;

@end
