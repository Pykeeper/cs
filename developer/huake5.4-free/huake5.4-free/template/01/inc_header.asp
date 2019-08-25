<div class="top-menu">
	<div class="container">
		<div class="l20">
			<div class="x12 tr">
				<%If system_s2 = 1 Then%><a href="<%=s_path%>sitemap.asp" ><span class="fa fa-sitemap"> 网站地图</span> </a><% End If %>
				<%If system_s3 = 1 Then%><a href="<%=s_path%>message.asp" ><span class="fa fa-question-circle"> 在线留言</span> </a><% End If %>
				<%If system_s4 = 1 Then%><a href="javascript:void(0);" class="win-homepage"><span class="fa fa-home"> 设为首页</span> </a><% End If %>
				<%If system_s5 = 1 Then%><a href="javascript:void(0);" class="win-favorite"><span class="fa fa-star"> 加入收藏</span> </a><% End If %>
				<%If system_s6 = 1 Then%><a id="StranLink"><span class="fa fa-globe"> 繁體中文</span> <script language="JavaScript" src="/common/js/language.js"></script></a>	<% End If %>			
			</div>
			<div class="fc"></div>
		</div>
	</div>
</div>
<div id="header">
	<div class="container">
		<div id="logo"><a href="<%=system_domain%>"><img src="<%=system_logo%>" alt="<%=system_name%>" title="<%=system_name%>"/></a></div>
		<div id="nav">
			<ul>
				<%
				Set rs = ado_query("select * from cms_nav where n_ifnav = 1 and n_parent = 0 order by n_order desc , id desc")
				Do While Not rs.EOF
				%>
				<li class="main"> <a<%=iif(current_nav = rs("id")," class=""current""","")%> href="<%=n_url(rs("id"),rs("n_aname"))%>" target="<%=rs("n_target")%>"><%=rs("n_name")%></a>
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
				</li>
				<%
				rs.MoveNext
				Loop
				rs.Close
				Set rs = Nothing
				%>
				<li class="main home"><a href="<%=s_path%>">首页</a></li>
			</ul>
			<div class="fc"></div>
		</div>
		<div class="fc"></div>
	</div>
</div>

