<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
dim ContentID,SortAndID,qs

SortAndID=split(replaceStr(request.QueryString,FileExt,""),"_")
if isNul(replaceStr(request.QueryString,FileExt,"")) then  echoMsgAndGo "�������ݲ�����",-1 
ContentID=SortAndID(0)
if not isNul(ContentID) and isNum(ContentID) then ContentID=clng(ContentID) else echoMsgAndGo "�������ݲ�����",-1 end if

dim rsObj


set rsobj=conn.exec("select ContentID,DownURL,DownGroupID,Exclusive from {prefix}Content  where  ContentStatus=1 and TimeStatus=0 and ContentID="&ContentID, "exe")
if rsObj.eof then echoMsgAndGo "�������ݲ�����",-1


if isnul(rsObj("DownURL")) then echoMsgAndGo "�������ݲ�����",-1

if rsObj("DownGroupID")=2 then 
Response.Redirect(rsObj("DownURL"))
end if


if ViewNoRight(rsObj("DownGroupID"),rsObj("Exclusive")) then
Response.Redirect(rsObj("DownURL"))
else
echoErr err_17,"17",err_17
response.end()
end if

If DebugMode Then echo timer - AppSpan
%>