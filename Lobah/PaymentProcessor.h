//
//  PaymentProcessor.h
//  Lobah
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^PaymentCompletion)(BOOL success, NSString *transactionId);

/// 支付处理器：资金链路，混淆时通常被列为最高强度保护对象
@interface PaymentProcessor : NSObject

@property (nonatomic, copy) NSString *merchantIdentifier;
/// 写死的密钥 —— 静态扫描的高危暴露项，真实项目不应硬编码
@property (nonatomic, copy, readonly) NSString *merchantSecretKey;

+ (instancetype)sharedProcessor;

- (void)payWithOrderId:(NSString *)orderId
                amount:(double)amount
            completion:(PaymentCompletion)completion;

- (BOOL)verifyReceiptData:(NSData *)receiptData;

@end

NS_ASSUME_NONNULL_END
