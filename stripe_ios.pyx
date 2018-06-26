STUFF = "Hi"
__all__ = ['StripeWrapper']

from libc.stdlib cimport malloc, free

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

        cdef const char **myKey_buf = malloc(len(myKey) * sizeof(char*))
        for i in range(len(myKey)):
            myKey_buf[i] = PyString_AsString(myKey[i])

        cdef const char **cardNumber_buf = malloc(len(cardNumber) * sizeof(char*))
        for i in range(len(cardNumber)):
            cardNumber_buf[i] = PyString_AsString(cardNumber[i])

        cdef const char **cvc_buf = malloc(len(cvc) * sizeof(char*))
        for i in range(len(cvc)):
            cvc_buf[i] = PyString_AsString(cvc[i])

        storage.stripe = stripe_wrapper_init()
        cdef const char* c_string_token =  stripe_get_token(storage.stripe,myKey_buf,cardNumber_buf,expMonth,expYear,cvc_buf)
        cdef bytes c_bytes_token = c_string_token
        python_token = c_bytes_token.decode("utf-8")
        return python_token