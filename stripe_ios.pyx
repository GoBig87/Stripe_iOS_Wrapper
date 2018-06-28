STUFF = "Hi"
__all__ = ['StripeWrapper']

cdef extern from "stripe_ios_imp.h":
    ctypedef void *stripe_wrapper_t
    ctypedef void (*tokenfunc)(char *name, void *user_data)
    strip_wrapper_t stripe_wrapper_init()
    void stripe_get_token(stripe_wrapper_t stripe, char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc user_fun,void *user_data)

cdef class _Stripe:
    cdef stripe_wrapper_t stripe

    def __cinit__(self):
        self.stripe = NULL

cdef void callback(char *name, void *f):
    (<object>f)(name.decode('utf-8'))
    
class StripeWrapper():

    def __init__(self,**kwargs):
        self._storage = _Stripe()

    def getToken(utilToken,myKey,cardNumber,expMonth,expYear,cvc):
        cdef _Stripe storage = <_Stripe>self._storage

        cdef bytes myKey_bytes = myKey.encode('utf-8')
        cdef char* myKey_string = myKey_bytes
        cdef bytes cardNumber_bytes = cardNumber.encode('utf-8')
        cdef char* cardNumber_string = cardNumber_bytes
        cdef bytes cvc_bytes = cvc.encode('utf-8')
        cdef char* cvc_string = cvc_bytes

        print myKey_bytes
        print cardNumber_bytes
        print cvc_bytes
        print myKey_string
        print cardNumber_string
        print cvc_string
        cdef char* token_callback

        storage.stripe = stripe_wrapper_init()
        stripe_get_token(storage.stripe,myKey_bytes,cardNumber_bytes,expMonth,expYear,cvc_bytes, callback, <void*>token_callback)
        print token_callback
        utilToken.token = token_callback.decode('UTF-8')
        print 'Debug 1'
        print utilToken.token


