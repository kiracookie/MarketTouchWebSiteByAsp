<!--#include file="AspCms_artUrlFun.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�����ؼ��ʼ�����</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
</HEAD>
<BODY>
<FORM name="form" action="?action=add" method="post" >
  <DIV class=formzone>
    <DIV class=namezone>��ӹؼ���</DIV>
    <DIV class=tablezone>
      <DIV class=noticediv id=notice></DIV>
      <TABLE cellSpacing=0 cellPadding=2 width="100%" align=center border=0>
        <TBODY>
          <TR>
            <TD align=middle width=100 height=30>�ؼ���</TD>
            <TD><INPUT class="input" style="WIDTH: 150px" maxLength="200" name="LinkText"/>
              <FONT color=#ff0000>*</FONT></TD>
          </TR>
          <TR>
            <TD align=middle width=100 height=30>���ӵ�ַ</TD>
            <TD><INPUT class="input" style="WIDTH: 150px" maxLength="200" name="LinkUrl"/>
              <FONT color=#ff0000>*</FONT>(�������ʱ�����http://)</TD>
          </TR>
          <TR>
            <TD align=middle width=100 height=30>���̷���</TD>
            <TD><input type="checkbox"  checked="checked" value="1" name="LinkStatus"/></TD>
          </TR>
          <TR>
        </TBODY>
      </TABLE>
    </DIV>
    <DIV class=adminsubmit>
      <INPUT class="button" type="submit" value="���" />
      <INPUT class="button" type="button" value="����" onClick="history.go(-1)"/>
    </DIV>
  </DIV>
</FORM>
</BODY>
</HTML>