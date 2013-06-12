
#ifndef __ACTION_CCEXTEND_INTERVAL_ACTION_H__
#define __ACTION_CCEXTEND_INTERVAL_ACTION_H__

#include "cocos2d_ext_const.h"
#include "base_nodes/CCNode.h"
#include "actions/CCActionInterval.h"
#include "CCProtocols.h"
#include "sprite_nodes/CCSpriteFrame.h"
#include "sprite_nodes/CCAnimation.h"
#include <vector>

NS_CC_EXT_BEGIN

class CCAlphaTo : public CCActionInterval
{
public:
	bool initWithDuration(float duration, GLubyte from, GLubyte to);
	
	virtual void update(float time);
    virtual CCActionInterval* reverse(void);
    virtual CCObject* copyWithZone(CCZone* pZone);
    
public:
    /** creates the action */
    static CCAlphaTo* create(float d, GLubyte from, GLubyte to);
    
private:
	GLubyte m_uFromAlpha;
	GLubyte m_uToAlpha;
	
	void recurAlpha(CCNode* node, GLubyte alpha);
};

NS_CC_EXT_END
#endif //__ACTION_CCEXTEND_INTERVAL_ACTION_H__