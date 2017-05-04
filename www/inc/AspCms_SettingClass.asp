<!--#include file="AspCms_MainClass.asp" -->
<%
if siteMode=0 then die siteHelp
dim LanguageAlias : LanguageAlias=""
dim lg:lg=Trim(getForm("lg","get"))
if not isnul(lg) then
	dim lgObj:set lgObj=conn.exec("select * from {prefix}Language where Alias='"&lg&"'","exe")
	if not lgObj.eof then 
		 wCookie "LanguageAlias",lg
	else
		alertMsgAndGo "网站没有添加这个语言！",sitePath&"/"
	end if
	lgObj.close : set lgObj=nothing
end if
if rCookie("LanguageAlias")<>"" then LanguageAlias = rCookie("LanguageAlias")
dim pagemode: pagemode="":checkMode()
dim setting : set setting=new SettingClass
%>
<!--#include file="AspCms_Language.asp" -->