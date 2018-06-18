STUFF = "Hi"
__all__ = ['StripeWrapper']

cdef extern from "stripe_ios.h":
    ctypedef void *strip_wrapper_t
    strip_wrapper_t stripe_wrapper_init()
    const char stripe_get_token(strip_wrapper_t stripe, int cardNumber, int expMonth, int expYear,int cvc)

cdef class _Stripe:
    cdef strip_wrapper_t stripe

    def __cinit__(self):
        self.stripe = NULL

class StripeWrapper():

    def __init__(self,**kwargs):
        super(StripeWrapper, self).__init__(**kwargs)

    def getToken(self,cardNumber,expMonth,expYear,cvc):
        cdef _Stripe storage = <_Stripe>self._storage
        storage.stripe = stripe_wrapper_init()
        self.token = stripe_get_token(storage.stripe,cardNumber,expMonth,expYear,cvc)