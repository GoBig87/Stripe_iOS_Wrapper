#import <Foundation/Foundation.h>
#import "Stripe/PublicHeaders/STPCardParams.h"
#import "Stripe/PublicHeaders/STPAPIClient.h"
#import "Stripe/PublicHeaders/STPToken.h"
#import <Foundation/NSError.h>
#import <Foundation/NSString.h>

#include "stripe_ios_imp.h"

void retrieveToken(tokenfunc callback_func,char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,void *user_data){

    NSString* NScardNumber = [NSString stringWithUTF8String:cardNumber];
    NSString* NScvc = [NSString stringWithUTF8String:cvc];

    STPCardParams *cardParams = [[STPCardParams alloc] init];
    cardParams.number = NScardNumber;
    cardParams.expMonth = expMonth;
    cardParams.expYear = expYear;
    cardParams.cvc = NScvc;

    NSString *myPublishableKey = [NSString stringWithUTF8String:myKey];
    STPAPIClient *sharedClient = [[STPAPIClient alloc] initWithPublishableKey:myPublishableKey];

    [sharedClient createTokenWithCard:cardParams completion:^(STPToken *token,NSError *error) {
        NSString *tokenChar;
        if (token == nil || error != nil) {
            tokenChar = [error.localizedDescription UTF8String];
        } else {
            tokenChar = [token.tokenId UTF8String];
        }
        if (completion) callback_func(tokenChar,user_data);
    }];
}

