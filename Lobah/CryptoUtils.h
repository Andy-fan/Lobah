//
//  CryptoUtils.h
//  Lobah
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 加密/摘要工具：核心算法模块，属于需要高强度保护的资产
@interface CryptoUtils : NSObject

+ (NSString *)md5DigestOfString:(NSString *)string;

+ (NSString *)sha256DigestOfString:(NSString *)string;

/// 简易混淆签名，演示算法型代码
+ (NSString *)signPayload:(NSString *)payload withSalt:(NSString *)salt;

@end

NS_ASSUME_NONNULL_END
