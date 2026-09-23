//
//  DynamicEntry.h
//  Lobah
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 反射调用示例
/// 这里用 NSClassFromString / NSSelectorFromString 以字符串方式调用其它类，
/// 一旦相关类名与方法名被混淆，调用会直接失效 —— 因此它们必须进入混淆白名单。
@interface DynamicEntry : NSObject

- (NSString *)invokeLoginViaReflectionWithUsername:(NSString *)username password:(NSString *)password;

@end

NS_ASSUME_NONNULL_END
