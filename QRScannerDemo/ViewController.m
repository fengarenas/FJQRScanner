//
//  ViewController.m
//  QRScannerDemo
//
//  Created by Fengj on 15/10/22.
//  Copyright © 2015年 FengJun. All rights reserved.
//

#import "ViewController.h"
#import "FJQRScanner.h"

@interface ViewController () <FJQRScannerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *closeTorch;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    FJQRScanner *scannerView = [FJQRScanner scannerWithFrame:self.view.bounds delegate:self];

    [scannerView setCaptured:^(NSString *result) {
        NSLog(@"block Capture : %@",result);
    }];
    
    [scannerView setFrame:CGRectMake(0, 0, 280, 280)];
    
    scannerView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    
    [self.view addSubview:scannerView];

    [scannerView start];
}

- (IBAction)open:(id)sender {
    [FJQRScanner openTorch:YES];
}
- (IBAction)close:(id)sender {
    [FJQRScanner openTorch:NO];
}


- (void)FJQRScanner:(FJQRScanner *)scanner didCapture:(NSString *)result {
    NSLog(@"delegate Capture : %@",result);
    [FJQRScanner openTorch:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
