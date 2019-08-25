<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>网站地图 - <%=system_seoname%></title><%If Not inull(system_keyword) Then%>
<meta name="keywords" content="<%=system_keyword%>" /><%End If%><%If Not inull(system_description) Then%>
<meta name="description" content="<%=system_description%>" /><%End If%>
<!--#include file="inc_cssjs.asp"-->
</head>
<body>
<div class="body_wrap"> 
	<!--#include file="inc_header.asp"--> 
	<div class="content_wrap p10">
		<div class="container ">
			<div class="line-big">
				<div class="current_nav"><p><span class="fa fa-home"></span>当前位置 ><a href="<%=s_path%>">首页</a> > 网站地图</p></div>
				<div class="nsd_wrap bg-white">
					<ul class="list-group">
						<%=channel_list(0, 0, "", 0)%>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!--#include file="inc_footer.asp"-->
</body>
</html>
