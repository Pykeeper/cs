<%
Set rs = ado_query(sql)
If rs.EOF Then
     Call alert_back("不存在的频道，或者该频道已经被删除！")
End If
rqid = rs("id")
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
n_scontent = site_link(rs("n_scontent"))
n_mcontent = rs("n_mcontent")
n_mscontent = site_link(rs("n_mscontent")) 
n_seoname = rs("n_seoname")
n_description = rs("n_description")
n_keyword = rs("n_keyword")
n_cover = rs("n_cover")
n_picture = rs("n_picture")
n_ifnav = rs("n_ifnav")
n_link = rs("n_link")
n_page = rs("n_page")
n_nname = rs("n_nname")
n_fname = rs("n_fname")
n_sname = rs("n_sname")
n_aname = rs("n_aname")
n_afname = rs("n_afname")
n_safe = rs("n_safe")
n_order = rs("n_order")
n_date = rs("n_date")
n_target = rs("n_target")
n_enable = rs("n_enable")
rs.Close
Set rs = Nothing
'=====获取当前频道上级的基本信息=====
If c_parent = 0 Then
    sqlp = "select * from cms_nav where id = "&n_id&" "
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
nc_picture = rs("n_picture")
nc_ifnav = rs("n_ifnav")
nc_link = rs("n_link")
nc_page = rs("n_page")
nc_nname = rs("n_nname")
nc_fname = rs("n_fname")
nc_sname = rs("n_sname")
nc_aname = rs("n_aname")
nc_afname = rs("n_afname")
nc_safe = rs("n_safe")
nc_order = rs("n_order")
nc_date = rs("n_date")
nc_target = rs("n_target")
nc_enable = rs("n_enable")
rs.Close
Set rs = Nothing
'=====获取当前频道的主频道的基本信息=====

Set rs = ado_query("select * from cms_nav where id = "&n_host&" ")
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
nh_picture = rs("n_picture")
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
If Not inull(n_link) Then
	Response.Redirect(n_link)
End If
 
n_title = iif((inull(n_seoname)),n_name,n_seoname&" - "&n_name)

current_nav = n_host
If n_enable = 0 Then
    die "频道："&n_name&" 已被禁用！"
End If
If nh_enable = 0 Then
    die "频道："&nh_name&" 已被禁用！"
End If
'=====如果模板文件不存在=====
If Not file_exists(skin&n_model) Then
    die "模板文件："&skin&n_model&" 不存在，请检查！"
End If
If Not file_exists(mskin&n_imodel) Then
    die "模板文件："&mskin&n_imodel&" 不存在，请检查！"
End If
 if ismobi() then
   echo ob_get_contents(mskin&n_imodel)
else
    echo ob_get_contents(skin&n_model)
end If
%>