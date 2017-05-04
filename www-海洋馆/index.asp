<!--#include file="inc/AspCms_SettingClass.asp" -->
<%
if wapMode="1" then
if instr(Request.ServerVariables("http_accept"),"wap")>0 or instr(Request.ServerVariables("HTTP_USER_AGENT"),"iPhone")>0 or instr(Request.ServerVariables("HTTP_USER_AGENT"),"iPod")>0  or instr(Request.ServerVariables("HTTP_USER_AGENT"),"Android")>0  or instr(Request.ServerVariables("HTTP_USER_AGENT"),"ios")>0 or instr(Request.ServerVariables("HTTP_USER_AGENT"),"iPad")>0 then
    response.redirect("/wap/")
    response.end
end if
end if
if  runMode="0"  then
	dim templateobj,templatePath : set templateobj = new TemplateClass
	wap=""
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/index.html"	
	
	if not CheckTemplateFile(templatePath) then echo "index.html"&err_16	
	with templateObj 
		.content=loadFile(templatePath) 
		.parseHtml()
		.indexpath
		.parseCommon
		echo ClearHtml(.content)
	end with	
	set templateobj =nothing : terminateAllObjects
Else
	On Error Resume Next
	Server.Transfer(sitePath&setting.languagepath&"index"&FileExt)
	If -2147467259 = Err.Number Then Response.Charset="gbk":Response.Write "缺少首页文件，请登录后台生成首页文件！"	
end if
If DebugMode Then echo timer - AppSpan 
%>