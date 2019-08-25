<!DOCTYPE html PUBLIC "-//W3C//ttd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/ttd/xhtml1-transitional.ttd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>搜素结果</title>
<meta name="keywords" content="<%=n_keyword%>" />
<meta name="description" content="<%=n_description%>" />
<!--#include file="inc_cssjs.asp"-->
</head>
<body>
<div class="body_wrap"> 
	<!--#include file="inc_header.asp"--> 
	<div class="content_wrap pt10">
		<div class="container">
			<div id="content">
				<div class="line-big">
					<div class="current_nav">
						<p><span class="fa fa-home"></span>当前位置 ><a href="<%=s_path%>">首页</a> > 搜素结果  </p>
					</div>
					<div class="right_content p10">
						<ul class="searchlist list-group">
							<!--循环开始-->
							<%
							sql = "select * from cms_content where c_enable = 1 and c_name like '%"&trim(str_safe(Request.QueryString("search_text")))&"%' order by c_order desc , id desc"
							page_size = 20
							pager = pageturner_handle(sql, "id", page_size)
							Set rs = pager(0)
							If rs.EOF Then
							    echo "未找到相关信息！"
							End If
							Do While Not rs.EOF
							%>
							<li> [<%=get_nav(rs("c_parent"),"n_name")%>] <span class="color-red"><%=str_safe(Request.QueryString("search_text"))%> </span> <span class="badge fr"><%=str_time("y-m-d",rs("c_date"))%></span><a href="<%=c_url(rs("id"),rs("id"))%>" target="<%=rs("c_target")%>" title="<%=rs("c_name")%>"><%=rs("c_name")%></a></li>
							<%
								rs.movenext
								Loop
								rs.Close
								Set rs = Nothing
								%>
								<!--循环结束-->
						</ul>
					</div>
					<%=pageturner_show(pager(1),pager(2),pager(3),page_size,5)%><div class="fc"></div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--#include file="inc_footer.asp"-->
</div>
</body>
</html>
