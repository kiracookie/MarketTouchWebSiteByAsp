<!--#include file="md5.asp" -->
<%
On Error Resume Next 
Server.ScriptTimeOut=9999999 
Function getHTTPPage(Path) 
t = GetBody(Path) 
getHTTPPage=BytesToBstr(t,"GB2312") 
End function 
Function Newstring(wstr,strng) 
Newstring=Instr(lcase(wstr),lcase(strng)) 
if Newstring<=0 then Newstring=Len(wstr) 
End Function 
Function BytesToBstr(body,Cset) 
dim objstream 
set objstream = Server.CreateObject("adodb.stream") 
objstream.Type = 1 
objstream.Mode =3 
objstream.Open 
objstream.Write body 
objstream.Position = 0 
objstream.Type = 2 
objstream.Charset = Cset 
BytesToBstr = objstream.ReadText 
objstream.Close 
set objstream = nothing 
End Function 
Function GetBody(url) 
on error resume next 
Set Retrieval = CreateObject("Microsoft.XMLHTTP") 
With Retrieval 
.Open "Get", url, False, "", "" 
.Send 
GetBody = .ResponseBody 
End With 
Set Retrieval = Nothing 
End Function 

'ASP��ȡԶ����ҳָ�����ݿ�ʼ 
Dim wstr,str,url,start,over,dtime
dim hostname:hostname=Request.ServerVariables("SERVER_NAME")
dim key:key=md5(hostname&"Gk8MKsRs",32)
url="http://wss.cnzz.com/user/companion/aspcms.php?domain="&hostname&"&key="&key&""
wstr=trim(getHTTPPage(url))
response.write wstr '�����ȡ������ҳ���� 
'ASP��ȡԶ����ҳָ�����ݽ��� 
%> 