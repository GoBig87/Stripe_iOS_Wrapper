typedef void (*tokenfunc)(char *name, void *user_data);
void retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc user_func, void *user_data);