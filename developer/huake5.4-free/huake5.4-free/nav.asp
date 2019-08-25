<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="system/inc.asp"-->
<%
If system_mode = 1 Then
	Call non_numeric_back(rqs("id"),"参数非法")
	sql= "select * from cms_nav where id = "&rqs("id")&""
Else
	sql = "select * from cms_nav where n_aname = '"&rqs("name")&"'"
End If
%>
<!--#include file="system/nav.asp"-->