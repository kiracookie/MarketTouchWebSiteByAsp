<!--#include file="../inc/AspCms_SettingClass.asp" -->
<%
'if session("userID")="" then
'alertMsgAndGo "����δ��½�����¼��","../member/login.asp"
'end if
dim action,needCheck
action=getForm("act","both")
needCheck = false

Select Case LCase(action)	
	Case "buy"                                        '�ύ����
		addOrder()
	Case "comfirm"							'2����ȷ��
		OrderComfirm()
	Case "complete"												'3�ɹ��µ�
		OrderComplete()
	Case "echo"					'1��д��Ϣ
		echoContent()
	case "directbuy"	'0ֱ�ӹ���
		DirectBuy()
	case "print"                                              				'4��ӡ����
		OrderPrint()
	Case Else
		echoContent()     
End Select  





Sub OrderComplete		
dim id, sortID,SortAndID
	dim qs
	'qs = Session("Cart_QS")
	'SortAndID=split(replaceStr(qs,FileExt,""),"_")
	
	'if isNul(replaceStr(qs,FileExt,"")) then  echoMsgAndGo "ҳ�治����1",3 
	'SortID = SortAndID(0)
	'if not isNul(SortID) and isNum(SortID) then SortID=clng(SortID) else echoMsgAndGo "ҳ�治����2",3 end if
	'id=SortAndID(1)
	'if not isNul(id) and isNum(id) then id=clng(id) else echoMsgAndGo "ҳ�治����3",3 end if
	
	'if isnul(id) or not isnum(id) then alertMsgAndGo "��ѡ���Ʒ1��","-1" 
	'if isnul(sortID) or not isnum(sortID) then alertMsgAndGo "��ѡ���Ʒ2��","-1" 
	
	dim templateobj,channelTemplatePath : set templateobj = new TemplateClass	
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/productcomfirm.html"
	if not CheckTemplateFile(templatePath) then echo "productcomfirm.html"&err_16
	
	'set rsObj=conn.exec("select * from {prefix}Sort where SortID="&sortID, "exe")							
	'if rsObj.eof then echoMsgAndGo "ҳ�治����4",3 : exit sub		
	with templateObj 
	
		.content=loadFile(templatePath)	
		.parseHtml()
		.indexpath()
'templateObj.content=replace(templateObj.content,"{aspcms:sortname}",rsObj("SortName"))
'templateObj.content=replace(templateObj.content,"{aspcms:parentsortid}",rsObj("parentid"))		
'templateObj.content=replace(templateObj.content,"{aspcms:sortid}",sortID)	
'templateObj.content=replace(templateObj.content,"{aspcms:topsortid}",rsObj("topsortid"))
		
		
templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",setting.siteKeyWords)	
templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",setting.sitedesc)
'templateObj.content=replace(templateObj.content,"{aspcms:sorttitle}",rsObj("SortName"))	
		
		'templateObj.parsePosition(sortID)			
		'rsObj.close()
		
dim hidden


'������������ {aspcms:order.$trigger$}
templateObj.content=replace(templateObj.content,"{aspcms:order.$trigger$}",hidden)

'�������룺{aspcms:order.no} 
templateObj.content=replace(templateObj.content,"{aspcms:order.no}",Session("Print.Orderno"))
'�������ڣ�{aspcms:order.date} 
templateObj.content=replace(templateObj.content,"{aspcms:order.date}",Session("Print.OrderDate"))
'�� �� ����{aspcms:order.username} 
templateObj.content=replace(templateObj.content,"{aspcms:order.username}",Session("Print.OrderUserName"))
'����״̬��{aspcms:order.state} 
templateObj.content=replace(templateObj.content,"{aspcms:order.state}","δ����(�ɹ��µ�)")
'�����ܽ�{aspcms:order.total}Ԫ 
templateObj.content=replace(templateObj.content,"{aspcms:order.total}",Session("Print.OrderTotal"))
'��Ʒ��������{aspcms:order.count} 	
templateObj.content=replace(templateObj.content,"{aspcms:order.count}",Session("Print.OrderCount"))
'�ͻ�������{aspcms:order.nicename}
templateObj.content=replace(templateObj.content,"{aspcms:order.nicename}",Session("Print.OrderNiceName"))
'��ϵ�绰��{aspcms:order.tel}
templateObj.content=replace(templateObj.content,"{aspcms:order.tel}",Session("Print.OrderTel"))
'�ֻ����룺{aspcms:order.cellphone}
templateObj.content=replace(templateObj.content,"{aspcms:order.cellphone}",Session("Print.OrderCellphone"))
'�������룺{aspcms:order.zipcode}
templateObj.content=replace(templateObj.content,"{aspcms:order.zipcode}",Session("Print.OrderZipcode"))
'��ϵ��ַ��{aspcms:order.address}


templateObj.content=replace(templateObj.content,"{aspcms:order.address}",Session("Print.OrderAddress"))
'�������䣺{aspcms:order.email}
templateObj.content=replace(templateObj.content,"{aspcms:order.email}",Session("Print.OrderEmail"))
'�����ԣ�{aspcms:order.note}
templateObj.content=replace(templateObj.content,"{aspcms:order.note}",Session("Print.OrderNote"))
'֧����ʽ
templateObj.content=replace(templateObj.content,"{aspcms:order.payment}",Session("Print.OrderPayMent"))

select case Session("Print.OrderPayMent")
	case "����֧��"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Online)
	case "����֧��"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Bank)
	case "�ʾָ���"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_PostOffice)
end select


'��Ʒ�б�
templateObj.content=replace(templateObj.content,"{aspcms:selectproduct}",SelectProductList)
 

		.parseCommon() 		
		echo .content 
	end with
	
	set templateobj =nothing : terminateAllObjects
	
End Sub

'=======================================
'ֱ�ӹ���
'=======================================
Sub DirectBuy
Dim dicCount,dicPrice
Dim proid,count,proprice
Session.Contents.Remove("Cart")
Session.Contents.Remove("Cart.")
Session.Contents.Remove("Cart.Price")
End Sub


'=======================================
'������Ϣ��д
'=======================================
Sub echoContent()
	dim total
	
	dim templateobj,channelTemplatePath : set templateobj = new TemplateClass	
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/productcheckout.html"
	if not CheckTemplateFile(templatePath) then echo "productcheckout.html"&err_16
		Session.Contents.Remove("Print.Orderno")
	with templateObj 
		.content=loadFile(templatePath)	
		.parseHtml()
		.indexpath()
		templateObj.content=replace(templateObj.content,"{aspcms:topsortid}",0)
		templateObj.content=replace(templateObj.content,"{aspcms:sortid}",0)

			templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",setting.siteKeyWords)	

			templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",setting.sitedesc)
	Dim m_username,gender
	if session("loginstatus")="" then  session("loginstatus")="0"

	if session("loginstatus")="1" then  
		set rsObj=conn.Exec("select * from {prefix}User where UserID="&trim(session("userID")),"r1")
		m_username = rsObj("loginname")
	else 
		gender=1
	end if
		
		.content=replaceStr(.content,"{aspcms:selectproduct}",SelectProductList)
		randomize 		
		.content=replaceStr(.content,"{aspcms:order.orderno}",Year(Now)&MOnth(Now)&Day(Now)&Int(10000000*   Rnd))
		.content=replaceStr(.content,"{aspcms:order.username}",m_username)
		.content=replaceStr(.content,"{aspcms:order.total}",session("total"))
		.parseCommon() 
		echo .content 
	end with
	set templateobj =nothing : terminateAllObjects
End Sub


'=======================================
'��Ӷ���
'=======================================
Sub addOrder

if needCheck then
if getForm("code","post")<>Session("Code") then alertMsgAndGo "��֤�벻��ȷ","-1"
end if


dim orderno, username,  m_state, payment, nicename, tel,cellphone, zipcode, address, email, note, m_to, invoice,addtime,province,city,area,pname,post,mobile,phone
dim sql
 
	orderno=filterPara(getForm("orderid","post"))	
	
	username=session("loginName") 'filterPara(getForm("username","post"))	
	m_state=0
	
	pname=filterPara(getForm("pname","post"))	
	province=filterPara(getForm("province","post"))	
	city=filterPara(getForm("city","post"))	
	area=filterPara(getForm("area","post"))
	address=filterPara(getForm("address","post"))	
	
	post=filterPara(getForm("post","post"))
	mobile=filterPara(getForm("mobile","post"))
	phone=filterPara(getForm("phone","post"))	
	'email=filterPara(getForm("email","post"))
	'm_to=filterPara(getForm("to","post"))	
	note=filterPara(getForm("note","post"))	
	'invoice=filterPara(getForm("invoice","post"))
	'payment=filterPara(getForm("payment","post"))
	 
	addtime = now
	if isnul(orderno) then alertMsgAndGo "������Ϊ��?�������ύ��","-1"	
		if username = "" then username = "�ο�"
	dim userid        : userid=session("userID")
if session("norefresh") <> orderno then
	if isnul(userid) then 	userid=0
		
	sql = "INSERT INTO {prefix}order2( orderno, username, ordertime, state,nicename, province,city,area,address,zipcode, mobile, phone, [note], userid,Invoice)VALUES('"&orderno&"', '"&username&"',now(), "&m_state&", '"&pname&"', '"&province&"', '"&city&"', '"&area&"', '"&address&"', '"&post&"', '"&mobile&"', '"&phone&"','"&note&"', "&userid&",0)"
	
	Conn.Exec sql,"exe"		
	session("norefresh") = orderno
	Session("Print.OrderNo")=orderno
	Session("Print.OrderNiceName")=pname
	Session("Print.OrderTel")=phone
	Session("Print.OrderCellphone")=mobile
	Session("Print.OrderZipcode")=post
	Session("Print.OrderAddress")=province&city&area&address
	Session("Print.OrderNote")=note
	
	
	dim dic,md,dicPrice,mds,rdic,rmd
	Set dic = Session("Cart")
	Set dicPrice=Session("Cart.Price")
	for each md in dic
		
		'dim prices:prices=0
		 'prices=dicPrice(md)
		 'die prices
		'if isnul(prices) then  prices=0 
		
		'sql = "insert into {prefix}OrderProduct (orderno,productid,[count],instantprice) values ('"&orderno&"',"&md&","&dic(md)&",(select P_Price from content where contentid="&dic(md)&"))"
		
		'sql = "insert into {prefix}OrderProduct (orderno,productid,[count],instantprice) select '"&orderno&"',"&md&","&dic(md)&", P_Price from {prefix}content where contentid="&md
		
        rmd=filterPara(md)
		rdic=filterPara(dic(md))
		
		sql = "insert into {prefix}OrderProduct (orderno,productid,[count],instantprice) select '"&orderno&"',"&rmd&","&rdic&", P_Price from {prefix}content where contentid="&rmd
		
		
		conn.exec sql,"exe"
		'echo sql & "<br>"
		'sql = "update {prefix}content set P_sales=cast(P_sales as int)+"&dic(md)&"where contentid="&md
		
		
		'conn.exec sql,"exe"
		
	next	
	
		if orderReminded then sendMail messageAlertsEmail,setting.sitetitle,setting.siteTitle&setting.siteUrl&"--������Ϣ�����ʼ���","������վ<a href=""http://"&setting.siteUrl&""">"&setting.siteTitle&"</a>���µĶ�����Ϣ��<br>������ţ�"&orderno&"<br>��Ա�ʺţ�"&username&"<br>��ϵ�ˣ�"&nicename&"<br>�绰���룺"&tel&"<br>�ֻ����룺"&cellphone&"<br>�������䣺"&Email&"<br>��ע��"&note&"<br>����ʱ�䣺"&addtime
'else
 'alertMsgAndGo "�ö����Ѿ��ύ�������ظ��ύ�� ","-1"

end if
	
	
	
	
	

	
	'alertMsgAndGo "��Ʒ�����ɹ���","?act=complete"
	OrderComplete()
	'if Session("Cart_QS") <> "" then Session.Contents.Remove("Cart_QS")
	'Session.Contents.Remove("norefresh")
End Sub



'=======================================
'������ϸ�б�
'=======================================
Function SelectProductList
Dim dic,md
Dim rs,sql
Dim result,total,tcount,pcount


result="<div class='detail-content' > "&vbcrlf&_
"<table class='offer-list-table' cellSpacing='0' cellPadding='0' >"&vbcrlf&_
"<colgroup><col class='col-name' /><col class='col-price-unit' /><col class='col-amount' /><col class='col-promo' /><col class='col-price-total' /><col class='col-freight' /></colgroup>"&vbcrlf&_
"<thead><tr class='thead'><th>��Ʒ</th><th>���ۣ�Ԫ��</th><th>����</th><th>�Żݣ�Ԫ��</th><th>��Ԫ��</th><th>�˷ѣ�Ԫ��</th></tr></thead> "&vbcrlf&_
"<tbody > "

tcount = 0
pcount=0

If Not IsEmpty(Session("Cart")) Then
	Set dic = Session("Cart")
	For Each md In dic

		dim proid : proid=md
		sql = "select P_Price,IndexImage,title,contentid from {prefix}Content where contentid=" & proid
		Set rs = GetRS(sql)
		dim img
		if rs("IndexImage") = "" then
img="../Images/nopic.gif"
else
img=rs("IndexImage")
end if
		
result = result &"<tr class='item' ><td ><dl class='cell-thumbnail' ><dt><a title='"&rs("title")&"' class='a-img' href='#'><img width='64' height='64' alt='"&rs("title")&"' src='"&img&"' /></a> </dt>"&vbcrlf&_
"<dd class='offer-title'><a title='"&rs("title")&"' href='../content/?"&rs("contentid")&".html' target='_blank'>"&rs("title")&"</a> </dd>"&vbcrlf&_
"<dd class='offer-sku'><span class='sku-item '>�Զ��������  </span><span class='sku-item sku-item-last'> </span></dd></dl></td>"&vbcrlf&_
"<td ><div class='price-unit-ct'><span  class='price-unit'>"&rs("P_Price")&"</span></div></td>"&vbcrlf&_
"<td ><div class='amount'>"&dic(md)&"</div></td>"&vbcrlf&_
"<td ><div class='promo' >-- </div></td><td ><div class='price-total'>"&dic(md) * rs("P_Price")&"</div></td>"
if pcount=0 then
result = result &"<td class='td-freight rowspan' rowSpan='{allnumpro}' ><div class='freight'  >���� </div></td></tr>"
end if

total = total + (dic(md) * rs("P_Price"))
tcount = tcount + dic(md)
pcount = pcount + 1
rs.close:set rs = nothing
	Next
	
End If

result=replace(result,"{allnumpro}",pcount)
Session("Print.Ordertotal")=total

result=result&"</tbody></table></div> "&vbcrlf&_
"<div class='fd-clr shop detail-footer'>"&vbcrlf&_
"<div class='shop-info fd-left'>"&vbcrlf&_
"<dl><dt class='label'>���������ԣ�</dt><dd class='message'><div><textarea name='note' class='input' data-error='' >"&Session("Print.OrderNote")&"</textarea>"&vbcrlf&_
"<p class='word-count fd-hide'><span class='stress realtime'>0</span>/500</p></div></dd></dl></div> "&vbcrlf&_
"<div class='shop-price fd-right'>"&vbcrlf&_
"<input name='_fm.o._0.p' class='value-orderbundle' type='hidden' />"&vbcrlf&_
"<ul class='total-stat-list'> "&vbcrlf&_
"<li class='product-total'><span class='label'>��Ʒ�ܽ�</span> <em class='fd-bold product-total-value'>"&total&"</em>Ԫ</li> "&vbcrlf&_
"<li class='shop-promotion-info fd-hide'><span class='label'>��Żݣ�</span> <em class='fd-bold shoppromo-value price-value'>0.00</em>Ԫ</li> "&vbcrlf&_
"<li class='freight-total'><span class='label'>�˷ѹ��ƣ�</span> <em class='fd-bold freight-value'>0.00</em>Ԫ</li> "&vbcrlf&_
"<li class='sep cope-total'><input name='_fm.o._0.to' class='value-copetotal' type='hidden' value='170.00' /> <span class='b-font label'>Ӧ���ܶ���˷ѣ���</span> <em class='stress cope-value'>"&total&"</em>Ԫ</li> "&vbcrlf&_
"<li class='img-vcode-ct'></li> "&vbcrlf
if not isnul(Session("Print.Orderno")) then
result=result&"<li class='zone-submit'> <a href='/order/alipay/alipayapi.asp'><img width=160 src='/images/alipay.png' /></a></li>"&vbcrlf&_
"</ul></div></div>"
else
result=result&"<li class='zone-submit'><a title='���ع��ﳵ' class='to-cart' id='back-to-purchase' href='/order/' data-needfocus='ddxx_backjhd_j' data-tracelog='ddxx_backjhd' >���ع��ﳵ</a> <a class='button button-important button-large order-submit-btn' href='javascript:void(0)'>�ύ����</a></li>"&vbcrlf&_
"</ul></div></div>"
end if






'"</tbody></table></div>"&vbcrlf&_
'"<div class='footer'><div class='container'>"&vbcrlf&_
'"<span class='total-amount' >�����ܼƣ�<em id='allcount'>"&tcount&"</em>��</span> <span class='total-price'>��Ʒ����ܼ�(�������˷�)��<em id='alltotal'>"&total&"</em>Ԫ</span>"&vbcrlf&_
'"<a class='button-submit button button-important button-large' href='checkout.asp' >ȷ���µ�</a></div>"&vbcrlf&_
'"</div></div>"&vbcrlf

	SelectProductList = result
End Function
'=======================================
'��Ӷ���
'=======================================
Function GetRS(sql)

On Error Resume Next
Set GetRS = conn.exec(sql,"r1")
If Err Then
	'echo sql
	'die err.description
	die "���󣬱�ṹ�������°汾"
End If
End Function



'=======================================
'������ӡ
'=======================================
Sub OrderPrint
if needCheck then
if getForm("code","post")<>Session("Code") then alertMsgAndGo "��֤�벻��ȷ","-1"
end if
dim sql		
dim id, sortID,SortAndID
	dim qs
	'qs = Session("Cart_QS")
	'SortAndID=split(replaceStr(qs,FileExt,""),"_")
	
	'if isNul(replaceStr(qs,FileExt,"")) then  echoMsgAndGo "ҳ�治����",3 
	SortID = SortAndID(0)
	if not isNul(SortID) and isNum(SortID) then SortID=clng(SortID) else echoMsgAndGo "ҳ�治����",3 end if
	id=SortAndID(1)
	if not isNul(id) and isNum(id) then id=clng(id) else echoMsgAndGo "ҳ�治����",3 end if
	
	if isnul(id) or not isnum(id) then alertMsgAndGo "��ѡ���Ʒ��","-1" 
	if isnul(sortID) or not isnum(sortID) then alertMsgAndGo "��ѡ���Ʒ��","-1" 
	
	dim templateobj,channelTemplatePath : set templateobj = new TemplateClass	
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/productprint.html"
	if not CheckTemplateFile(templatePath) then echo "productprint.html"&err_16
	
	set rsObj=conn.exec("select * from {prefix}Sort where SortID="&sortID, "exe")							
	if rsObj.eof then echoMsgAndGo "ҳ�治����",3 : exit sub		
	with templateObj 
	
		.content=loadFile(templatePath)	
		.parseHtml()
		.indexpath()


'�������룺{aspcms:order.no} 
templateObj.content=replace(templateObj.content,"{aspcms:order.no}",Session("Print.OrderNo"))
'�������ڣ�{aspcms:order.date} 
templateObj.content=replace(templateObj.content,"{aspcms:order.date}",Session("Print.OrderDate"))
'�� �� ����{aspcms:order.username} 
templateObj.content=replace(templateObj.content,"{aspcms:order.username}",Session("Print.OrderUserName"))
'����״̬��{aspcms:order.state} 
templateObj.content=replace(templateObj.content,"{aspcms:order.state}",Session("Print.OrderState"))
'�����ܽ�{aspcms:order.total}Ԫ 
templateObj.content=replace(templateObj.content,"{aspcms:order.total}",Session("Print.OrderTotal"))
'��Ʒ��������{aspcms:order.count} 	
templateObj.content=replace(templateObj.content,"{aspcms:order.count}",Session("Print.OrderCount"))
'�ͻ�������{aspcms:order.nicename}
templateObj.content=replace(templateObj.content,"{aspcms:order.nicename}",Session("Print.OrderNiceName"))
'��ϵ�绰��{aspcms:order.tel}
templateObj.content=replace(templateObj.content,"{aspcms:order.tel}",Session("Print.OrderTel"))
'�ֻ����룺{aspcms:order.cellphone}
templateObj.content=replace(templateObj.content,"{aspcms:order.cellphone}",Session("Print.OrderCellphone"))
'�������룺{aspcms:order.zipcode}
templateObj.content=replace(templateObj.content,"{aspcms:order.zipcode}",Session("Print.OrderZipcode"))
'��ϵ��ַ��{aspcms:order.address}
templateObj.content=replace(templateObj.content,"{aspcms:order.address}",Session("Print.OrderAddress"))
'�������䣺{aspcms:order.email}
templateObj.content=replace(templateObj.content,"{aspcms:order.email}",Session("Print.OrderEmail"))
'�����ԣ�{aspcms:order.note}
templateObj.content=replace(templateObj.content,"{aspcms:order.note}",Session("Print.OrderNote"))
'֧����ʽ
templateObj.content=replace(templateObj.content,"{aspcms:order.payment}",Session("Print.OrderPayMent"))

select case Session("Print.OrderPayMent")
	case "����֧��"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Online)
	case "����֧��"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Bank)
	case "�ʾָ���"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_PostOffice)
end select


'��Ʒ�б�
templateObj.content=replace(templateObj.content,"{aspcms:selectproduct}",SelectProductList)
 

		.parseCommon() 		
		echo .content 
	end with
	
	set templateobj =nothing : terminateAllObjects
End Sub



'=======================================
'����ȷ��
'=======================================
Sub OrderComfirm()
if needCheck then
if getForm("code","post")<>Session("Code") then alertMsgAndGo "��֤�벻��ȷ","-1"
end if


dim orderno, username,  m_state, payment, nicename, tel,cellphone, zipcode, address, email, note, m_to, invoice,addtime 
dim sql

	orderno=filterPara(getForm("orderno","post"))
	username=filterPara(getForm("username","post"))	
	nicename=filterPara(getForm("nicename","post"))	
	m_state=0
	address=filterPara(getForm("address","post"))	
	zipcode=filterPara(getForm("zipcode","post"))
	cellphone=filterPara(getForm("cellphone","post"))
	tel=filterPara(getForm("tel","post"))	
	email=filterPara(getForm("email","post"))
	m_to=filterPara(getForm("to","post"))	
	note=filterPara(getForm("note","post"))	
	invoice=filterPara(getForm("invoice","post"))
	Payment=filterPara(getForm("Payment","post"))
	 
	addtime = now
	
		
		
dim id, sortID,SortAndID
	dim qs
	qs = filterPara(Session("Cart_QS"))
	SortAndID=split(replaceStr(qs,FileExt,""),"_")
	
	if isNul(replaceStr(qs,FileExt,"")) then  echoMsgAndGo "ҳ�治����",3 
	SortID = SortAndID(0)
	if not isNul(SortID) and isNum(SortID) then SortID=clng(SortID) else echoMsgAndGo "ҳ�治����",3 end if
	id=SortAndID(1)
	if not isNul(id) and isNum(id) then id=clng(id) else echoMsgAndGo "ҳ�治����",3 end if
	
	if isnul(id) or not isnum(id) then alertMsgAndGo "��ѡ���Ʒ��","-1" 
	if isnul(sortID) or not isnum(sortID) then alertMsgAndGo "��ѡ���Ʒ��","-1" 
	
	dim templateobj,channelTemplatePath : set templateobj = new TemplateClass	
	dim typeIds,rsObj,rsObjtid,Tid,rsObjSmalltype,rsObjBigtype
	Dim templatePath,tempStr
	templatePath=sitePath&"/"&"templates/"&setting.defaultTemplate&"/"&setting.htmlFilePath&"/productcomfirm.html"
	if not CheckTemplateFile(templatePath) then echo "productcomfirm.html"&err_16
	
	set rsObj=conn.exec("select * from {prefix}Sort where SortID="&sortID, "exe")							
	if rsObj.eof then echoMsgAndGo "ҳ�治����",3 : exit sub		
	with templateObj 
	
		.content=loadFile(templatePath)	
		.parseHtml()
		.indexpath()
		templateObj.content=replace(templateObj.content,"{aspcms:sortname}",rsObj("SortName"))
		templateObj.content=replace(templateObj.content,"{aspcms:parentsortid}",rsObj("parentid"))		
		templateObj.content=replace(templateObj.content,"{aspcms:sortid}",sortID)	
		templateObj.content=replace(templateObj.content,"{aspcms:topsortid}",rsObj("topsortid"))
		
		if isnul(rsObj("PageKeywords")) then 
			templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",setting.siteKeyWords)	
		else
			templateObj.content=replace(templateObj.content,"{aspcms:sortkeyword}",rsObj("PageKeywords"))	
		end if
		if isnul(rsObj("PageDesc")) then
			templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",setting.sitedesc)
		else
			templateObj.content=replace(templateObj.content,"{aspcms:sortdesc}",rsObj("PageDesc"))
		end if
		
		if isnul(rsObj("PageTitle")) then 
			templateObj.content=replace(templateObj.content,"{aspcms:sorttitle}",rsObj("SortName"))	
		else
			templateObj.content=replace(templateObj.content,"{aspcms:sorttitle}",rsObj("PageTitle"))
		end if
		
		templateObj.parsePosition(sortID)	
		
		Dim m_username,gender
		if isnul(session("loginstatus")) then  session"loginstatus",0
		if session("loginstatus")="1" then  
			set rsObj=conn.Exec("select * from {prefix}User where UserID="&trim(session("userID")),"r1")
			m_username = rsObj("loginname")
		else 
			gender=1
		end if
		rsObj.close()
		
		
Dim dic,dicPrice,d,oTotal,oCount
oTotal = 0:oCount = 0
Set dic = Session("Cart")
Set dicPrice = Session("Cart.Price")
For Each d In dic
	dim prices
	if isnul(dicPrice(d)) then  prices=0 else prices=dicPrice(d)
	oTotal = oTotal + Eval(dic(d) * prices)
	oCount = oCount + dic(d)
Next

Set dic = nothing:Set dicPrice = nothing


dim hidden
hidden = "<form action='?act=buy' method='post' name='frmComfirm'>"
hidden = hidden & "<input type='hidden' name='orderno' value='"&orderno&"' />"
hidden = hidden & "<input type='hidden' name='username' value='"&username&"' />"
hidden = hidden & "<input type='hidden' name='nicename' value='"&nicename&"' />"
hidden = hidden & "<input type='hidden' name='address' value='"&address&"' />"
hidden = hidden & "<input type='hidden' name='zipcode' value='"&zipcode&"' />"
hidden = hidden & "<input type='hidden' name='cellphone' value='"&cellphone&"' />"
hidden = hidden & "<input type='hidden' name='tel' value='"&tel&"' />"
hidden = hidden & "<input type='hidden' name='email' value='"&email&"' />"
hidden = hidden & "<input type='hidden' name='to' value='"&m_to&"' />"
hidden = hidden & "<input type='hidden' name='note' value='"&note&"' />"
hidden = hidden & "<input type='hidden' name='invoice' value='"&invoice&"' />"
hidden = hidden & "<input type='hidden' name='Payment' value='"&Payment&"' />"
'hidden = hidden & "<input type='hidden' name='state' value='0' />"
hidden = hidden & "<p align='center'>"
hidden = hidden & "<input type='submit' value='ȷ�϶���' name='btnSubmit'/></p></form>"

'������������ {aspcms:order.$trigger$}
templateObj.content=replace(templateObj.content,"{aspcms:order.$trigger$}",hidden)

If m_username = "" then m_username = "�ο�"

'�������룺{aspcms:order.no} 
templateObj.content=replace(templateObj.content,"{aspcms:order.no}",orderno)
Session("Print.OrderNo") = orderno
'�������ڣ�{aspcms:order.date} 
templateObj.content=replace(templateObj.content,"{aspcms:order.date}",addtime)
Session("Print.OrderDate") = addtime
'�� �� ����{aspcms:order.username} 
templateObj.content=replace(templateObj.content,"{aspcms:order.username}",m_username)
Session("Print.OrderUserName") = m_username
'����״̬��{aspcms:order.state} 
templateObj.content=replace(templateObj.content,"{aspcms:order.state}","δ����")
Session("Print.OrderState") = "δ����"
'�����ܽ�{aspcms:order.total}Ԫ 
templateObj.content=replace(templateObj.content,"{aspcms:order.total}",oTotal)
Session("Print.OrderTotal") = oTotal
'��Ʒ��������{aspcms:order.count} 	
templateObj.content=replace(templateObj.content,"{aspcms:order.count}",oCount)
Session("Print.OrderCount") = oCount
'�ͻ�������{aspcms:order.nicename}
templateObj.content=replace(templateObj.content,"{aspcms:order.nicename}",nicename)
Session("Print.OrderNiceName") = nicename
'��ϵ�绰��{aspcms:order.tel}
templateObj.content=replace(templateObj.content,"{aspcms:order.tel}",tel)
Session("Print.OrderTel") = tel
'�ֻ����룺{aspcms:order.cellphone}
templateObj.content=replace(templateObj.content,"{aspcms:order.cellphone}",cellphone)
Session("Print.OrderCellphone") = cellphone
'�������룺{aspcms:order.zipcode}
templateObj.content=replace(templateObj.content,"{aspcms:order.zipcode}",zipcode)
Session("Print.OrderZipcode") = zipcode
'��ϵ��ַ��{aspcms:order.address}
templateObj.content=replace(templateObj.content,"{aspcms:order.address}",address)
Session("Print.OrderAddress") = address
'�������䣺{aspcms:order.email}
templateObj.content=replace(templateObj.content,"{aspcms:order.email}",email)
Session("Print.OrderEmail") = email
'�����ԣ�{aspcms:order.note}
templateObj.content=replace(templateObj.content,"{aspcms:order.note}",note)
Session("Print.OrderNote") = note
'֧����ʽ
templateObj.content=replace(templateObj.content,"{aspcms:order.payment}",Payment)
Session("Print.OrderPayMent") = Payment

select case Payment
	case "����֧��"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Online)
	case "����֧��"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_Bank)
	case "�ʾָ���"
	templateObj.content=replace(templateObj.content,"{aspcms:order.paymentdesc}",Payment_PostOffice)
end select


'��Ʒ�б�
templateObj.content=replace(templateObj.content,"{aspcms:selectproduct}",SelectProductList)
 

		.parseCommon() 		
		echo .content 
	end with
	
	set templateobj =nothing : terminateAllObjects
	
End Sub
%>
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                     
                                                      
                                                     
                                                     
                                                     