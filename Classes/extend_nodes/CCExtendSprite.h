#ifndef __CAESARS_NODE_CCEXTENDSPRITE_H__
#define __CAESARS_NODE_CCEXTENDSPRITE_H__

#include "cocos2d_ext_const.h"
#include "CCGL.h"
#include "sprite_nodes/CCSprite.h"

#define	kCCHueTransfer_Frag	"ccHueTransfer_frag"

NS_CC_EXT_BEGIN
class CCExtendSprite : public CCSprite
{
protected:
	int m_uHueOffset;
public:
	static CCExtendSprite* create(const char* pszFileName);
public:
    CCExtendSprite(void);
    ~CCExtendSprite(void);

	virtual bool initWithFile(const char* pszFileName);

	virtual bool isAlphaTouched(CCPoint nodePoint);

	void setHueOffset(int angle);

	virtual void draw();
};

extern const GLchar * ccHueTranfer_frag;

NS_CC_EXT_END

#endif //__CAESARS_NODE_CCEXTENDSPRITE_H__