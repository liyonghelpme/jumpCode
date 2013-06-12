#ifndef	__CAESARS_NODE_CCEXTENDNODE_H__
#define __CAESARS_NODE_CCEXTENDNODE_H__

#include "cocos2d_ext_const.h"
#include "base_nodes/CCNode.h"

NS_CC_EXT_BEGIN
class CCExtendNode : public CCNode
{
public:
	static CCExtendNode* create(const CCSize contentSize);
public:
    virtual void visit();
};
NS_CC_EXT_END

#endif //__CAESARS_NODE_CCEXTENDNODE_H__