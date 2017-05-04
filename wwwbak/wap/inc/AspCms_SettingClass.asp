<!--#include file="../../inc/AspCms_MainClass.asp" -->
<%
if siteMode=0 then die siteHelp
dim LanguageAlias : LanguageAlias=""
dim pagemode: pagemode="wap"
dim setting : set setting=new SettingClass
%>
<!--#include file="../../inc/AspCms_Language.asp" -->