<!--#include file="inc/AspCms_SettingClass.asp" -->
<%CheckLogin()%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<title>Home</title>
<link href="css/css_body.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/jquery.js"></script>
<script type="text/javascript">
	$(function(){
		if($("#version").text().replace(" ","")==""){
			$("#version").text("��������ʧ��");
		}
		if($("#developer").text().replace(" ","")==""){
			$("#developer").text("��������ʧ��");
		}
		if($("#developer").text().replace(" ","")=="��Դ��Ѱ�"){
			$("#developer").html("��Դ��Ѱ� <a href='http://www.aspcms.com/aspcms-3996-1-1.html' style='text-decoration:underline;' target='_blank'>��Ȩ����</a>��<a href='http://www.aspcms.com/aspcms-29177-1-1.html' style='text-decoration:underline;' target='_blank'>������Ȩ</a>");
		}
	})
</script>
</script>
</head>

<body>
<%
if "admin"=lcase(getAdminDir) then 
%>
<div class="bodytitle">
	<div class="bodytitleleft"></div>
	<div class="bodytitletxt">��ȫ��ʾ</div>
</div>
<div class="tab_bk1">
	<div class="txtbox1">
		<p class="red">���ĺ�̨����Ŀ¼ΪĬ��Ŀ¼������ʹ��ftp����������ʽ����̨Ŀ¼������</p>
	</div>
</div>
<%end if%>
<div class="bodytitle">
	<div class="bodytitleleft"></div>
	<div class="bodytitletxt">��վͳ��</div>
</div>
<div class="tab_bk1">
	<div class="txtbox1">
		<p>���� <strong class="red"><%=getTodayVisits%></strong> �� ������ <strong class="red"><%=getYesterdayVisits%></strong> �� ������ <strong class="red"><%=getMonthVisits%></strong> �� ���ܷ��� <strong class="red"><%=getAllVisits%></strong> �ˡ�</p>
	</div>
</div>
<div class="bodytitle">
	<div class="bodytitleleft"></div>
	<div class="bodytitletxt">����������</div>
</div>
<div class="tab_bk1">
	<div class="txtbox1">
		<p>
        <a href="_content/_Comments/AspCms_Message.asp">δ�ش�����</a>��<%=getDataCount("select Count(*) from {prefix}GuestBook where faqStatus=0")%>��<small>|</small> 
        <a href="_content/_Order/AspCms_Order.asp">δ������</a>��<%=getDataCount("select Count(*) from {prefix}Order2 where state=0")%>��<small>|</small> 
        <a href="_content/_Comments/AspCms_Comments.asp">δ��������</a>��<%=getDataCount("select Count(*) from {prefix}Comments where CommentStatus=0")%>��<small>|</small> 
        <a href="_content/_Apply/AspCms_Apply.asp">δ����ӦƸ</a>��<%=getDataCount("select Count(*) from {prefix}Apply where ApplyStatus=0")%>��<small>|</small> 
        </p>
	</div>
</div>






<%
dim host
host = request.ServerVariables("HTTP_HOST")
%>
<script type="text/javascript" src='http://iiii.aspcms.com/deveplor.asp?url=<%=host%>'></script>
<script type="text/javascript" src='http://iiii.aspcms.com/version.asp?ver=<%=currentversion%>&url=<%=host%>'></script>
</body>
</html>