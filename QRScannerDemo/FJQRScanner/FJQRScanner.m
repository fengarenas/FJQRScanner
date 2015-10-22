//
//  FJQRScanner.m
//  QRScannerDemo
//
//  Created by Fengj on 15/10/22.
//  Copyright © 2015年 FengJun. All rights reserved.
//

#import "FJQRScanner.h"
#import <AVFoundation/AVFoundation.h>
#import <objc/runtime.h>

static char * const FJCapturedCallbackKey = "capturedCallbackKey";

@interface FJQRScanner () <AVCaptureMetadataOutputObjectsDelegate> {
    struct {
        unsigned int didCapture :1;
    }_delegteFlags;
}
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *avCapturePreviewLayer;


@end


@implementation FJQRScanner

#pragma mark - lifeCycle

+ (instancetype)scannerWithFrame:(CGRect)frame {
    return [self scannerWithFrame:frame delegate:nil];
}

+ (instancetype)scannerWithFrame:(CGRect)frame delegate:(id<FJQRScannerDelegate>)delegate {
    return [[[self class] alloc]initWithFrame:frame delegate:delegate];
}

- (instancetype)initWithFrame:(CGRect)frame delegate:(id<FJQRScannerDelegate>)delegate {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDelegate:delegate];
        [self setup];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup {
    // Capture session init
    _session = AVCaptureSession.new;
    
    AVCaptureDevice *backCameraDevice;
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *device in devices) {
        if (device.position == AVCaptureDevicePositionBack) {
            backCameraDevice = device;
            break;
        }
    }
    //input
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:backCameraDevice error:nil];
    [_session addInput:input];
    
    //output
    AVCaptureMetadataOutput *output = AVCaptureMetadataOutput.new;
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [_session addOutput:output];
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];

    _avCapturePreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _avCapturePreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer insertSublayer:_avCapturePreviewLayer atIndex:0];
    [self.layer addSublayer:_avCapturePreviewLayer];
}

-(void)layoutSubviews {
    _avCapturePreviewLayer.frame = self.bounds;
}

#pragma mark - response methons

- (void)start {
    if ([_session isRunning]) return;
    [_session startRunning];
}

- (void)stop {
    if ([_session isRunning]) {
        [_session stopRunning];
    }
}

-(void)setCaptured:(captured)captured {
    if (captured) {
        objc_setAssociatedObject(self, FJCapturedCallbackKey, captured, OBJC_ASSOCIATION_COPY);
    }
}

#pragma mark - utils

- (BOOL)cameraIsEnable {
    if([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        //判断相机是否能够使用
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusAuthorized:
            case AVAuthorizationStatusNotDetermined:
                return YES;
                break;
            default:
                return NO;
                break;
        }
    }
    return YES;
}

+ (void)openTorch:(BOOL)open {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (!device.hasTorch) return;
    if (!device.torchAvailable) return;

    [device lockForConfiguration:nil];
    if (open && [device isTorchModeSupported:AVCaptureTorchModeOn]) {
        [device setTorchMode:AVCaptureTorchModeOn];
    }
    if (!open && [device isTorchModeSupported:AVCaptureTorchModeOff]) {
        [device setTorchMode:AVCaptureTorchModeOff];
    }
    [device unlockForConfiguration];
}

#pragma mark - <AVCaptureMetadataOutputObjectsDelegate>

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    for (AVMetadataObject *metadata in metadataObjects) {
        if ([metadata.type isEqualToString:AVMetadataObjectTypeQRCode]) {
            NSString *qrcode = [(AVMetadataMachineReadableCodeObject *)metadata stringValue];
            
            if (_delegteFlags.didCapture) {
                [_delegate FJQRScanner:self didCapture:qrcode];
            }
            captured capturedCallback = objc_getAssociatedObject(self, FJCapturedCallbackKey);
            if (capturedCallback) capturedCallback(qrcode);
            [self stop];
            break;
        }
    }
}

#pragma mark - setter and getter

-(void)setDelegate:(id<FJQRScannerDelegate>)delegate {
    if (_delegate !=delegate) {
        _delegate = delegate;
        _delegteFlags.didCapture = [_delegate respondsToSelector:@selector(FJQRScanner:didCapture:)];
    }
}

@end
