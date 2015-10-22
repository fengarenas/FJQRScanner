//
//  FJQRScanner.h
//  QRScannerDemo
//
//  Created by Fengj on 15/10/22.
//  Copyright © 2015年 FengJun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FJQRScanner;
@protocol FJQRScannerDelegate <NSObject>
- (void)FJQRScanner:(FJQRScanner *)scanner didCapture:(NSString *)result;
@end

typedef void (^captured)(NSString *result);

@interface FJQRScanner : UIView

+ (instancetype)scannerWithFrame:(CGRect)frame;
+ (instancetype)scannerWithFrame:(CGRect)frame delegate:(id<FJQRScannerDelegate>)delegate;
- (void)start;
- (void)stop;
- (void)setCaptured:(captured)captured;
@property (nonatomic, weak) id<FJQRScannerDelegate>delegate;

+ (void)openTorch:(BOOL)open;

@end
