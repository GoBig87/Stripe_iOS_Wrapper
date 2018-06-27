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
    char* retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc);
    char *tokenChar;
};
StripWrapper::StripWrapper(){
}

char* StripWrapper::retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc) {

    NSString* NScardNumber = [NSString stringWithUTF8String:cardNumber];
    NSString* NScvc = [NSString stringWithUTF8String:cvc];

    STPCardParams *cardParams = [[STPCardParams alloc] init];
    cardParams.number = NScardNumber;
    cardParams.expMonth = expMonth;
    cardParams.expYear = expYear;
    cardParams.cvc = NScvc;

    char* returnString;
    _block const char* errorChar
    _block const char* tokenChar

    NSString *myPublishableKey = [NSString stringWithUTF8String:myKey];

    STPAPIClient *sharedClient = [[STPAPIClient alloc] initWithPublishableKey:myPublishableKey];

    [sharedClient createTokenWithCard:cardParams completion:^(STPToken *token,NSError *error) {
        if (token == nil || error != nil) {
            tokenChar = [error.localizedDescription UTF8String];
        }
        else{
            tokenChar = [token.tokenId UTF8String];
        }
    }];
    while(tokenChar == nil){
    }
    return tokenChar;
}

//
// C-like API for easier interaction with Cython
//

#include "stripe_ios_imp.h"

strip_wrapper_t stripe_wrapper_init() {
    return new StripWrapper();
}
char* stripe_get_token(strip_wrapper_t stripe, char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc){
    return ((StripWrapper *)stripe)->retrieveToken(myKey,cardNumber,expMonth,expYear,cvc);
}
