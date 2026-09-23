//
//  ViewController.m
//  Lobah
//
//  Created by fanmeilong on 2026/9/20.
//

#import "ViewController.h"
#import "LoginManager.h"
#import "PaymentProcessor.h"
#import "CryptoUtils.h"
#import "DynamicEntry.h"

@interface ViewController ()

@property (nonatomic, strong) UITextView *demoTextView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor yellowColor];
    [self setupDemoTextView];
    [self runKeyPathDemo];
}

- (void)setupDemoTextView {
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.translatesAutoresizingMaskIntoConstraints = NO;
    textView.editable = NO;
    textView.font = [UIFont systemFontOfSize:14.0];
    textView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.85];
    [self.view addSubview:textView];
    self.demoTextView = textView;

    UILayoutGuide *safe = self.view.safeAreaLayoutGuide;
    [NSLayoutConstraint activateConstraints:@[
        [textView.leadingAnchor constraintEqualToAnchor:safe.leadingAnchor constant:16.0],
        [textView.trailingAnchor constraintEqualToAnchor:safe.trailingAnchor constant:-16.0],
        [textView.topAnchor constraintEqualToAnchor:safe.topAnchor constant:16.0],
        [textView.bottomAnchor constraintEqualToAnchor:safe.bottomAnchor constant:-16.0]
    ]];
}

/// 关键路径演示：登录 → 支付 → 签名 → 反射调用
- (void)runKeyPathDemo {
    NSMutableString *log = [NSMutableString string];

    [[LoginManager sharedManager] loginWithUsername:@"demo_user"
                                          password:@"demo_pass"
                                        completion:^(BOOL success, NSString *message) {
        // 主线程刷新即可，登录逻辑本身是同步的
    }];

    UserAccount *account = [LoginManager sharedManager].currentAccount;
    [log appendFormat:@"登录结果：%@\n\n", account ? [account accountSummary] : @"未登录"];

    [[PaymentProcessor sharedProcessor] payWithOrderId:@"ORDER-20260923"
                                              amount:9.90
                                          completion:^(BOOL success, NSString *transactionId) {
        // 支付结果为演示数据
    }];

    NSString *signature = [CryptoUtils signPayload:@"demo_payload" withSalt:@"demo_salt"];
    [log appendFormat:@"签名示例：%@\n\n", [signature substringToIndex:32]];

    NSString *reflectionResult = [[DynamicEntry new] invokeLoginViaReflectionWithUsername:@"ref_user"
                                                                                password:@"ref_pass"];
    [log appendFormat:@"反射调用：%@\n", reflectionResult];

    self.demoTextView.text = log;
}

@end
