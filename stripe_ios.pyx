STUFF = "Hi"
__all__ = ['StripeWrapper']

cdef extern from "stripe_ios_imp.h":
    ctypedef void (*tokenfunc)(const char *name, void *user_data)
    void retrieveToken(char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,tokenfunc user_func, void *user_data)

class StripeWrapper():

    def __init__(self,**kwargs):
        foo = 'bar'
        pass

    def getToken(self,utilToken,myKey,cardNumber,expMonth,expYear,cvc):

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

        retrieveToken(myKey_bytes, cardNumber_bytes, expMonth, expYear, cvc_bytes, callback, <void*>utilToken)
        print 'Debug 1'
        print utilToken

cdef void callback(const char *name, void *utilToken):
    (<object>utilToken)(name.decode('utf-8'))
