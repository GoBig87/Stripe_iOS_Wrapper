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
    NSString* retrieveToken(NSString* cardNumber, int expMonth, int expYear, NSString* cvc);
};
StripWrapper::StripWrapper(){
}

NSString* StripWrapper::retrieveToken(NSString* cardNumber, int expMonth, int expYear, NSString* cvc) {

    STPCardParams *cardParams = [[STPCardParams alloc] init];
    cardParams.number = cardNumber;
    cardParams.expMonth = expMonth;
    cardParams.expYear = expYear;
    cardParams.cvc = cvc;

    [[STPAPIClient sharedClient] createTokenWithCard:cardParams completion:^(STPToken *token, NSError *error) {
        if (token == nil || error != nil) {
            return [error localizedDescription];
        }
        else{
            return [token.tokenId UTF8String];
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
const char stripe_get_token(strip_wrapper_t stripe, int cardNumber, int expMonth, int expYear, int cvc){
    return ((StripWrapper *)stripe)->retrieveToken(cardNumber,expMonth,expYear,cvc);
}
