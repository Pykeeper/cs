<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=system_name%> - <%=system_seoname%></title><%If Not inull(system_keyword) Then%>
<meta name="keywords" content="<%=system_keyword%>" /><%End If%><%If Not inull(system_description) Then%>
<meta name="description" content="<%=system_description%>" /><%End If%>
<!--#include file="inc_cssjs.asp"--> 
<script type="text/javascript">
$(function(){
	$('#nav .home a').addClass('current');
});
</script>
</head>
<body>	
<div class="body_wrap"> 
	<!--#include file="inc_header.asp"--> 
	<!--#include file="inc_banner.asp"-->
	<div id="product">
		<div class="container">
			<div class="l20">
				<div class="x3">
					<div class="product_left">
						<h2><p><%=get_nav(3,"n_name")%><span>Product Category</span></p></h2>
						<div class="pnav">
							<ul class="p10">
								<%
								Set rs = ado_query("select * from cms_nav where n_ifnav = 1 and n_parent = 3 order by n_order asc , id asc")
								Do While Not rs.EOF
								%>
								<li class="pnav-item"><a href="<%=n_url(rs("id"),rs("n_aname"))%>"><%=rs("n_name")%> <span class="fr fa fa-angle-right"></span></a>
								</li>
								<%
								rs.MoveNext
								Loop
								rs.Close
								Set rs = Nothing
								%>
							</ul>						
						</div>
					</div>
				</div>
				<div class="x9">
					<div class="picture_slist l10">
						<% 
						Set rs = ado_query("select top 8 * from cms_content where c_parent in ("&get_nav(3,"n_child")&") and c_enable =1 order by c_top desc, c_order desc , id desc")
							Do While Not rs.EOF
						%>
						<div class="x3 mb10 ">
							<div class="wrap">
								<div class="square_img"><a href="<%=c_url(rs("id"),rs("id"))%>" class="pic" title="<%=rs("c_name")%>" target="<%=rs("c_target")%>"> <img src="<%=iif((inull(rs("c_picture"))),nopicture,rs("c_picture"))%>" alt="<%=rs("c_name")%>" /></a></div>
								<div class="detail1 cut">
									<a href="<%=c_url(rs("id"),rs("id"))%>" title="<%=rs("c_name")%>" target="<%=rs("c_target")%>"><%=rs("c_name")%></a>
								</div> 
							</div>
						</div>
						<%
						rs.MoveNext
						Loop
						rs.Close
						Set rs = Nothing
						%>
					</div>					
				</div>
				<div class="fc"></div>
			</div>
		</div>
	</div>
	<div id="ncc">
		<div class="container">
			<div class="l20">
				<div class="x4 mtb20">
					<div class="p20 block">
						<div class="i_title">
							<span class="f26"><%=get_nav(2,"n_name")%><span class="color-dot"><%=get_nav(2,"n_afname")%></span> </span>
							<a class="btn bg-dot fr" href="<%=n_url(2,get_nav(2,"n_aname"))%>">更多></a> 
							<div class="fc"></div>
						</div>
						<div class="index_news">
							<div class="mb10 tr">
								<span class="btn prev fa fa-angle-down"> </span>
								<span class="btn next fa fa-angle-up"> </span>
							</div>
							<div class="bd">
								<% Set rs = ado_query("select top 4 * from cms_content where c_parent in ("&get_nav(2,"n_child")&") and c_enable =1 order by c_date desc,c_top desc,c_order desc, id desc")
								Do While Not rs.EOF %>
								<div class="wrap">
									<div class="left">
										<div class="day"><%=str_time("dd",rs("c_date"))%></div>
										<div class="ym"><%=str_time("y-mm",rs("c_date"))%></div>
									</div>
									<div class="right">
										<div class="title cut"><a style="<%=rs("c_color")&rs("c_bold")&rs("c_italic")%>" href="<%=c_url(rs("id"),rs("id"))%>" title="<%=rs("c_name")%>" target="<%=rs("c_target")%>"><%=rs("c_name")%></a></div>
										<div class="content"><%=str_left(rs("c_content"),68,"...")%></div>
									</div>
									<div class="fc"></div>
								</div>
								<%
									rs.movenext
									Loop
									rs.Close
									Set rs = Nothing
								%>	
							</div>
						</div>
					</div>
				</div>
				<div class="x4 mtb20">
					<div class="p20 block">
						<div class="i_title">
							<span class="f26"><%=get_nav(5,"n_name")%><span class="color-dot"><%=get_nav(5,"n_afname")%></span> </span>
							<a class="btn bg-dot fr" href="<%=n_url(5,get_nav(5,"n_aname"))%>">更多></a> 
							<div class="fc"></div>
						</div>
						<div class="index_case l10">
						<% 
						Set rs = ado_query("select top 9 * from cms_content where c_parent in ("&get_nav(5,"n_child")&") and c_enable =1 order by c_top desc,c_date desc, c_order desc , id desc")
							Do While Not rs.EOF
						%>
						<div class="x4 mb10 wrap">
							<div class="square_img2"><a href="<%=c_url(rs("id"),rs("id"))%>" title="<%=rs("c_name")%>" target="<%=rs("c_target")%>"> <img class="border  p4" src="<%=iif((inull(rs("c_picture"))),nopicture,rs("c_picture"))%>" alt="<%=rs("c_name")%>" /></a></div>							 
							<p class="title cut tc"><a  href="<%=c_url(rs("id"),rs("id"))%>" title="<%=rs("c_name")%>" target="<%=rs("c_target")%>"><%=rs("c_name")%></a></p>
						</div>
						<%
						rs.MoveNext
						Loop
						rs.Close
						Set rs = Nothing
						%>
						</div>
						<div class="fc"></div>
					</div>
				</div>
				<div class="x4 mtb20">
					<div class="p20 block">
						<div class="i_title">
							<span class="f26"><%=get_nav(1,"n_name")%><span class="color-dot"><%=get_nav(1,"n_afname")%></span> </span>
							<a class="btn bg-dot fr" href="<%=n_url(1,get_nav(1,"n_aname"))%>">更多></a> 
							<div class="fc"></div>
						</div>
						<div class="index_about">
							<p><%=str_left(get_nav(1,"n_content"),480,"...")%></p>
						</div>
					</div>
				</div>
				<div class="fc"></div>
			</div>
		</div>
	</div>
  <!--#include file="inc_link.asp"-->
  <!--#include file="inc_footer.asp"-->
</div>
</body>
</html>