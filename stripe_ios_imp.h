#import <Foundation/Foundation.h>
typedef void tokenfunc* (const char *name, void *user_data);

@interface retToken : NSObject
- (void) retrieveTokenObjC:(char*)myKey andcardNumber:(char*)cardNumber andexpMonth:(int)expMonth andexpYear:(int)expYear andcvc:(char*)cvc anduser_func:(tokenfunc)user_func anduser_data:(void*)user_data;
@end