<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=n_title%></title><%If Not inull(n_keyword) Then%>
<meta name="keywords" content="<%=n_keyword%>" /><%End If%><%If Not inull(n_description) Then%>
<meta name="description" content="<%=n_description%>" /><%End If%>
<!--#include file="inc_cssjs.asp"-->
</head>
<body>
<div class="body_wrap"> 
	<!--#include file="inc_header.asp"-->
	<%If Not inull(n_cover) Then%><div id="channel_cover"><img src="<%=n_cover%>" alt="<%=n_title%>" title="<%=n_title%>" /></div><%End If%>
	<div class="content_wrap pt10">
		<div class="container">
			<div class="line-big">
				<div class="x3">
					<!--#include file="inc_left_channel_sub.asp"-->
				</div>				
				<div class="x9">
					<!--#include file="inc_current.asp"-->
					<%If Not inull(n_content) then%>
						<div id="channel_content" style="background:#fff;padding:10px 20px 0 20px ; font-size: 12px;line-height:26px;"> <%=n_content%> </div>
					<%Else%>
							<div id="channel_content" style="background:none;"></div>
					<%End If %>
					<div class="right_content">
						<ul class="list-group article_slist">
							<%
							sql = "select * from cms_content where c_parent in ("&n_child&") and c_enable =1 order by c_top desc,c_date desc,c_order desc,id desc"
							page_size = n_page
							pager = pageturner_handle(sql, "id", page_size)
							Set rs = pager(0)
							Do While Not rs.EOF
							%>
							<li><div class="title cut"><span class="color-gray">[ <%=get_nav(rs("c_parent"),"n_name")%> ]</span> <span class="fr badge"><%=str_time("y.mm.dd",rs("c_date"))%></span><a style="<%=rs("c_color")&rs("c_bold")&rs("c_italic")%>" href="<%=c_url(rs("id"),rs("id"))%>" target="<%=rs("c_target")%>"><%=rs("c_name")%></a></div></li>
							<%
							rs.MoveNext
							Loop
							rs.Close
							Set rs = Nothing
							%>
						</ul>
						<div class="fc"></div>
					</div>
					<%=iif((system_mode = 1),pageturner_show(pager(1),pager(2),pager(3),c_page,5),pageturner_rshow(pager(1),pager(2),pager(3),c_page,5,n_aname))%>
					<div class="fc"></div>
				</div>
				<div class="fc"></div>
			</div>
		</div>
	</div>
	<!--#include file="inc_footer.asp"--> 
</div>
</body>
</html>
