//
//  UserAccount.m
//  Lobah
//

#import "UserAccount.h"

@implementation UserAccount

- (instancetype)initWithUsername:(NSString *)username userId:(NSString *)userId {
    self = [super init];
    if (self) {
        _username = [username copy];
        _userId = [userId copy];
        _sessionToken = @"";
        _accountBalance = 0.0;
    }
    return self;
}

- (NSString *)accountSummary {
    return [NSString stringWithFormat:@"%@(%@) 余额: %.2f", self.username, self.userId, self.accountBalance];
}

@end
