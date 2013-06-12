#include "CaeWebView.h"

NS_CC_EXT_BEGIN
CaeWebView::CaeWebView(){
}

CaeWebView::~CaeWebView(){
}

void CaeWebView::webViewDidFinishLoad(){
}

void CaeWebView::closeWebView(){
	this->removeFromParentAndCleanup(true);
#if(CC_TARGET_PLATFORM==CC_PLATFORM_IOS)
	[impl closeWebView];
#elif(CC_TARGET_PLATFORM==CC_PLATFORM_ANDROID)
	
#endif
}

// only do normal set here
bool CaeWebView::init(){
	if(!!CCLayer::init()){
		return false;
	}
	
#if(CC_TARGET_PLATFORM==CC_PLATFORM_IOS)
	impl = [[CaeWebView_iosImpl alloc] init];
	[impl addWebView:this withUrl:"http://www.baidu.com"];
#elif(CC_TARGET_PLATFORM==CC_PLATFORM_ANDROID)
	
#endif
}

NS_CC_EXT_END