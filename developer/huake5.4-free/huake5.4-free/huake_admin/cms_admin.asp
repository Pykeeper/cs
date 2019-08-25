<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--#include file="inc.asp"-->
<%
current_navigation = "cms_admin"
Call check_admin_purview("cms_admin")
If Not inull(rf("save")) Then
	Call null_back(rf("a_name"),"请填写用户名")
	Set rs = ado_mquery("select * from cms_admin")
	If rf("a_name") = rs("a_name") Then
		Call alert_back("已有同名用户存在请更换！")
	End If  
	rs.Update
	rs.Close
	Set rs = Nothing
	Set rs = ado_mquery("select * from cms_admin")
	rs.AddNew
	rs("a_enable") = rf("a_enable")
	rs("a_name") = rf("a_name")
	rs("a_password") = md5(rf("a_password"))
	rs("a_tname") = rf("a_tname")
	rs("a_penname") = rf("a_penname")
	rs("a_des") = rf("a_des")
	rs("a_purview") = rf("a_purview")
	rs.Update
	rs.Close
	Set rs = Nothing
	Call alert_href("新用户添加成功","cms_admin.asp")
End If 	
If Not inull(rq("del")) Then 
	conn.Execute("delete from cms_admin where id ="&rq("del")&"")
	Call alert_href("删除成功","cms_admin.asp")
End If 
If Not inull(rq("pwd")) Then 
	Call non_numeric_back(rq("pwd"),"参数非法")
	conn.Execute("update cms_admin set a_password = '"&md5("123456")&"' where id = "&rq("pwd")&"")
	Call alert_href("密码重置成功","cms_admin.asp")
End If 
%>
</head>
<body>
<div id="content_main">
	<!--#include file="inc_header.asp"-->
	<div id="content">
		<div id="left"><!--#include file="inc_left.asp"--></div>
		<div id="right">
			<div class="content_h pl10">添加用户</div>
			<div class="content_b mtb10">
				<form method="post">
					<div class="l10">
						<div class="x3">
							<div class="form-group">
								<div class="label"><label for="a_enable">状态</label></div>
								<div class="field">
									<div class="btn"><input type="radio" name="a_enable" value="1" checked="checked"/> 启用</div>
									<div class="btn"><input type="radio" name="a_enable" value="0"/> 禁用</div>
								</div>
							</div>
						</div>						
						<div class="x9">
							<div class="form-group">
								<div class="label"><label for="a_name">用户名</label> <span class="badge bg-dot">必填</span></div>
								<div class="field">
									<input id="a_name" class="input" type="text" name="a_name" value="" data-validate="required:必填" size="100"/> 
								</div>
								<div class="input-note">请填写用户名</div>
							</div>
						</div>
						<div class="fc"></div>						
						<div class="x6">
							<div class="form-group">
								<div class="label"><label for="a_password">登录密码</label> <span class="badge bg-dot">必填</span></div>
								<div class="field">
									<input id="a_password" class="input" type="password" name="a_password" value="" data-validate="required:必填" size="100"/> 
								</div>
								<div class="input-note">请填写登录密码</div>
							</div>
						</div>						
						<div class="x6">
							<div class="form-group">
								<div class="label"><label for="a_cpassword">确认密码</label> <span class="badge bg-dot">必填</span></div>
								<div class="field">
									<input id="a_cpassword" class="input" type="password" name="a_cpassword" value="" data-validate="required:请填写确认密码,repeat#a_password:两次输入的密码不一致" size="100"/> 
								</div>
								<div class="input-note">请重复登录密码</div>
							</div>
						</div>	
						<div class="fc"></div>		
						<div class="x4">
							<div class="form-group">
								<div class="label"><label for="a_tname">真实姓名</label></div>
								<div class="field">
									<input id="a_tname" class="input" type="text" name="a_tname" value="" size="100"/>
								</div>
							</div>
						</div>				
						<div class="x4">
							<div class="form-group">
								<div class="label"><label for="a_penname">笔名</label></div>
								<div class="field">
									<input id="a_penname" class="input" type="text" name="a_penname" value="" size="100"/>
								</div>
							</div>
						</div>
						<div class="x4">
							<div class="form-group">
								<div class="label"><label for="a_des">描述</label></div>
								<div class="field">
									<input id="a_des" class="input" type="text" name="a_des" value="" size="100"/>
								</div>
							</div>
						</div>
						<div class="fc"></div>	
						<div class="x12">
							<div class="form-group">
								<div class="label"><label for="a_purview">权限</label></div>
								<div class="field">
									<input type="hidden" name="a_purview" value="huakecmsaspcms" />
									<label class="btn">添加内容 <input name="a_purview" type="checkbox" checked="checked" value="cms_content_add"/></label>
									<label class="btn">管理内容 <input name="a_purview" type="checkbox" checked="checked" value="cms_content"/></label>
									<label class="btn">添加频道 <input name="a_purview" type="checkbox" checked="checked" value="cms_nav_add"/></label>
									<label class="btn">管理频道 <input name="a_purview" type="checkbox" checked="checked" value="cms_nav"/></label>
									<label class="btn">管理幻灯 <input name="a_purview" type="checkbox" checked="checked" value="cms_banner"/></label>
									<label class="btn">管理客服 <input name="a_purview" type="checkbox" checked="checked" value="cms_service"/></label>
									<label class="btn">碎片管理 <input name="a_purview" type="checkbox" checked="checked" value="cms_chip"/></label>
								</div>
								<div class="field">
									<label class="btn">管理留言 <input name="a_purview" type="checkbox" checked="checked" value="cms_message"/></label>
									<label class="btn">管理链接 <input name="a_purview" type="checkbox" checked="checked" value="cms_link"/></label>
								</div>
								<div class="field">
									<label class="btn">系统设置 <input name="a_purview" type="checkbox" checked="checked" value="cms_system"/></label>
									<label class="btn">管理用户 <input name="a_purview" type="checkbox" value="cms_admin"/></label>
									<label class="btn">模板管理 <input name="a_purview" type="checkbox" checked="checked" value="cms_template"/></label>
									<label class="btn">站内链接 <input name="a_purview" type="checkbox" checked="checked" value="cms_sitelink"/></label>
								</div>

							</div>
						</div>			
						<div class="x12">
							<div class="form-group">
								<div class="label"><label for=""></label></div>
								<div class="field">
									<input id="save" class="btn bg-dot" type="submit" name="save" value="添加新用户" />
								</div>
							</div>
						</div>
					</div>
				</form>
			</div>
			<div class="content_f"></div>
			<div class="content_h pl10">管理用户</div>
			<div class="content_b mtb10">
				<form method="post" class="form-auto">
					<table class="table table-bordered table-striped table-hover">
						<tr>
						<th width="60">ID</th>
						<th width="60">状态</th>
						<th>用户名</th>
						<th>真实姓名</th>
						<th>笔名</th>
						<th>描述</th>
						<th>操作</th>
						</tr>
						<%
						Set rs = ado_query("select * from cms_admin order by id desc")
						Do While Not rs.EOF
						%>
						<tr <%=iif(rs("a_name")="技术维护","class=""hide""","")%>>
							<td align="center"><%=rs("id")%></td>
							<td align="center"><%=iif(rs("a_enable") = 1,"启用","<span class=""badge"">禁用</span>")%></td>
							<td align="center"><%=rs("a_name")%></td>
							<td align="center"><%=rs("a_tname")%></td>
							<td align="center"><%=rs("a_penname")%></td>
							<td align="center"><%=rs("a_des")%></td>
							<td align="center"><a class="btn bg-blue" href="cms_admin_edit.asp?id=<%=rs("id")%>"> <span class="fa fa-edit"></span> 编辑</a> <a class="btn bg-main" href="cms_admin.asp?pwd=<%=rs("id")%>" onclick="return confirm('确定要把此用户的密码重置成123456吗？')"><span class="fa fa-key"> </span> 重置密码</a> <a class="btn bg-red" <%=iif(rs("id") = 1,"style=""display:none;""","")%> href="cms_admin.asp?del=<%=rs("id")%>" onclick="return confirm('确定要删除此用户吗？')"><span class="fa fa-trash"></span> 删除</a></td>
						</tr>
						<%
						rs.MoveNext
						Loop
						rs.Close
						Set rs = Nothing
						%>	
					</table>
				</form>
			</div>
			<div class="content_f">	
				<div class="quote border-red mb10">ID为"1"的用户不能删除、禁用</div>
			</div>			
		</div>
		<div class="fc"></div>
	</div>
	<!--#include file="inc_footer.asp"-->
</div>
</body>
</html>
