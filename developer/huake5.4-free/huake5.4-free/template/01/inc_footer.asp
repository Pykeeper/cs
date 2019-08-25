<div id="footer_menu">
	<div class="container">
		<div class="l20">
			<div class="x3">
				<div class="f_title"><%=get_nav(6,"n_name")%></div>
				<div id="footer_contact"><%=get_nav(6,"n_content")%></div> 
			</div>
			<div class="x6"> 
				<div class="l40">
				<%
				Set rs = ado_query("select * from cms_nav where n_ifnav = 1 and n_parent = 0 order by n_order asc , id asc")
				Do While Not rs.EOF
				%>
				<div class="x"><div class="main"><a<%=iif(current_nav = rs("id")," class=""current""","")%> href="<%=n_url(rs("id"),rs("n_aname"))%>" target="<%=rs("n_target")%>"><%=rs("n_name")%></a></div>
					<%If rs("n_ifchild") = 1 Then%>
					<ul class="sub">
						<%
							Set rss = ado_query("select * from cms_nav where n_ifnav = 1 and n_parent = "&rs("id")&" order by n_order asc , id asc")
							Do While Not rss.EOF
							%>
						<li><a href="<%=n_url(rss("id"),rss("n_aname"))%>" target="<%=rss("n_target")%>"><%=rss("n_name")%></a></li>
						<%
							rss.MoveNext
							Loop
							rss.Close
							Set rss = Nothing
							%>
					</ul>
					<%End If%>
				</div>
				<%
				rs.MoveNext
				Loop
				rs.Close
				Set rs = Nothing
				%>
				</div>
			</div>
			<div class="x3">
				<ul id="footer_service">
				<%
				Set rs = ado_query("select * from cms_service where s_launch = 1 order by s_order asc , id asc")
				Do While Not rs.EOF
				%>
				<li><span <%=iif(rs("s_type")=0,"class=""fa fa-qq""","class=""fa fa-weixin""")%>></span> <%=rs("s_name")%> ：<%=rs("s_num")%></a></li>
				<%
				rs.MoveNext
				Loop
				rs.Close
				Set rs = Nothing
				%>	 
				</ul>
			</div>
		</div>
		<div class="fc"></div>
	</div>
</div>
<div id="footer_wrap">
	<div class="container">
		<div id="copyright" class="tc"><%=system_copyright%><a href="http://www.huakecms.com" class="f12 color-white">华科网络</a> </div>
	</div>
</div>
<%If system_service <> 0 then%>
<!--#include file="inc_service.asp"-->
<%End If%>