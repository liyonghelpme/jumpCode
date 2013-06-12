#include "CCExtendNode.h"

#include "effects/CCGrid.h"
// externals
#include "kazmath/GL/matrix.h"

NS_CC_EXT_BEGIN

CCExtendNode* CCExtendNode::create(const CCSize contentSize)
{
    CCExtendNode *pobNode = new CCExtendNode();
    if (pobNode)
    {
		pobNode->setContentSize(contentSize);
        pobNode->autorelease();
        return pobNode;
    }
    CC_SAFE_DELETE(pobNode);
    return NULL;
}

void CCExtendNode::visit()
{
    if (!m_bVisible)
    {
        return;
    }
	kmGLPushMatrix();
	
	glEnable(GL_SCISSOR_TEST);
	CCPoint leftBottomPoint = this->convertToWorldSpace(CCPointMake(0,0));
	CCSize size = this->getContentSize();
	CCPoint rightTopPoint = this->convertToWorldSpace(CCPointMake(size.width, size.height));
	glScissor(leftBottomPoint.x, leftBottomPoint.y, rightTopPoint.x-leftBottomPoint.x, rightTopPoint.y-leftBottomPoint.y);
     
     if (m_pGrid && m_pGrid->isActive())
     {
         m_pGrid->beforeDraw();
     }

    this->transform();

    CCNode* pNode = NULL;
    unsigned int i = 0;

    if(m_pChildren && m_pChildren->count() > 0)
    {
        sortAllChildren();
        // draw children zOrder < 0
        ccArray *arrayData = m_pChildren->data;
        for( ; i < arrayData->num; i++ )
        {
            pNode = (CCNode*) arrayData->arr[i];

			if ( pNode && pNode->getZOrder() < 0 ) 
            {
                pNode->visit();
            }
            else
            {
                break;
            }
        }
        // self draw
        this->draw();

        for( ; i < arrayData->num; i++ )
        {
            pNode = (CCNode*) arrayData->arr[i];
            if (pNode)
            {
                pNode->visit();
            }
        }        
    }
    else
    {
        this->draw();
    }

    // reset for next frame
    m_uOrderOfArrival = 0;

     if (m_pGrid && m_pGrid->isActive())
     {
         m_pGrid->afterDraw(this);
    }
	glDisable(GL_SCISSOR_TEST);
 
    kmGLPopMatrix();
}
NS_CC_EXT_END