#import <Foundation/Foundation.h>
#import "Stripe/PublicHeaders/STPCardParams.h"
#import "Stripe/PublicHeaders/STPAPIClient.h"
#import "Stripe/PublicHeaders/STPToken.h"
#import <Foundation/NSError.h>
#import <Foundation/NSString.h>

#include "stripe_ios_imp.h"

@implementation retToken

- (void) retrieveTokenObjC:(char*)myKey andcardNumber:(char*)cardNumber andexpMonth:(int)expMonth andexpYear:(int)expYear andcvc:(char*)cvc anduser_func:(tokenfunc)user_func anduser_data:(void*)user_data {

    NSString* NScardNumber = [NSString stringWithUTF8String:cardNumber];
    NSString* NScvc = [NSString stringWithUTF8String:cvc];
    NSLog(@"%@",NScardNumber);
    NSLog(@"%@",NScvc);
    STPCardParams *cardParams = [[STPCardParams alloc] init];
    cardParams.number = NScardNumber;
    cardParams.expMonth = expMonth;
    cardParams.expYear = expYear;
    cardParams.cvc = NScvc;
    NSLog(@"DEBUG_STRIPE1");
    NSString *myPublishableKey = [NSString stringWithUTF8String:myKey];
    STPAPIClient *apiClient = [[STPAPIClient alloc] initWithPublishableKey:myPublishableKey];
    NSLog(@"DEBUG_STRIPE2");
    [apiClient createTokenWithCard:cardParams completion:^(STPToken *token,NSError *error) {
        NSLog(@"DEBUG_STRIPE3");
        if (token == nil || error != nil) {
            NSLog(@"ERROR1");
            const char* errorChar = [error.localizedDescription UTF8String];
            user_func(errorChar,user_data);
            NSLog(@"ERROR2");
            NSLog(@"%@",error.localizedDescription);
        } else {
            NSLog(@"%@",token.tokenId);
            const char* tokenChar = [token.tokenId UTF8String];
            NSLog(@"Success2");
            user_func(tokenChar,user_data);
            NSLog(@"Success3");
            NSLog(@"%@",token.tokenId);
        }
    }];
}

@end

void retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc user_func, void *user_data){

    retToken* retrieveToken = [[retToken alloc] init];
    [retrieveToken retrieveTokenObjC:myKey andcardNumber:cardNumber andexpMonth:expMonth andexpYear:expYear andcvc:cvc anduser_func:user_function anduser_data:user_data];
}