typedef void *tokenfunc(char *name, void *user_data);

void retrieveToken(tokenfunc callback_func, char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc, void *user_data);