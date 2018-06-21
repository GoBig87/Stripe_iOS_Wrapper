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

        # cdef bytes myKey_bytes = myKey.encode('UTF-8')
        # cdef char* myKey_string = myKey_bytes
        # cdef bytes cardNumber_bytes = cardNumber.encode('UTF-8')
        # cdef char* cardNumber_string = cardNumber_bytes
        # cdef bytes cvc_bytes = cvc.encode('UTF-8')
        # cdef char* cvc_string = cvc_bytes

        storage.stripe = stripe_wrapper_init()
        c_string_token =  stripe_get_token(storage.stripe,myKey,cardNumber,expMonth,expYear,cvc)
        return c_string_token