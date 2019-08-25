<%
cms_version = "华科V5.4_free"
Set rs = ado_query("select * from cms_system where id =1")
system_template =rs("s_template")
system_mtemplate =rs("s_mtemplate")
system_name =rs("s_name")
system_sname =rs("s_sname")
system_mode =rs("s_mode")
system_weixin =rs("s_weixin")
system_qq =rs("s_qq")
system_phone =rs("s_phone")
system_domain =rs("s_domain")
system_message =rs("s_message")
system_service =rs("s_service")
system_mservice =rs("s_mservice")
system_keyword =rs("s_keyword")
system_seoname =rs("s_seoname")
system_description =rs("s_description")
system_key =rs("s_key")
system_copyright =rs("s_copyright")
system_mcopyright =rs("s_mcopyright")
system_m_prompt =rs("s_m_prompt")
system_s2 = rs("s_s2")
system_s3 = rs("s_s3")
system_s4 = rs("s_s4")
system_s5 = rs("s_s5")
system_s6 = rs("s_s6")
system_c1 = rs("s_c1")
system_c2 = rs("s_c2")
system_c3 = rs("s_c3")
system_c4 = rs("s_c4")
system_c5 = rs("s_c5")
skin = s_path&"template/"&system_template&"/"
mskin = s_path&"template/"&system_mtemplate&"/"
rs.Close
Set rs = Nothing
'获取logo
Set rs = ado_query("select * from cms_template where t_path = '"&system_template&"'")
	system_logo = rs("t_logo")
rs.Close
Set rs = Nothing
Set rs = ado_query("select * from cms_template where t_path = '"&system_mtemplate&"'")
	system_mlogo = rs("t_logo")
rs.Close
Set rs = Nothing

'获取频道
Function get_nav(t0,t1)
Set rs_gn = ado_query("select * from cms_nav where id = "&t0&"")
If Not rs_gn.EOF Then 
	get_nav = rs_gn(t1)
Else
	get_nav= "不存在此导航"
End If 
End Function

Function n_url(t0,t1)
	n_url = s_path&"nav/"&t1&".html"
	If system_mode = 1 Then 
	n_url = s_path&"nav.asp?id="&t0&""
	End If 
End Function

Function c_url(t0,t1)
	c_url = s_path&"content/"&t1&".html"
	If system_mode = 1 Then 
	c_url = s_path&"content.asp?id="&t0&""
	End If 
End Function

'导航和内容页的当前位置
Function current_nav_location(t0)
    Set rs_cnl = ado_query("select * from cms_nav where id = "&t0&"")
    current_nav = IIf(rs_cnl("id") = Int(t0), " class=""current_nav""", "")
    current_nav_location = "<a"&current_nav&" href="""&n_url(rs_cnl("id"),rs_cnl("n_aname"))&""">"&rs_cnl("n_name")&"</a>"
    If rs_cnl("n_parent") <> 0 Then
        current_nav_location = current_nav_location(rs_cnl("n_parent"))&" >> "&current_nav_location
    End If
    rs_cnl.Close
    Set rs_cnl = Nothing
End Function

'导航列表
Function nav_list(t0, t1)
    If n_ifchild = 1 Then
        sql_nl = "select * from cms_nav where n_parent = "&t0&" and n_ifnav =1 order by n_order asc , id asc"
    Else
        sql_nl = "select * from cms_nav where n_parent = "&t1&" and n_ifnav =1 order by n_order asc , id asc"
    End If
    Set rs_csl = ado_query(sql_nl)
    Do While Not rs_csl.EOF
        nav_snav = IIf(rs_csl("id") = Int(t0), " class=""nav_snav""", "")
        nav_list = nav_list&"<li><a"&nav_snav&" href="""&n_url(rs_csl("id"),rs_csl("n_aname"))&""">"&rs_csl("n_name")&"</a></li>"
        rs_csl.movenext
    Loop
    rs_csl.Close
    Set rs_csl = Nothing
End Function
	
Function mnav_list(t0, t1)
    If n_ifchild = 1 Then
        sql_nl = "select * from cms_nav where n_parent = "&t0&" and n_ifnav =1 order by n_order asc , id asc"
    Else
        sql_nl = "select * from cms_nav where n_parent = "&t1&" and n_ifnav =1 order by n_order asc , id asc"
    End If
    Set rs_mcsl = ado_query(sql_nl)
    Do While Not rs_mcsl.EOF
        mnav_snav = IIf(rs_mcsl("id") = Int(t0), " class=""mnav_snav""", "")
        mnav_list = mnav_list&"<div class=""x4 tc""><a"&mnav_snav&" href="""&n_url(rs_mcsl("id"),rs_mcsl("n_aname"))&""">"&rs_mcsl("n_name")&"</a></div>"
        rs_mcsl.movenext
    Loop
    rs_mcsl.Close
    Set rs_mcsl = Nothing
End Function
	
Function nav_listb(t0, t1)
    If n_ifchild = 1 Then
        sql_nl = "select * from cms_nav where n_parent = "&t0&" and n_ifnav =1 order by n_order asc , id asc"
    Else
        sql_nl = "select * from cms_nav where n_parent = "&t1&" and n_ifnav =1 order by n_order asc , id asc"
    End If
    Set rs_cslb = ado_query(sql_nl)
    Do While Not rs_cslb.EOF
   		nav_snavb = IIf(rs_cslb("id") = Int(t0), " class=""nav_snavb a8""", "")
        nav_listb = nav_listb&"<li"&nav_snavb&" class=""a8""><a href="""&n_url(rs_cslb("id"),rs_cslb("n_aname"))&""">"&rs_cslb("n_name")&"</a></li>"
        rs_cslb.movenext
    Loop
    rs_cslb.Close
    Set rs_cslb = Nothing
End Function
'碎片内容
Function get_chip(t0)
	Set rs_gc = ado_query("select * from cms_chip where id = "&t0&"")
	If rs_gc.EOF Then
		get_chip = "error"
	Else
		get_chip = rs_gc("c_content")
	End If
    rs_gc.Close
    Set rs_gc = Nothing
End Function
	
Function product_class_list(t0)
    sql_nl = "select * from cms_nav where id = "&t0&" and n_ifnav =1 order by n_order asc , id asc"
    Set rs_pcl = ado_query(sql_nl)
    If Not rs_pcl.eof Then 
		pc=rs_pcl("n_child")
		product_class_list1=Split(pc, ",")
	End If 
For i = 0 To UBound(product_class_list1)
	If  product_class_list1(i) =3 Then 
		product_class_list ="<li>全部</li>"
	Else
		product_class_list = product_class_list&"<li>"&get_nav(product_class_list1(i),"n_name")&"</li>"
	End If 

next
    rs_pcl.Close
    Set rs_pcl = Nothing
End Function 
	
Function channel_list(t0, t1, t2, t3)
    Set rs_nsl = ado_query("select * from cms_nav where n_parent = "&t0&" and id <> "&t3&" and n_ifnav =1 order by n_order asc , id asc")
    For i = 1 To t1
        sp = sp&"　"
    Next
    if_main = IIf(t0 = 0, "", "￢￢￢￢￢")
    Do While Not rs_nsl.EOF
        if_selected = IIf(rs_nsl("id") = t2, " selected=""selected""", "")
        channel_list = channel_list&"<li"&if_selected&" value="""&rs_nsl("id")&""" ><a href="""&n_url(rs_nsl("id"),rs_nsl("n_aname"))&""">"&sp&if_main&rs_nsl("n_name")&"</a>"&"</li>"&vbCrLf&channel_list(rs_nsl("id"), i, t2, t3)
        rs_nsl.movenext
    Loop
    rs_nsl.Close
    Set rs_nsl = Nothing
End Function

'无图片设置	
nopicture = s_path&"uploadfiles/nopic.png"
	
'站内链接
Function site_link(byval Str)
	Dim rs
	Set rs = conn.Execute("select * from cms_sitelink where l_enable = 1 order by id asc")
	While Not rs.EOF
		Str = p_replace(Str, rs("l_name"), "<a href="""&rs("l_url")&""" target=""_blank"" >"&rs("l_name")&"</a>")
		rs.movenext
	Wend
	rs.Close
	Set rs = Nothing
	site_link = Str
End Function

Function p_replace(content, asp, htm)
	If IsNull(content) Then Exit Function
	Dim Matches, strs, i
	strs = content
	Set Matches = str_execute("(\<a[^<>]+\>.+?\<\/a\>)|(\<img[^<>]+\>)",strs)
	i = 0
	Dim MyArray()
	For Each Match in Matches
		ReDim Preserve MyArray(i)
		MyArray(i) = Mid(Match.Value, 1, Len(Match.Value))
		strs = Replace(strs, Match.Value, "<"&i&">")
		i = i + 1
	Next
	If i = 0 Then
		content = Replace(content, asp, htm)
		p_replace = content
		Exit Function
	End If
	strs = Replace(strs, asp, htm)
	For i = 0 To UBound(MyArray)
		strs = Replace(strs, "<"&i&">", MyArray(i))
	Next
	p_replace = strs
End Function
'检测是否为手机访问
Function ismobi()
    HTTP_ACCEPT=Request.ServerVariables("HTTP_ACCEPT")                 '获取浏览器信息
    HTTP_USER_AGENT=LCase(Request.ServerVariables("HTTP_USER_AGENT"))  '获取AGENT
    HTTP_X_WAP_PROFILE=Request.ServerVariables("HTTP_X_WAP_PROFILE")   'WAP特定信息 品牌机自带浏览器都会有
    HTTP_UA_OS=Request.ServerVariables("HTTP_UA_OS")                   '手机系统 电脑为空
    HTTP_VIA=LCase(Request.ServerVariables("HTTP_VIA"))                '网关信息
    ismobi=False
    If instr(HTTP_ACCEPT,"vnd.wap")>0 Then
        ismobi=True
    elseIf HTTP_USER_AGENT="" Then
        ismobi=True
    elseIf HTTP_X_WAP_PROFILE<>"" Then
        ismobi=True
    elseIf HTTP_UA_OS<>"" Then
        ismobi=True
    elseif instr(HTTP_VIA,"wap")>0 Then
        ismobi=True
    elseif instr(HTTP_USER_AGENT,"netfront")>0 Then
        ismobi=True
    elseif instr(HTTP_USER_AGENT,"iphone")>0 Then
        ismobi=True
    elseif instr(HTTP_USER_AGENT,"opera mini")>0 Then
        ismobi=True
    elseif instr(HTTP_USER_AGENT,"ucweb")>0 Then
        ismobi=True
    elseif instr(HTTP_USER_AGENT,"windows ce")>0 Then
        ismobi=True
    elseif instr(HTTP_USER_AGENT,"symbianos")>0 Then
        ismobi=True
    elseif instr(HTTP_USER_AGENT,"java")>0 Then
        ismobi=True
    elseif instr(HTTP_USER_AGENT,"android")>0 Then
        ismobi=True
    End if
End Function
%>