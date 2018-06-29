STUFF = "Hi"
__all__ = ['StripeWrapper']

cdef extern from "stripe_ios_c.h":
    ctypedef void (*tokenfunc)(const char *name, void *user_data)
    void retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc user_func, void *user_data)

class StripeWrapper():

    def __init__(self,**kwargs):
        foo = 'bar'
        pass

    def getToken(self,tokenCallback,myKey,cardNumber,expMonth,expYear,cvc):

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

        cdef Callback cb

        retrieveToken(myKey_bytes, cardNumber_bytes, expMonth, expYear, cvc_bytes, cb.callback, <void*>tokenCallback)
        print 'Debug 1'

cdef class Callback:
    cdef void* tokenCallback
    cdef const char* name

    @staticmethod
    cdef callback(const char* name, void *tokenCallback):
        print 'token debug'
        (< object > tokenCallback)(name.decode('utf-8'))
