STUFF = "Hi"
__all__ = ['StripeWrapper']

cdef extern from "stripe_ios_imp.h":
    ctypedef void *strip_wrapper_t
    strip_wrapper_t stripe_wrapper_init()
    const char* stripe_get_token(strip_wrapper_t stripe,const char* myKey, const char* cardNumber, int expMonth, int expYear,const char* cvc)

cdef class _Stripe:
    cdef strip_wrapper_t stripe

    def __cinit__(self):
        self.stripe = NULL

class StripeWrapper():

    def __init__(self,**kwargs):
        self._storage = _Stripe()

    def getToken(self,myKey,cardNumber,expMonth,expYear,cvc):
        cdef _Stripe storage = <_Stripe>self._storage
        storage.stripe = stripe_wrapper_init()
        return stripe_get_token(storage.stripe,myKey,cardNumber,expMonth,expYear,cvc)