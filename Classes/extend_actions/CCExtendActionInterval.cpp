
#include "CCExtendActionInterval.h"
#include "sprite_nodes/CCSprite.h"
#include "base_nodes/CCNode.h"
#include "cocoa/CCZone.h"

NS_CC_EXT_BEGIN

//
// AlphaTo
//

CCAlphaTo* CCAlphaTo::create(float d, GLubyte from, GLubyte to)
{
	CCAlphaTo* pAction = new CCAlphaTo();
	
	pAction->initWithDuration(d, from ,to);
	pAction->autorelease();
	
	return pAction;
}

bool CCAlphaTo::initWithDuration(float d, GLubyte from, GLubyte to)
{
    if (CCActionInterval::initWithDuration(d))
    {
        m_uFromAlpha = from;
        m_uToAlpha = to;
        return true;
    }

    return false;
}

CCObject* CCAlphaTo::copyWithZone(CCZone *pZone)
{
    CCZone* pNewZone = NULL;
    CCAlphaTo* pCopy = NULL;
    if(pZone && pZone->m_pCopyObject) 
    {
        //in case of being called at sub class
        pCopy = (CCAlphaTo*)(pZone->m_pCopyObject);
    }
    else
    {
        pCopy = new CCAlphaTo();
        pZone = pNewZone = new CCZone(pCopy);
    }

    CCActionInterval::copyWithZone(pZone);

    pCopy->initWithDuration(m_fDuration, m_uFromAlpha, m_uToAlpha);

    CC_SAFE_DELETE(pNewZone);
    return pCopy;
}

void CCAlphaTo::recurAlpha(CCNode* node, GLubyte alpha)
{
    CCRGBAProtocol *pRGBAProtocol = dynamic_cast<CCRGBAProtocol*>(node);
    if (pRGBAProtocol)
    {
        pRGBAProtocol->setOpacity(alpha);
    }
	CCArray* childs = node->getChildren();
	if (childs){
		for(unsigned int i=0; i<childs->count(); i++){
			CCNode *child =  (CCNode *)(childs->objectAtIndex(i));
			if (child)
			{
				this->recurAlpha(child, alpha);
			}
		}
	}
}

void CCAlphaTo::update(float time)
{
    this->recurAlpha(m_pTarget, GLubyte(m_uFromAlpha + time * (m_uToAlpha - m_uFromAlpha)));
}

CCActionInterval* CCAlphaTo::reverse(void)
{
    return CCAlphaTo::create(m_fDuration, m_uToAlpha, m_uFromAlpha);
}

NS_CC_EXT_END