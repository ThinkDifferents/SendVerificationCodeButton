//
//  ViewController.m
//  RACLogin
//
//  Created by shiwei on 17/6/16.
//  Copyright © 2017年 shiwei. All rights reserved.
//

#import "ViewController.h"
#import "ReactiveObjC.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITextView *contentFiled;

@property (nonatomic, assign) int time;
@property (nonatomic, strong) RACDisposable *disposable;


@end

@implementation ViewController

// 按钮点击了之后, 会进行倒数计时
// 倒数计时过程中, 按钮不可以点击
// 倒数计时结束之后,按钮恢复点击, 并且修改文字
- (IBAction)sendClick:(id)sender {
    
    self.sendBtn.enabled = false;
    self.time = 10;
    
    // 通过1.0秒时间, 将按钮放入主线程 (RAC 中的 GCD)
    self.disposable = [[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        
        _time--;
        
        // 设置按钮的文字
        NSString *titleString = _time > 0 ? [NSString stringWithFormat:@"请等待%d秒", _time] : @"请重新发送";
        
        [self.sendBtn setTitle:titleString forState:_time > 0 ? UIControlStateDisabled : UIControlStateNormal];
        
        if (_time > 0) {
            self.sendBtn.enabled = false;
        } else {
            self.sendBtn.enabled = true;
            [_disposable dispose];
        }
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
