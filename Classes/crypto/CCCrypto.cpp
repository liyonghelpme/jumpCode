
#include "crypto/CCCrypto.h"
#include <string>

extern "C" {
#include "crypto/md5/md5.h"
#include <stdio.h>
#include <string.h>
}

NS_CC_EXT_BEGIN

void CCCrypto::MD5(void* input, int inputLength, unsigned char* output)
{
    MD5_CTX ctx;
    MD5_Init(&ctx);
    MD5_Update(&ctx, input, inputLength);
    MD5_Final(output, &ctx);
}

/* make encoded str with MD5; need to be deleted by user */
const char* CCCrypto::md5encode(const char* input)
{
    unsigned char buffer[MD5_BUFFER_LENGTH];
	char* cbuffer = new char[MD5_BUFFER_LENGTH*2 + 1];
	int i=0;
    MD5((void *)input, strlen(input), buffer);

	for(i=0;i<MD5_BUFFER_LENGTH;i++){
		sprintf(cbuffer + i*2, "%02x", buffer[i]);
	}
	return cbuffer;
}

NS_CC_EXT_END
