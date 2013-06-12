#include "cocos2d_ext_tolua.h"
#include "tolua_fix.h"

#include "cocos2d.h"
#include "cocos2d_ext.h"

using namespace cocos2d;
using namespace cocos2d::extension;

/* method: create of class CCExtendNode */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCExtendNode_create00
static int tolua_Cocos2d_CCExtendNode_create00(lua_State* tolua_S)
{
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCExtendNode",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"const CCSize",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
 {
  const CCSize* size = ((const CCSize*)  tolua_tousertype(tolua_S,2,0));
  {
   CCExtendNode* tolua_ret = (CCExtendNode*)  CCExtendNode::create(*size);
    int nID = (tolua_ret) ? tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCExtendNode");
  }
 }
 return 1;
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class CCExtendSprite */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCExtendSprite_create00
static int tolua_Cocos2d_CCExtendSprite_create00(lua_State* tolua_S)
{
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
 {
  const char* pszFileName = ((const char*)  tolua_tostring(tolua_S,2,0));
  {
   CCExtendSprite* tolua_ret = (CCExtendSprite*)  CCExtendSprite::create(pszFileName);
    int nID = (tolua_ret) ? tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCExtendSprite");
  }
 }
 return 1;
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: check if the touch of CCExtendSprite is alpha*/
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCExtendSprite_isAlphaTouched00
static int tolua_Cocos2d_CCExtendSprite_isAlphaTouched00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isusertype(tolua_S,2,"CCPoint",0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCExtendSprite* self = (CCExtendSprite*)  tolua_tousertype(tolua_S,1,0);
  CCPoint nodePoint = *((CCPoint*)  tolua_tousertype(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'isAlphaTouched'", NULL);
#endif
  {
   bool tolua_ret = (bool)  self->isAlphaTouched(nodePoint);
   tolua_pushboolean(tolua_S, (bool)tolua_ret);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'isAlphaTouched'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: set the hue offset of CCExtendSprite*/
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCExtendSprite_setHueOffset00
static int tolua_Cocos2d_CCExtendSprite_setHueOffset00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
 tolua_Error tolua_err;
 if (
     !tolua_isusertype(tolua_S,1,"CCExtendSprite",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,3,&tolua_err)
 )
  goto tolua_lerror;
 else
#endif
 {
  CCExtendSprite* self = (CCExtendSprite*)  tolua_tousertype(tolua_S,1,0);
  int offset = ((int) tolua_tonumber(tolua_S,2,0));
#ifndef TOLUA_RELEASE
  if (!self) tolua_error(tolua_S,"invalid 'self' in function 'setHueOffset'", NULL);
#endif
  {
	  self->setHueOffset(offset);
  }
 }
 return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setHueOffset'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class CCTextInput */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCTextInput_create00
static int tolua_Cocos2d_CCTextInput_create00(lua_State* tolua_S)
{
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCTextInput",0,&tolua_err) ||
     !tolua_isstring(tolua_S,2,0,&tolua_err) ||
     !tolua_isstring(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isusertype(tolua_S,5,"const CCSize",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,6,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,7,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,8,&tolua_err)
 )
  goto tolua_lerror;
 else
 {
  const char* placeHolder = ((const char*)  tolua_tostring(tolua_S,2,0));
  const char* fontName = ((const char*)  tolua_tostring(tolua_S,3,0));
  float fontSize = (( float)  tolua_tonumber(tolua_S,4,0));
  const CCSize* size = ((const CCSize*)  tolua_tousertype(tolua_S,5,0));
  unsigned int limit = ((unsigned int)  tolua_tonumber(tolua_S,7,0));
  {
   CCTextInput* tolua_ret = (CCTextInput*)  CCTextInput::create(placeHolder, fontName, fontSize, *size, 0, limit);
    int nID = (tolua_ret) ? tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCTextInput");
  }
 }
 return 1;
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: create of class CCAlphaTo */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCAlphaTo_create00
static int tolua_Cocos2d_CCAlphaTo_create00(lua_State* tolua_S)
{
 tolua_Error tolua_err;
 if (
     !tolua_isusertable(tolua_S,1,"CCAlphaTo",0,&tolua_err) ||
     !tolua_isnumber(tolua_S,2,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,3,0,&tolua_err) ||
     !tolua_isnumber(tolua_S,4,0,&tolua_err) ||
     !tolua_isnoobj(tolua_S,5,&tolua_err)
 )
  goto tolua_lerror;
 else
 {
  float duration = ((float)  tolua_tonumber(tolua_S,2,0));
  unsigned char from = (( unsigned char)  tolua_tonumber(tolua_S,3,0));
  unsigned char to = (( unsigned char)  tolua_tonumber(tolua_S,4,0));
  {
   CCAlphaTo* tolua_ret = (CCAlphaTo*)  CCAlphaTo::create(duration, from, to);
    int nID = (tolua_ret) ? tolua_ret->m_uID : -1;
    int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
    toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCAlphaTo");
  }
 }
 return 1;
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
}
#endif //#ifndef TOLUA_DISABLE

/* method: createHttpRequest of class CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCHttpRequest_create00
static int tolua_Cocos2d_CCHttpRequest_create00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
	tolua_Error tolua_err;
	if (
		!tolua_isusertable(tolua_S, 1, "CCHttpRequest", 0, &tolua_err) ||
		!tolua_isfunction(tolua_S,2,&tolua_err)) ||
		!tolua_isstring(tolua_S,3,0,&tolua_err) ||
		!tolua_isboolean(tolua_S,4,1,&tolua_err) ||
		!tolua_isnoobj(tolua_S,5,&tolua_err)
	)
	 goto tolua_lerror;
	else
#endif
	{
		int funcID = (toluafix_ref_function(tolua_S,2,0));
		const char* url = ((const char*)  tolua_tostring(tolua_S,3,0));
		bool isGet = ((bool)  tolua_toboolean(tolua_S,4,true));
		{
			CCHttpRequest* tolua_ret = (CCHttpRequest *) CCHttpRequest::createWithUrlLua(funcID, url, isGet);
			int nID = (tolua_ret) ? tolua_ret->m_uID : -1;
			int* pLuaID = (tolua_ret) ? &tolua_ret->m_nLuaID : NULL;
			toluafix_pushusertype_ccobject(tolua_S, nID, pLuaID, (void*)tolua_ret,"CCHttpRequest");
		}
	}
	return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'create'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: addPostValue of class CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCHttpRequest_addPostValue00
static int tolua_Cocos2d_CCHttpRequest_addPostValue00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
	tolua_Error tolua_err;
	if(
		!tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
		!tolua_isstring(tolua_S,2,0,&tolua_err)||
		!tolua_isstring(tolua_S,3,0,&tolua_err) ||
		!tolua_isnoobj(tolua_S,4,&tolua_err)
	)
		goto tolua_lerror;
	else
#endif
	{
		CCHttpRequest* self = (CCHttpRequest*) tolua_tousertype(tolua_S,1,0);
		const char* key = ((const char *) tolua_tostring(tolua_S,2,0));
		const char* value = ((const char *) tolua_tostring(tolua_S,3,0));
		{
			self->addPostValue(key, value);
		}
	}
	return 0;
#ifndef TOLUA_RELEASE
tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'addPostValue'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: setTimeout of class CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCHttpRequest_setTimeout00
static int tolua_Cocos2d_CCHttpRequest_setTimeout00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
	tolua_Error tolua_err;
	if(
		!tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
		!tolua_isnumber(tolua_S,2,0,&tolua_err) ||
		!tolua_isnoobj(tolua_S,3,&tolua_err)
	)
		goto tolua_lerror;
	else
#endif
	{
		CCHttpRequest* self = (CCHttpRequest*) tolua_tousertype(tolua_S,1,0);
		float timeout = ((float) tolua_tonumber(tolua_S,2,0));
		{
			self->setTimeout(timeout);
		}
	}
	return 0;
#ifndef TOLUA_RELEASE
tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'setTimeout'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: start of class CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCHttpRequest_start00
static int tolua_Cocos2d_CCHttpRequest_start00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
	tolua_Error tolua_err;
	if(
		!tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
		!tolua_isboolean(tolua_S,2,0) ||
		!tolua_isnoobj(tolua_S,3,&tolua_err)
	)
		goto tolua_lerror;
	else
#endif
	{
		CCHttpRequest* self = (CCHttpRequest*) tolua_tousertype(tolua_S,1,0);
		bool isCached = ((bool) tolua_toboolean(tolua_S,2,false));
		{
			self->start(isCached);
		}
	}
	return 0;
#ifndef TOLUA_RELEASE
tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'start'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getResponseStatusCode of class CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCHttpRequest_getResponseStatusCode00
static int tolua_Cocos2d_CCHttpRequest_getResponseStatusCode00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
	tolua_Error tolua_err;
	if(
		!tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
		!tolua_isnoobj(tolua_S,2,&tolua_err)
	)
		goto tolua_lerror;
	else
#endif
	{
		CCHttpRequest* self = (CCHttpRequest*) tolua_tousertype(tolua_S,1,0);
		{
			int tolua_ret = self->getResponseStatusCode();
			tolua_pushnumber(tolua_S, (lua_Number)tolua_ret);
		}
	}
	return 1;
#ifndef TOLUA_RELEASE
tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getResponseStatusCode'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: getResponseString of class CCHttpRequest */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCHttpRequest_getResponseString00
static int tolua_Cocos2d_CCHttpRequest_getResponseString00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
	tolua_Error tolua_err;
	if(
		!tolua_isusertype(tolua_S,1,"CCHttpRequest",0,&tolua_err) ||
		!tolua_isnoobj(tolua_S,2,&tolua_err)
	)
		goto tolua_lerror;
	else
#endif
	{
		CCHttpRequest* self = (CCHttpRequest*) tolua_tousertype(tolua_S,1,0);
		{
			const char* tolua_ret = self->getResponseString();
			tolua_pushstring(tolua_S, (const char*)tolua_ret);
		}
	}
	return 1;
#ifndef TOLUA_RELEASE
tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'getResponseString'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE

/* method: md5encode of class CCCrypto */
#ifndef TOLUA_DISABLE_tolua_Cocos2d_CCCrypto_md5encode00
static int tolua_Cocos2d_CCCrypto_md5encode00(lua_State* tolua_S)
{
#ifndef TOLUA_RELEASE
	tolua_Error tolua_err;
	if (
		!tolua_isusertable(tolua_S, 1, "CCCrypto", 0, &tolua_err) ||
		!tolua_isstring(tolua_S,2,0,&tolua_err) ||
		!tolua_isnoobj(tolua_S,3,&tolua_err)
	)
	 goto tolua_lerror;
	else
#endif
	{
		const char* src = ((const char*)  tolua_tostring(tolua_S,2,0));
		{
			const char* tolua_ret = CCCrypto::md5encode(src);
			tolua_pushstring(tolua_S, (const char*)tolua_ret);
			delete[] tolua_ret;
		}
	}
	return 1;
#ifndef TOLUA_RELEASE
 tolua_lerror:
 tolua_error(tolua_S,"#ferror in function 'md5encode'.",&tolua_err);
 return 0;
#endif
}
#endif //#ifndef TOLUA_DISABLE


TOLUA_API int tolua_ext_reg_types(lua_State* tolua_S)
{
 tolua_usertype(tolua_S,"CCExtendNode");
 tolua_usertype(tolua_S,"CCExtendSprite");
 tolua_usertype(tolua_S,"CCTextInput");
 tolua_usertype(tolua_S,"CCAlphaTo");
 tolua_usertype(tolua_S,"CCHttpRequest");
 tolua_usertype(tolua_S,"CCCrypto");
 return 1;
}

TOLUA_API int tolua_ext_reg_modules(lua_State* tolua_S)
{
  tolua_cclass(tolua_S,"CCExtendNode","CCExtendNode","CCNode",NULL);
  tolua_beginmodule(tolua_S,"CCExtendNode");
   tolua_function(tolua_S, "create", tolua_Cocos2d_CCExtendNode_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCExtendSprite","CCExtendSprite","CCSprite",NULL);
  tolua_beginmodule(tolua_S,"CCExtendSprite");
   tolua_function(tolua_S, "isAlphaTouched", tolua_Cocos2d_CCExtendSprite_isAlphaTouched00);
   tolua_function(tolua_S, "setHueOffset", tolua_Cocos2d_CCExtendSprite_setHueOffset00);
   tolua_function(tolua_S, "create", tolua_Cocos2d_CCExtendSprite_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCTextInput", "CCTextInput", "CCTextFieldTTF", NULL);
  tolua_beginmodule(tolua_S, "CCTextInput");
   tolua_function(tolua_S, "create", tolua_Cocos2d_CCTextInput_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCAlphaTo","CCAlphaTo","CCActionInterval",NULL);
  tolua_beginmodule(tolua_S,"CCAlphaTo");
   tolua_function(tolua_S, "create", tolua_Cocos2d_CCAlphaTo_create00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCHttpRequest","CCHttpRequest","CCObject",NULL);
  tolua_beginmodule(tolua_S,"CCHttpRequest");
   tolua_function(tolua_S,"create", tolua_Cocos2d_CCHttpRequest_create00);
   tolua_function(tolua_S,"addPostValue", tolua_Cocos2d_CCHttpRequest_addPostValue00);
   tolua_function(tolua_S,"setTimeout", tolua_Cocos2d_CCHttpRequest_setTimeout00);
   tolua_function(tolua_S,"start", tolua_Cocos2d_CCHttpRequest_start00);
   tolua_function(tolua_S,"getResponseStatusCode", tolua_Cocos2d_CCHttpRequest_getResponseStatusCode00);
   tolua_function(tolua_S,"getResponseString", tolua_Cocos2d_CCHttpRequest_getResponseString00);
  tolua_endmodule(tolua_S);
  tolua_cclass(tolua_S,"CCCrypto","CCCrypto","",NULL);
  tolua_beginmodule(tolua_S, "CCCrypto");
   tolua_function(tolua_S,"md5encode", tolua_Cocos2d_CCCrypto_md5encode00);
  tolua_endmodule(tolua_S);
  return 1;
}