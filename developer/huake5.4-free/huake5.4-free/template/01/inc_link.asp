<div id="link_warp">
	<div class="container">
		<div id="link">
			<div class="b_title">
				<p>友情链接<span>Link</span></p>
			</div>
			<div class="link_picture">
				<div class="l10 mtb10">
					<%
					Set rs = ado_query("select * from cms_link where l_picture <> '' and l_enable=1 order by l_order desc,id desc ")
					Do While Not rs.EOF
					%>
					<div class="xx15">
						<div class="wrap">
							<a href="<%=rs("l_url")%>"><img src="<%=rs("l_picture")%>" title="<%=rs("l_name")%>" alt="<%=rs("l_name")%>" /></a>
							<div class="title"><a href="<%=rs("l_url")%>" target="_blank"><%=rs("l_name")%></a></div>
						</div>
					</div>
					<%
					rs.movenext
					Loop
					rs.Close
					Set rs = Nothing
					%>
				</div>
			</div>
			<div class="link_text">
				<div class="l10 mb10">
					<%
					Set rs = ado_query("select * from cms_link where l_enable=1 order by l_order desc,id desc ")
					Do While Not rs.EOF
					%>
					<div class="a8"><a href="<%=rs("l_url")%>" target="_blank"><%=rs("l_name")%></a></div>
					<%
					rs.movenext
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
