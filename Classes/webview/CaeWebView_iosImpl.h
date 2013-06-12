#if(CC_TARGET_PLATFORM==CC_PLATFORM_IOS)
#import <UIKit/UIKit.h>

#import "CaeWebView.h"

@interface CaeWebView_iosImpl : NSObject<UIWebViewDelegate>
{
	CaeWebView	*mLayerView;
	UIView		*mIosView;
	UIWebView	*mWebView;
}

-(void) addWebView : (CaeWebView *)layerView withUrl:(const char*) cstringUrl;

-(void) closeWebView;

@end

#endif