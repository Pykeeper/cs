<%
If rs.EOF Then
    die "无效参数"
End If
c_id = rs("id")
c_name = rs("c_name")
c_fname = rs("c_fname")
c_parent = rs("c_parent")
c_color = rs("c_color")
c_picture = rs("c_picture")
c_scontent = site_link(rs("c_scontent"))
c_mscontent = site_link(rs("c_mscontent"))
c_content = rs("c_content")
c_mcontent = rs("c_mcontent")
c_slide = rs("c_slide")
c_video = rs("c_video")
c_attach = rs("c_attach")
c_rec = rs("c_rec")
c_hot = rs("c_hot")
c_top = rs("c_top")
c_bold = rs("c_bold")
c_italic = rs("c_italic")
c_1 = rs("c_1")
c_2 = rs("c_2")
c_3 = rs("c_3")
c_4 = rs("c_4")
c_5 = rs("c_5")
c_source = rs("c_source")
c_seoname = rs("c_seoname")
c_keyword = rs("c_keyword")
c_description = rs("c_description")
c_writer = rs("c_writer")
c_hits = rs("c_hits")
c_order = rs("c_order")
c_link = rs("c_link")
c_target = rs("c_target")
c_enable = rs("c_enable")
c_date = rs("c_date")
c_mdate = rs("c_mdate")
rs.Close
Set rs = Nothing
conn.Execute("update cms_content set c_hits = c_hits+1 where id = "&c_id&" ")

'=====获取当前频道的基本信息=====
Set rs = ado_query("select * from cms_nav where id = "&c_parent&"")
n_id = rs("id")
n_name = rs("n_name")
n_parent = rs("n_parent")
n_model = rs("n_model")
n_dmodel = rs("n_dmodel")
n_imodel = rs("n_imodel")
n_idmodel = rs("n_idmodel")
n_host = rs("n_host")
n_ifchild = rs("n_ifchild")
n_child = rs("n_child")
n_content = rs("n_content")
n_scontent = rs("n_scontent")
n_mcontent = rs("n_mcontent")
n_mscontent = rs("n_mscontent")
n_seoname = rs("n_seoname")
n_description = rs("n_description")
n_keyword = rs("n_keyword")
n_cover = rs("n_cover")
n_ifnav = rs("n_ifnav")
n_link = rs("n_link")
n_page = rs("n_page")
n_nname = rs("n_nname")
n_fname = rs("n_fname")
n_sname = rs("n_sname")
n_aname = rs("n_aname")
n_afname = rs("n_afname")
n_enable = rs("n_enable")
n_safe = rs("n_safe")
n_order = rs("n_order")
n_date = rs("n_date")
n_target = rs("n_target")
rs.Close
Set rs = Nothing
'=====获取当前频道上级的基本信息=====
If n_parent = 0 Then
    sqlp = "select * from cms_nav where id = "&c_parent&" "
Else
    sqlp = "select * from cms_nav where id = "&n_parent&" "
End If
Set rs = ado_query(sqlp)
nc_id = rs("id")
nc_name = rs("n_name")
nc_parent = rs("n_parent")
nc_model = rs("n_model")
nc_dmodel = rs("n_dmodel")
nc_imodel = rs("n_imodel")
nc_idmodel = rs("n_idmodel")
nc_host = rs("n_host")
nc_ifchild = rs("n_ifchild")
nc_child = rs("n_child")
nc_content = rs("n_content")
nc_scontent = rs("n_scontent")
nc_mcontent = rs("n_mcontent")
nc_mscontent = rs("n_mscontent")
nc_seoname = rs("n_seoname")
nc_description = rs("n_description")
nc_keyword = rs("n_keyword")
nc_cover = rs("n_cover")
nc_ifnav = rs("n_ifnav")
nc_link = rs("n_link")
nc_page = rs("n_page")
nc_nname = rs("n_nname")
nc_fname = rs("n_fname")
nc_sname = rs("n_sname")
nc_aname = rs("n_aname")
nc_afname = rs("n_afname")
nc_enable = rs("n_enable")
nc_safe = rs("n_safe")
nc_order = rs("n_order")
nc_date = rs("n_date")
nc_target = rs("n_target")
rs.Close
Set rs = Nothing
'=====获取当前频道的主频道的基本信息=====
Set rs = ado_query("select * from cms_nav where id = "&n_host&"")
nh_id = rs("id")
nh_name = rs("n_name")
nh_parent = rs("n_parent")
nh_model = rs("n_model")
nh_dmodel = rs("n_dmodel")
nh_imodel = rs("n_imodel")
nh_idmodel = rs("n_idmodel")
nh_host = rs("n_host")
nh_ifchild = rs("n_ifchild")
nh_child = rs("n_child")
nh_content = rs("n_content")
nh_scontent = rs("n_scontent")
nh_mcontent = rs("n_mcontent")
nh_mscontent = rs("n_mscontent")
nh_seoname = rs("n_seoname")
nh_description = rs("n_description")
nh_keyword = rs("n_keyword")
nh_cover = rs("n_cover")
nh_ifnav = rs("n_ifnav")
nh_link = rs("n_link")
nh_page = rs("n_page")
nh_nname = rs("n_nname")
nh_fname = rs("n_fname")
nh_sname = rs("n_sname")
nh_aname = rs("n_aname")
nh_afname = rs("n_afname")
nh_safe = rs("n_safe")
nh_order = rs("n_order")
nh_date = rs("n_date")
nh_target = rs("n_target")
nh_enable = rs("n_enable")
rs.Close
Set rs = Nothing
c_title = iif((inull(c_seoname)),c_name,c_seoname&" - "&c_name)
 
'=====如果频道被禁用=====
If n_enable = 0 Then
    die "频道："&c_name&" 已被禁用,该频道下面的信息都无妨访问！"
End If
If nh_enable = 0 Then
    die "频道："&cm_name&" 已被禁用,该频道下面的信息都无妨访问！"
End If
'=====如果模板文件不存在=====
If Not file_exists(skin&n_dmodel) Then
    die "模板文件："&skin&n_dmodel&" 不存在，请检查！"
End If
If Not file_exists(mskin&n_idmodel) Then
    die "模板文件："&mskin&n_idmodel&" 不存在，请检查！"
End If

'==========如果是外联跳转==========
If Not inull(c_link) Then
	Response.Redirect(c_link)
End If
'=====如果信息被禁用=====
If c_enable = 0 Then
    die "该信息已被禁用，无法访问！"
End If
Function c_prev()
	Set rs = ado_query("select * from cms_content where c_parent in ("&n_child&") and c_order > "&n_order&" order by c_order asc")
	If rs.EOF Then
		c_prev = "暂无"
	Else
		c_prev = "<a style="""&rs("c_color")&rs("c_bold")&rs("c_italic")&""" href="""&c_url(rs("id"),rs("id"))&""" title="""&rs("c_name")&""">"&rs("c_name")&"</a>"
	End If
	rs.Close
	Set rs = Nothing
End Function

'==========下一信息==========

Function c_next()
	Set rs = ado_query("select * from cms_content where c_parent in ("&n_child&") and c_order < "&c_order&" order by c_order desc")
	If rs.EOF Then
		c_next = "暂无"
	Else
		c_next = "<a style="""&rs("c_color")&rs("c_bold")&rs("c_italic")&""" href="""&c_url(rs("id"),rs("id"))&""" title="""&rs("c_name")&""">"&rs("c_name")&"</a>"
	End If
	rs.Close
	Set rs = Nothing
End Function

'上一条
Function d_previous(t0)
    Set rs = ado_query("select * from cms_content where c_parent in ("&n_child&") and c_enable =1 and c_order > "&c_order&" order by c_order asc")
    If rs.EOF Then
        d_previous = "暂无"
    Else
        d_previous = "<a href="""&c_url(rs("id"),rs("id"))&""" title="""&rs("c_name")&""">"&str_left(rs("c_name"), t0, "...")&"</a>"
    End If
    rs.Close
    Set rs = Nothing
End Function

'上一条
Function d_previous1()
    Set rs = ado_query("select * from cms_content where c_parent in ("&n_child&") and c_enable =1 and c_order > "&c_order&" order by c_order asc")
    If rs.EOF Then
        d_previous1 = "暂无"
    Else
        d_previous1 = "<a class=""btn btn bg-black"" href="""&c_url(rs("id"),rs("id"))&""" title="""&rs("c_name")&"""><span class=""fa fa-long-arrow-left""></span> 上一篇 </a>"
    End If
    rs.Close
    Set rs = Nothing
End Function
'下一条

Function d_next1()
    Set rs = ado_query("select * from cms_content where c_parent in ("&h_child&") and c_enable =1 and c_order < "&c_order&" order by c_order desc")
    If rs.EOF Then
        d_next1 = "暂无"
    Else
        d_next1 = "<a class=""btn btn_bg_black"" href="""&c_url(rs("id"),rs("id"))&""" title="""&rs("c_name")&""">下一篇 <span class=""fa fa-long-arrow-right""></span></a>"
    End If
    rs.Close
    Set rs = Nothing
End Function
	
	'下一条

Function d_next(t0)
    Set rs = ado_query("select * from cms_content where c_parent in ("&h_child&") and c_enable =1 and c_order < "&c_order&" order by c_order desc")
    If rs.EOF Then
        d_next = "暂无"
    Else
        d_next = "<a href="""&c_url(rs("id"),rs("id"))&""" title="""&rs("c_name")&""">"&str_left(rs("c_name"), t0, "...")&"</a>"
    End If
    rs.Close
    Set rs = Nothing
End Function
current_nav = n_host
 if ismobi() then
	echo ob_get_contents(mskin&n_idmodel)
else
	echo ob_get_contents(skin&n_dmodel)
end If
%> 
