//
//  CryptoUtils.m
//  Lobah
//

#import "CryptoUtils.h"
#import <CommonCrypto/CommonDigest.h>

@implementation CryptoUtils

+ (NSString *)md5DigestOfString:(NSString *)string {
    return [self digestOfString:string length:CC_MD5_DIGEST_LENGTH digestBlock:^unsigned char *(NSData *data, uint8_t *buffer) {
        return CC_MD5(data.bytes, (CC_LONG)data.length, buffer);
    }];
}

+ (NSString *)sha256DigestOfString:(NSString *)string {
    return [self digestOfString:string length:CC_SHA256_DIGEST_LENGTH digestBlock:^unsigned char *(NSData *data, uint8_t *buffer) {
        return CC_SHA256(data.bytes, (CC_LONG)data.length, buffer);
    }];
}

+ (NSString *)signPayload:(NSString *)payload withSalt:(NSString *)salt {
    NSString *combined = [NSString stringWithFormat:@"%@|%@|lobah", payload, salt];
    NSString *first = [self md5DigestOfString:combined];
    return [self sha256DigestOfString:[first stringByAppendingString:combined]];
}

#pragma mark - Private

+ (NSString *)digestOfString:(NSString *)string
                      length:(int)length
                 digestBlock:(unsigned char *(^)(NSData *data, uint8_t *buffer))digestBlock {
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *output = [NSMutableString stringWithCapacity:length * 2];
    uint8_t buffer[length];
    digestBlock(data, buffer);
    for (int i = 0; i < length; i++) {
        [output appendFormat:@"%02x", buffer[i]];
    }
    return output;
}

@end
