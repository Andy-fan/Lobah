//
//  UserAccount.h
//  Lobah
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 账号模型：混淆演示用的业务数据结构
@interface UserAccount : NSObject

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *sessionToken;
@property (nonatomic, assign) double accountBalance;

- (instancetype)initWithUsername:(NSString *)username userId:(NSString *)userId;

/// 账户摘要，用于展示
- (NSString *)accountSummary;

@end

NS_ASSUME_NONNULL_END
