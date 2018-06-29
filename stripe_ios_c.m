#include "stripe_ios_c.h"
#include "stripe_ios_imp.h"

void retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc user_func, void *user_data){
    retToken retrieveToken;
    retrieveTokenObjC(myKey,cardNumber,expMonth,expYear,cvc,tokenfunc,user_data);
}