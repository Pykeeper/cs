<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="renderer" content="webkit" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<title>在线留言 - <%=system_seoname%></title><%If Not inull(system_keyword) Then%>
<meta name="keywords" content="<%=system_keyword%>" /><%End If%><%If Not inull(system_description) Then%>
<meta name="description" content="<%=system_description%>" /><%End If%>
<!--#include file="inc_cssjs.asp"-->
</head>
<body>
<div class="body_wrap"> 
	<!--#include file="inc_header.asp"--> 
	<div class="content_wrap pt10">
		<div class="container">
			<div class="current_nav">
				<p><span class="fa fa-home"></span>当前位置 ><a href="<%=s_path%>">首页</a> > 在线留言</p>
			</div>
			<div class="line-big">
				<div class="x6">
					<div class="nsd_wrap"> 
						<div class="nsd_nn">
							<div class="r_title"><p>我要留言</p></div>
							<div class="r_body plr10">
								<form method="post" action="<%=spth%>message.asp">
									<div class="form-group">
										<div class="label"><label for="m_name">您的姓名/Your name</label></div>
										<div class="field"><input id="m_name" class="input" type="text" name="m_name" value="<%=iif(member_login,member_tname,"")%>" size="60" data-validate="required:请填写姓名"/></div>
									</div>
									<div class="form-group">
										<div class="label"><label for="m_tel">联系电话/Tel</label></div>
										<div class="field"><input id="m_tel" class="input" type="text" name="m_tel" value="<%=iif(member_login,member_tel,"")%>" size="60" data-validate="mobile:填写合法的手机号"/></div>
									</div>
									<div class="form-group">
										<div class="label"><label for="m_qq">腾讯/QQ</label></div>
										<div class="field"><input id="m_qq" class="input" type="text" name="m_qq" value="<%=iif(member_login,member_qq,"")%>" size="60" /></div>
									</div>
									<div class="form-group">
										<div class="label"><label for="m_weixin">微信</label></div>
										<div class="field"><input id="m_qq" class="input" type="text" name="m_qq" value="<%=iif(member_login,member_weixin,"")%>" size="60" /></div>
									</div>
									<div class="form-group">
										<div class="label"><label for="m_email">电子邮件/Email</label></div>
										<div class="field"><input id="m_email" class="input" type="text" name="m_email" value="<%=iif(member_login,member_email,"")%>" size="60" /></div>
									</div>
									<div class="form-group">
										<div class="label"><label for="m_cname">公司名称/Company</label></div>
										<div class="field"><input id="m_cname" class="input" type="text" name="m_cname" value="" size="40" /></div>
									</div>
									<div class="form-group">
										<div class="label"><label for="m_address">联系地址/Atdress</label></div>
										<div class="field"><input id="m_address" class="input" type="text" name="m_address" value="<%=iif(member_login,member_address,"")%>" size="60"/></div>
									</div>
									<div class="form-group">
										<div class="label"><label for="m_content">留言内容/Content</label></div>
										<div class="field"> <textarea name="m_content" id="m_content" class="input" data-validate="required:请填写留言内容">
										</textarea></div>
									</div>
									<div class="form-group">
										<div class="label"><label for="verifycode">验证码</label> <img src="../system/verifycode.asp" onclick="javascript:this.src='../system/verifycode.asp?tm='+Math.random()" style="background:#EEEEEE; padding:5px; cursor:pointer;" alt="点击更换" title="点击更换" /></div>
										<div class="field">
											<input id="verifycode" class="input" name="verifycode" type="text" data-validate="required:请填写验证码" value="" />
										</div>
									</div>							
									<div class="form-group">
										<div class="label"><label></label></div>
										<div class="field">
											<input id="save" class="btn btn bg-red" name="save" type="submit" value="提交留言" />
										</div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>				
				<div class="x6">
					<div class="nsd_wrap">
						<div class="nsd_nn">
							<div class="r_title "><p>留言提示</p></div>
							<div class="r_body">
								<div class="con_mes p10"><p><%=system_m_prompt%></p></div>
							</div>
						</div>
					</div>
				</div>				
				<div class="fc"></div>
				<div class="x12">
					<div class="nsd_wrap bg-white">
						<div class="nsd_nn">
							<div class="r_title"><p>留言列表<p> </div>
							<div class="r_body p10">
								<%
									sql = "select * from cms_message  where m_enable = 1 order by id desc"
									page_size=10
									pager = pageturner_handle(sql, "id", page_size)
									Set rs = pager(0)
									Do While Not rs.EOF
								%>
								<div class="panel mb10">
									<div class="panel-hd"><span class="fa fa-user"></span> <%=rs("m_name")%> <span class="badge fr"><%=rs("m_date")%></span></div>
									<div class="panel-bd">
										<%=rs("m_content")%>
										<%If Not inull(rs("m_answer")) Then%>
										<div class="quote border-gray mt10">
											<div class="mb10"><span class="badge bg-dot">站长回复</span> <span class="badge"><%=rs("m_cdate")%></span></div>
											<%=rs("m_answer")%> </div>
										<%End If%>
									</div>
									
								</div>
								<%
								rs.movenext
								Loop
								rs.Close
								Set rs = Nothing
								%>
								<div class="fc"></div>
								<%=pageturner_show(pager(1),pager(2),pager(3),page_size,5)%>
							</div>
						</div> 
					</div>
				</div>	
			</div>
		</div>
	</div>
</div>
<!--#include file="inc_footer.asp"-->
</div>
</body>
</html>
