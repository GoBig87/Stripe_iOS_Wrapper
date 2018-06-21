typedef void *strip_wrapper_t;

strip_wrapper_t stripe_wrapper_init();
const char* stripe_get_token(strip_wrapper_t stripe,const char* myKey, const char* cardNumber, int expMonth, int expYear, const char* cvc);