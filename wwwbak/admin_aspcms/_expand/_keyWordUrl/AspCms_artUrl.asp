<!--#include file="AspCms_artUrlFun.asp" -->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML xmlns="http://www.w3.org/1999/xhtml">
<HEAD>
<TITLE>�ؼ��ʼ�����</TITLE>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<LINK href="../../images/style.css" type=text/css rel=stylesheet>
</HEAD>
<SCRIPT>
function SelAll(theForm){
		for ( i = 0 ; i < theForm.elements.length ; i ++ )
		{
			if ( theForm.elements[i].type == "checkbox" && theForm.elements[i].name != "SELALL" )
			{
				theForm.elements[i].checked = ! theForm.elements[i].checked ;
			}
		}
}
</SCRIPT>
<BODY>
<DIV class=searchzone>
  <TABLE height=30 cellSpacing=0 cellPadding=0 width="100%" border=0>
    <TBODY>
      <TR>
        <TD height=30>&nbsp;</TD>
        <TD align=right colSpan=2><INPUT onClick="location.href='AspCms_artUrlAdd.asp'" type="button" value="��ӹؼ���" class="button" >
          <INPUT onClick="location.href='<%=getPageName()%>'" type="button" value="ˢ��" class="button" /></TD>
      </TR>
    </TBODY>
  </TABLE>
</DIV>
<FORM name="" action="" method="post">
  <DIV class=listzone>
    <TABLE cellSpacing=0 cellPadding=3 width="100%" align=center border=0>
      <TBODY>
        <TR class=list>
          <TD width="16%" class=biaoti>ѡ��</TD>
          <TD width="16%" class=biaoti>���</TD>
          <TD width="16%" class=biaoti><span class="searchzone">�ؼ���</span></TD>
          <TD width="16%" class=biaoti ><span class="searchzone">���ӵ�ַ</span></TD>
          <TD width="16%" class=biaoti ><span class="searchzone">״̬</span></TD>
          <TD width="16%" class=biaoti ><span class="searchzone">����</span></TD>
        </TR>
        <%KeyList%>
      </TBODY>
    </TABLE>
  </DIV>
  <DIV class=piliang>
    <INPUT onClick="SelAll(this.form)" type="checkbox" value="1" name="SELALL">
    ȫѡ&nbsp;
    <INPUT class="button" type="submit" value="ɾ��" onClick="if(confirm('ȷ��Ҫɾ����')){form.action='?action=del';}else{return false};"/>
    <INPUT class="button" type="submit" value="����" onClick="form.action='?action=off';"./>
    <INPUT class="button" type="submit" value="����" onClick="form.action='?action=on';"/>
  </DIV>
</FORM>
</BODY>
</HTML>
