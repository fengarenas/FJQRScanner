# FJQRScanner
iOS7 自带的二维码扫描功能进行了封装


## Install

```
import "FJQRScanner.h"
```

## Usage

```

    FJQRScanner *scannerView = [FJQRScanner scannerWithFrame:self.view.bounds delegate:self];

    [scannerView setCaptured:^(NSString *result) {
        NSLog(@"block Capture : %@",result);
    }];
    
    [scannerView setFrame:CGRectMake(0, 0, 280, 280)];
    
    scannerView.center = CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0);
    
    [self.view addSubview:scannerView];

    [scannerView start];

```

## Author
**FengJun** e-mail:<fengarenas@126.com> Blog:[DevFeng](http://devfeng.com/)
