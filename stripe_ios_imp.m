#import <Foundation/Foundation.h>
#import "Stripe/PublicHeaders/STPCardParams.h"
#import "Stripe/PublicHeaders/STPAPIClient.h"
#import "Stripe/PublicHeaders/STPToken.h"
#import <Foundation/NSError.h>
#import <Foundation/NSString.h>

class StripWrapper {
public:
    StripWrapper();
    ~StripWrapper();
    const char* retrieveToken(const char* myKey, const char* cardNumber, int expMonth, int expYear, const char* cvc);
};
StripWrapper::StripWrapper(){
}

const char* StripWrapper::retrieveToken(const char* myKey, const char* cardNumber, int expMonth, int expYear, const char* cvc) {

    NSString* NScardNumber = [NSString stringWithUTF8String:cardNumber];
    NSString* NScvc = [NSString stringWithUTF8String:cvc];

    STPCardParams *cardParams = [[STPCardParams alloc] init];
    cardParams.number = NScardNumber;
    cardParams.expMonth = expMonth;
    cardParams.expYear = expYear;
    cardParams.cvc = NScvc;

    __block const char* returnString;
    NSString myPublishableKey = [NSString stringWithUTF8String:myKey];

    STPAPIClient *sharedClient = [[STPAPIClient alloc] initWithPublishableKey:myPublishableKey];

    [sharedClient createTokenWithCard:cardParams completion:^(STPToken *token,NSError *error) {
        if (token == nil || error != nil) {
            printf('DEBUG ERROR REQ')
            printf([error.localizedDescription UTF8String])
            returnString = [error.localizedDescription UTF8String];
        }
        else{
            printf('DEBUG TOKEN REQ')
            printf([token.tokenId UTF8String])
            returnString =  [token.tokenId UTF8String];
        }
    }];
    return returnString;
}

//
// C-like API for easier interaction with Cython
//

#include "stripe_ios_imp.h"

strip_wrapper_t stripe_wrapper_init() {
    return new StripWrapper();
}
const char* stripe_get_token(strip_wrapper_t stripe, const char* myKey, const char* cardNumber, int expMonth, int expYear, const char* cvc){
    return ((StripWrapper *)stripe)->retrieveToken(cardNumber,expMonth,expYear,cvc);
}
