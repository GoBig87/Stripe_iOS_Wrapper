typedef void *strip_wrapper_t;

strip_wrapper_t stripe_wrapper_init();
const char stripe_get_token(strip_wrapper_t stripe, int cardNumber, int expMonth, int expYear, int cvc);