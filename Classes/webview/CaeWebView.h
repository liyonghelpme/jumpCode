#ifndef __CAE_WEBVIEW_H__
#define __CAE_WEBVIEW_H__

#include "cocos2d.h"

#if(CC_TARGET_PLATFORM==CC_PLATFORM_IOS)
#import "CaeWebView_iosImpl.h"
#elif(CC_TARGET_PLATFORM==CC_PLATFORM_ANDROID)
#import "CaeWebView_androidImpl.h"
#endif

NS_CC_EXT_BEGIN
class CaeWebView: public CCLayer
{
private:
#if(CC_TARGET_PLATFORM==CC_PLATFORM_IOS)
	CaeWebView_iosImpl		*impl;
#elif(CC_TARGET_PLATFORM==CC_PLATFORM_ANDROID)
	CaeWebView_androidImpl	*impl;
#endif
public:
	CaeWebView();
	~CaeWebView();

	virtual bool init();

	void webViewDidFinishLoad();

	void closeWebView();
};
NS_CC_EXT_END

#endif //__CAE_WEBVIEW_H__