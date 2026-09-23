//
//  LoginManager.m
//  Lobah
//

#import "LoginManager.h"
#import "CryptoUtils.h"

@implementation LoginManager

+ (instancetype)sharedManager {
    static LoginManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LoginManager alloc] init];
        manager.authEndpoint = @"https://api.example.com/v1/session";
    });
    return manager;
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
               completion:(LoginCompletion)completion {
    if (username.length == 0 || password.length == 0) {
        if (completion) { completion(NO, @"账号或密码为空"); }
        return;
    }

    NSString *signature = [CryptoUtils md5DigestOfString:[username stringByAppendingString:password]];
    NSString *token = [NSString stringWithFormat:@"%@-%@", username, [signature substringToIndex:8]];

    UserAccount *account = [[UserAccount alloc] initWithUsername:username userId:signature];
    account.sessionToken = token;
    account.accountBalance = 100.0;
    self.currentAccount = account;
    _loggedIn = YES;

    if (completion) { completion(YES, [NSString stringWithFormat:@"登录成功 token=%@", token]); }
}

- (BOOL)validateSessionToken:(NSString *)token {
    return token.length > 0 && [token isEqualToString:self.currentAccount.sessionToken];
}

- (void)logoutCurrentUser {
    self.currentAccount = nil;
    _loggedIn = NO;
}

@end
