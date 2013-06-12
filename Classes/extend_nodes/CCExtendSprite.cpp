#include "CCExtendSprite.h"

#include "textures/CCTextureCache.h"
#include "shaders/CCShaderCache.h"
#include "shaders/ccShaders.h"

extern "C"
{
#include <stdio.h>
}
NS_CC_EXT_BEGIN

const GLchar * ccHueTranfer_frag = 
#include "ccShader_HueTransfer_frag.h"

CCExtendSprite::CCExtendSprite(void)
: m_uHueOffset(0)
{
}

CCExtendSprite::~CCExtendSprite(void)
{
}

CCExtendSprite* CCExtendSprite::create(const char* pszFileName)
{
    CCExtendSprite *pobSprite = new CCExtendSprite();
    if (pobSprite && pobSprite->initWithFile(pszFileName))
    {
        pobSprite->autorelease();
        return pobSprite;
    }
    CC_SAFE_DELETE(pobSprite);
    return NULL;
}

bool CCExtendSprite::initWithFile(const char* pszFilename)
{
	CCAssert(pszFilename != NULL, "Invalid filename for sprite");

    CCTexture2D *pTexture = CCTextureCache::sharedTextureCache()->addImage(pszFilename, true);
    if (pTexture)
    {
        CCRect rect = CCRectZero;
        rect.size = pTexture->getContentSize();
        return initWithTexture(pTexture, rect);
    }
    return false;
}

bool CCExtendSprite::isAlphaTouched(CCPoint nodePoint)
{
	CCPoint basePoint = this->getTextureRect().origin;
	return this->getTexture()->getAlphaAtPoint(basePoint.x + nodePoint.x, basePoint.y + nodePoint.y) == 0;
}

void CCExtendSprite::setHueOffset(int offset)
{
	if(m_uHueOffset != offset){
		m_uHueOffset = offset;
		if(m_uHueOffset == 0){
		   this->setShaderProgram(CCShaderCache::sharedShaderCache()->programForKey(kCCShader_PositionTextureColor));
		}
		else{
			char* key = new char[30];
			sprintf(key, "%s_%d", kCCHueTransfer_Frag, m_uHueOffset);
			CCGLProgram* pProgram = CCShaderCache::sharedShaderCache()->programForKey(key);
			if(pProgram == NULL){
				pProgram = new CCGLProgram();
				pProgram->initWithVertexShaderByteArray(ccPositionTextureColor_vert, ccHueTranfer_frag);
				pProgram->addAttribute(kCCAttributeNamePosition, kCCVertexAttrib_Position);  
				pProgram->addAttribute(kCCAttributeNameColor, kCCVertexAttrib_Color);  
				pProgram->addAttribute(kCCAttributeNameTexCoord, kCCVertexAttrib_TexCoords); 
				pProgram->link();
				pProgram->updateUniforms();

				int m_uHueShaderLocation = glGetUniformLocation(pProgram->getProgram(), "u_hueOffset");
				glUniform1f(m_uHueShaderLocation, m_uHueOffset/60.0f);

				CCShaderCache::sharedShaderCache()->addProgram(pProgram, key); 
				pProgram->release();
			}

			this->setShaderProgram(pProgram);
		}
	}
}

void CCExtendSprite::draw()
{
	CCSprite::draw();
}

NS_CC_EXT_END