#import <Foundation/Foundation.h>
#import "Stripe/PublicHeaders/STPCardParams.h"
#import "Stripe/PublicHeaders/STPAPIClient.h"
#import "Stripe/PublicHeaders/STPToken.h"
#import <Foundation/NSError.h>
#import <Foundation/NSString.h>

class StripeWrapper {
public:
    StripeWrapper();
    ~StripeWrapper();
    void retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc callback_func,void *user_data);
};
StripeWrapper::StripeWrapper(){
}

void StripeWrapper::retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc callback_func,void *user_data){

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

//
// C-like API for easier interaction with Cython
//

#include "stripe_ios_imp.h"

stripe_wrapper_t stripe_wrapper_init() {
    return new StripeWrapper();
}
void stripe_get_token(stripe_wrapper_t stripe, char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc callback_func,void *user_data){
    return ((StripeWrapper *)stripe)->retrieveToken(myKey,cardNumber,expMonth,expYear,cvc,callback_func,user_data);
}
