
#ifndef __CC_EXTENSION_CCCRYPTO_H_
#define __CC_EXTENSION_CCCRYPTO_H_

#include "cocos2d_ext_const.h"

NS_CC_EXT_BEGIN

class CCCrypto
{
public:
    static const int MD5_BUFFER_LENGTH = 16;
    
    /** @brief Calculate MD5, get MD5 code (not string) */
    static void MD5(void* input, int inputLength,
                    unsigned char* output);
    
    /** @brief Calculate MD5, return MD5 string */
    static const char* md5encode(const char* input);
    
private:
    CCCrypto(void) {}
};

NS_CC_EXT_END

#endif // __CC_EXTENSION_CCCRYPTO_H_
