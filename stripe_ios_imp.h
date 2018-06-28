typedef void *stripe_wrapper_t;
typedef void (*tokenfunc)(char *name, void *user_data);

stripe_wrapper_t stripe_wrapper_init();
void stripe_get_token(strip_wrapper_t stripe, char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc callback_func,void *user_data);