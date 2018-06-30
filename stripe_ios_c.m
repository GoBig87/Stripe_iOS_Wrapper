#include "stripe_ios_c.h"
#include "stripe_ios_imp.h"

void retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc user_func, void *user_data){
    user_data('hello');
    retToken* retrieveToken = [[retToken alloc] init];
    [retrieveToken retrieveTokenObjC:myKey andcardNumber:cardNumber andexpMonth:expMonth andexpYear:expYear andcvc:cvc anduser_func:user_func anduser_data:user_data];
}