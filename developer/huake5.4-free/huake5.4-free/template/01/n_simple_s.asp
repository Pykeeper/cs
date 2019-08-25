<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=n_title%></title><%If Not inull(n_keyword) Then%>
<meta name="keywords" content="<%=n_keyword%>" /><%End If%><%If Not inull(n_description) Then%>
<meta name="description" content="<%=n_description%>" /><%End If%>
<!--#include file="inc_cssjs.asp"--></head>
<body>
<div class="body_wrap"> 
	<!--#include file="inc_header.asp"--> 
	<%If Not inull(n_cover) Then%><div id="channel_cover"><img src="<%=n_cover%>" alt="<%=n_title%>" title="<%=n_title%>" /></div><%End If%>	 
	<div class="content_wrap pt10">
		<div class="container">
			<div class="line-big pb10">
				<div class="x3">
					<!--#include file="inc_left_channel_sub.asp"-->
				</div>
				<div class="x9">
					 <!--#include file="inc_current.asp"-->
					<div class="right_content" >
						<div class="nss_content">
							<div class="nss_tt"><%=n_name%></div>
							<div class="nss_des">来源：<%=system_name%>发布 时间：<%=n_date%></div>
							<div class="nss_con"><%=n_scontent%></div>
						</div>
					</div>
				</div>
				<div class="fc"></div>
			</div>
		</div>
	</div>
	<!--#include file="inc_footer.asp"--> 
</div>
</body>
</html>
