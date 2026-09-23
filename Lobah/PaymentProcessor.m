//
//  PaymentProcessor.m
//  Lobah
//

#import "PaymentProcessor.h"
#import "CryptoUtils.h"

@implementation PaymentProcessor

+ (instancetype)sharedProcessor {
    static PaymentProcessor *processor = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        processor = [[PaymentProcessor alloc] init];
        processor.merchantIdentifier = @"merchant.com.mozat.lobah";
        processor->_merchantSecretKey = @"LOBAAH_PLAINTEXT_SECRET_2026";
    });
    return processor;
}

- (void)payWithOrderId:(NSString *)orderId
                amount:(double)amount
            completion:(PaymentCompletion)completion {
    if (orderId.length == 0 || amount <= 0) {
        if (completion) { completion(NO, @""); }
        return;
    }

    NSString *payload = [NSString stringWithFormat:@"%@|%.2f|%@", orderId, amount, self.merchantIdentifier];
    NSString *signedValue = [CryptoUtils signPayload:payload withSalt:self.merchantSecretKey];
    NSString *transactionId = [signedValue substringToIndex:16];

    if (completion) { completion(YES, transactionId); }
}

- (BOOL)verifyReceiptData:(NSData *)receiptData {
    return receiptData.length > 0;
}

@end
