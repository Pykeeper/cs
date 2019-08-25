<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=c_title%></title><%If Not inull(c_keyword) Then%>
<meta name="keywords" content="<%=c_keyword%>" /><%End If%><%If Not inull(c_description) Then%>
<meta name="description" content="<%=c_description%>" /><%End If%>
<!--#include file="inc_cssjs.asp"-->
</head>
<body>
<div class="body_wrap"> 
	<!--#include file="inc_header.asp"--> 
	<div class="content_wrap pt10">
		<div class="container">
			<div class="line-big">
				<div class="x3">
					<!--#include file="inc_left_channel_sub.asp"-->
				</div>
				<div class="x9">
					<div class="current_nav"><p><span class="fa fa-home"></span>当前位置 ><a href="<%=s_path%>">首页</a> > <%=current_nav_location(n_id)%> </p></div>
					<div class="right_content plr10 pb10"> 
						<h1 id="info_title" style="<%=c_bold%><%=c_italic%><%=c_color%>"><%=c_name%></h1>
						<p id="info_intro">发布日期：<%=c_date%> 访问次数：<%=c_hits%> 来源：<%=c_source%> 作者：<%=c_writer%></p>
						<div class="l20">
							<div class="x3"></div>
							<div class="x6">
								<%if c_picture <> "" and inull(c_slide) then%>
								<div id="info_picture"><a href="<%=c_picture%>" target="_blank"><img src="<%=c_picture%>" title="<%=c_name%>" alt="<%=c_name%>" /></a></div>
								<%end if%>
								<%If c_slide <> "" then%>
								<div id="info_slideshow">
									<div class="bd square_img3">
										<%
										arr_slideshow = Split(c_slide, "|")
										For i = 0 To UBound(arr_slideshow)
											echo "<a href="""&arr_slideshow(i)&""" data-lightbox=""group"" data-title="""&c_name&"""><img src="""&arr_slideshow(i)&""" alt="""&i_name&""" title="""&i_name&"""></a>"
										Next
										%>
									</div>
									<div class="hd">
										<ul class="l4">
											<%
											arr_slideshow = Split(c_slide, "|")
											For i = 0 To UBound(arr_slideshow)
												echo "<li class=""xx15 mb4""><div class=""img""><img src="""&arr_slideshow(i)&"""/></div></li>"
											Next
											%>
										</ul>
									</div>
								</div>
								<%End If%>
							</div>
						</div>
						<%If c_attach <> "" then%>
						<div class="quote">
							<%
							arr_attach = Split(c_attach, "|")
							For i = 0 To UBound(arr_attach)
								echo "<a class=""btn bg-green mb4"" href="""&arr_attach(i)&""" target=""_blank"">点击下载"&i+1&"</a> "
							Next
							%>
						</div>
						<%End If%>
						<%If c_video <> "" then%>
						<div id="info_video">
							<%=c_video%>
						</div>
						<%End If%>
						<div id="info_content"> <%=c_scontent%> </div>
						<div id="info_around">
							<p>上一<%=n_sname%>： <%=c_prev()%></p>
							<p>下一<%=n_sname%>： <%= c_next()%> </p>
						</div>
				</div>
			</div>
		</div>	
	</div>	
 	<!--#include file="inc_footer.asp"--> 
</div>
</body>
</html>
