<div id="service" style="bottom:0px; <%=iif(system_service = 1,"left","right")%>:1px;">
	<div class="se custom" style="<%=iif(system_service = 1,"border-left","border-right")%>:5px solid #000000;">
		<span class="fa fa-arrow-circle-o-left"></span>
		<div class="content" style="<%=iif(system_service = 1,"left","right")%>:60px;">
			<%=get_chip(2)%>
		</div>
	</div>
	<div class="se commenting" style="<%=iif(system_service = 1,"border-left","border-right")%>:5px solid #000000;">
		<a href="<%=s_path%>message.asp" target="_black"><span class="fa fa-commenting-o"></span></a>		 
	</div>
	<div class="se qrcode" style="<%=iif(system_service = 1,"border-left","border-right")%>:5px solid #000000;">
		<span class="fa fa-qrcode"></span>
		<div class="content" style="<%=iif(system_service = 1,"left","right")%>:60px;">
			<img src="<%=system_weixin%>" alt="<%=system_name%>"/>
		</div>
	</div>
	<div class="se phone" style="<%=iif(system_service = 1,"border-left","border-right")%>:5px solid #000000;">
		<span class="fa fa-phone"></span>
		<div class="content" style="<%=iif(system_service = 1,"left","right")%>:60px;"><%=system_phone%></div>
	</div>
	<div class="se qq" style="<%=iif(system_service = 1,"border-left","border-right")%>:5px solid #000000;">
		<a href="http://wpa.qq.com/msgrd?v=3&uin=<%=system_qq%>&site=qq&menu=yes"><span class="fa fa-qq"></span></a>
		<div class="content" style="<%=iif(system_service = 1,"left","right")%>:60px;"><a href="http://wpa.qq.com/msgrd?v=3&uin=<%=system_qq%>&site=qq&menu=yes"><%=system_qq%></a></div>
	</div>
	<div class="se gotop" style="<%=iif(system_service = 1,"border-left","border-right")%>:5px solid #000000;">
		<span class="fa fa-chevron-up "></span>
	</div>
</div>
