//
// Copyright (c) 2013 QRScanner (http://devfeng.com/)
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
