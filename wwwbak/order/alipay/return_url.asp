<!--#include file="../../inc/AspCms_SettingClass.asp" -->

<html>
<head>
<%="<title>֧������ʱ���˽��׽ӿ�</title"%>
	<META http-equiv=Content-Type content="text/html; charset=gb2312">
	</head>
<body>
<%
' ���ܣ�֧����ҳ����תͬ��֪ͨҳ��
' �汾��3.3
' ���ڣ�2012-07-17
' ˵����
' ���´���ֻ��Ϊ�˷����̻����Զ��ṩ���������룬�̻����Ը����Լ���վ����Ҫ�����ռ����ĵ���д,����һ��Ҫʹ�øô��롣
' �ô������ѧϰ���о�֧�����ӿ�ʹ�ã�ֻ���ṩһ���ο���
	
' //////////////ҳ�湦��˵��//////////////
' ��ҳ����ڱ������Բ���
' �ɷ���HTML������ҳ��Ĵ��롢�̻�ҵ���߼��������
' ��ҳ�����ʹ��ASP�������ߵ��ԣ�Ҳ����ʹ��д�ı�����LogResult���е��ԣ��ú����ѱ�Ĭ�Ϲرգ���alipay_notify.asp�еĺ���VerifyReturn
' ���ýӿڵ�ע��������û����ô����ɾ������
'////////////////////////////////////////
%>

<!--#include file="class/alipay_notify.asp"-->

<%
dim objNotify,sVerifyResult,out_trade_no,trade_no,trade_status
'����ó�֪ͨ��֤���
Set objNotify = New AlipayNotify
sVerifyResult = objNotify.VerifyReturn()

If sVerifyResult Then	'��֤�ɹ�
	'*********************************************************************
	'������������̻���ҵ���߼��������
	
	'�������������ҵ���߼�����д�������´�������ο�������
    '��ȡ֧������֪ͨ���ز������ɲο������ĵ���ҳ����תͬ��֪ͨ�����б�

	'�̻�������
	out_trade_no = Request.QueryString("out_trade_no")

	'֧�������׺�
	trade_no = Request.QueryString("trade_no")

	'����״̬
	trade_status = Request.QueryString("trade_status")

	
	If Request.QueryString("trade_status") = "TRADE_FINISHED" or Request.QueryString("trade_status") = "TRADE_SUCCESS" Then
	'�ж��Ƿ����̻���վ���Ѿ����������֪ͨ���صĴ���
		'���û������������ôִ���̻���ҵ�����
		'���������������ô��ִ���̻���ҵ�����
		dim s,sql',orderno

		'orderno = getForm("orderno","get")
		's = getForm("s","get")

		sql = "update {prefix}Order2 set [pay] = 1,alipayID='"&trade_no&"' where orderno='"&out_trade_no&"'"
		call conn.exec(sql,"exe")
		
	Else
		Response.Write "trade_status="&Request.QueryString("trade_status")
	End If

	Response.Write "��֤�ɹ�<br>"

	'�������������ҵ���߼�����д�������ϴ�������ο�������
	
	'*********************************************************************
else '��֤ʧ��
    '��Ҫ���ԣ��뿴alipay_notify.aspҳ���VerifyReturn�������ȶ�sign��mysign��ֵ�Ƿ���ȣ����߼��responseTxt��û�з���true
    response.Write "��֤ʧ��"
end if
%>


</body>
</html>
