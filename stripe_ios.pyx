STUFF = "Hi"
__all__ = ['StripeWrapper']

cdef extern from "stripe_ios.h":
    ctypedef void *strip_wrapper_t
    strip_wrapper_t stripe_wrapper_init()
    const char stripe_get_token(int cardNumber, int expMonth, int expYear,int cvc)

class StripeWrapper():

    def __cinit__(self,**kwargs):
        super(StripeWrapper, self).__cinit__(**kwargs)

    def getToken(self,cardNumber,expMonth,expYear,cvc):
        self.token = stripe_get_token(cardNumber,expMonth,expYear,cvc)