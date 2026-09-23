//
//  LoginManager.h
//  Lobah
//

#import <Foundation/Foundation.h>
#import "UserAccount.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^LoginCompletion)(BOOL success, NSString *message);

/// 登录管理器：典型的高价值逆向目标（攻击者最想 Hook 的地方）
@interface LoginManager : NSObject

@property (nonatomic, strong, nullable) UserAccount *currentAccount;
@property (nonatomic, assign, readonly, getter=isLoggedIn) BOOL loggedIn;
/// 明文写死的服务地址 —— 静态扫描（MobSF）会直接把它标为暴露项
@property (nonatomic, copy) NSString *authEndpoint;

+ (instancetype)sharedManager;

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
               completion:(LoginCompletion)completion;

- (BOOL)validateSessionToken:(NSString *)token;

- (void)logoutCurrentUser;

@end

NS_ASSUME_NONNULL_END
