//
//  DynamicEntry.m
//  Lobah
//

#import "DynamicEntry.h"
#import "LoginManager.h"
#import <objc/message.h>

@implementation DynamicEntry

- (NSString *)invokeLoginViaReflectionWithUsername:(NSString *)username password:(NSString *)password {
    // 通过字符串构造类与 selector：混淆后这些字符串若不同步修改，这里会返回 nil 导致崩溃
    Class loginClass = NSClassFromString(@"LoginManager");
    SEL sharedSelector = NSSelectorFromString(@"sharedManager");
    SEL loginSelector = NSSelectorFromString(@"loginWithUsername:password:completion:");

    if (!loginClass || !sharedSelector || !loginSelector) {
        return @"反射失败：类名或方法名被混淆";
    }

    id manager = ((id (*)(id, SEL))objc_msgSend)(loginClass, sharedSelector);

    __block NSString *resultMessage = @"";
    void (^completion)(BOOL, NSString *) = ^(BOOL success, NSString *message) {
        resultMessage = message;
    };

    ((void (*)(id, SEL, NSString *, NSString *, id))objc_msgSend)(manager, loginSelector, username, password, completion);

    return resultMessage.length > 0 ? resultMessage : @"反射调用无返回";
}

@end
