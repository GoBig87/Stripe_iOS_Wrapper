#import <Foundation/Foundation.h>
#import "Stripe/STPCardParams.h"
#import "Stripe/STPAPIClient.h"
#import "Stripe/STPToken.h"
#import <Foundation/NSError.h>
#import <Foundation/NSString.h>

class StripWrapper {
public:
    StripWrapper();
    ~StripWrapper();
    const char* retrieveToken(const char* cardNumber, int expMonth, int expYear, const char* cvc);
};
StripWrapper::StripWrapper(){
}

const char* StripWrapper::retrieveToken(const char* cardNumber, int expMonth, int expYear, const char* cvc) {

    NSString* NScardNumber = [NSString stringWithUTF8String:cardNumber];
    NSString* NScvc = [NSString stringWithUTF8String:cvc];

    STPCardParams *cardParams = [[STPCardParams alloc] init];
    cardParams.number = NScardNumber;
    cardParams.expMonth = expMonth;
    cardParams.expYear = expYear;
    cardParams.cvc = NScvc;

    [[STPAPIClient sharedClient] createTokenWithCard:cardParams completion:^(STPToken *token, NSError *error) {
        if (token == nil || error != nil) {
            NSString ErrorString = error.localizedDescription;
            char *ErrorChar = [ErrorString UTF8String];
            return ErrorChar;
        }
        else{
            char *tokenChar = [token.tokenId UTF8String];
            return tokenChar;
        }
    }];
}

//
// C-like API for easier interaction with Cython
//

#include "stripe_ios_imp.h"

strip_wrapper_t stripe_wrapper_init() {
    return new StripWrapper();
}
const char* stripe_get_token(strip_wrapper_t stripe, const char* cardNumber, int expMonth, int expYear, const char* cvc){
    return ((StripWrapper *)stripe)->retrieveToken(cardNumber,expMonth,expYear,cvc);
}
