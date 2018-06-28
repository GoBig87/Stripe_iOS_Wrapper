STUFF = "Hi"
__all__ = ['StripeWrapper']

cdef extern from "stripe_ios_imp.h":
    ctypedef void (*tokenfunc)(char *name, void *user_data)
    void retrieveToken(tokenfunc callback_func,char* myKey, char* cardNumber, int expMonth, int expYear, char* cvc,void *user_data)

cdef void callback(char *name, void *f):
    (<object>f)(name.decode('utf-8'))

def getToken(self,util,myKey,cardNumber,expMonth,expYear,cvc):

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

    retrieveToken( myKey_bytes, cardNumber_bytes, expMonth, expYear, cvc_bytes, callback, <void*>util.token)
    print token_callback
    util.token = token_callback.decode('UTF-8')
    print 'Debug 1'
    print util.token


