<div class="banner">
	<div class="bd">
		<ul>
			<%
			Set rs = ado_query("select * from cms_banner where b_enable = 1 and b_parent=0 order by b_order asc , id asc")
			Do While Not rs.EOF
				If Not rs.EOF Then 
				%>
				<li style="background: url(<%=rs("b_picture")%>) center no-repeat">
					<div class="content">
						<a href="<%=rs("b_url")%>" title="<%=rs("b_name")%>"><h2><%=rs("b_name")%></h2></a>
						 <%=rs("b_content")%> 
					</div>
				</li>
				<%
				End If 
			rs.moveNext
			Loop
			rs.Close
			Set rs = Nothing
			%>
		</ul>
	</div>
	<a class="prev" href="javascript:void(0)"><span class="fa fa-angle-left"></span></a>
	<a class="next" href="javascript:void(0)"><span class="fa fa-angle-right"></span></a>
	<div class="hd">
		<ul>
		</ul>
	</div>
</div>
<div id="tagsearch" >
	<div class="container" id="search">
		<div class="line-big">
			<div class="x8">
				<span>热搜关键词：</span>
				<%
				tmp_hotkey = Split(system_key,"|")
				For hi = 0 To UBound(tmp_hotkey)
					echo "<a class=""badge"" href="""&s_path&"search.asp?search_text="&tmp_hotkey(hi)&""">"&tmp_hotkey(hi)&"</a> "
				Next
				%>
			</div>
			<div class="x4">
				<div class="search">
					<form method="get" action="<%=s_path%>search.asp">
						<input id="form_text_search" type="text" name="search_text" />
						<input id="form_submit_search" type="submit" value="搜索" />
					</form>
				</div>
				 
			</div>
		</div>
	</div>
</div>
