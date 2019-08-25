<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../system/inc.asp"-->
<%
tmparr = Split(str_safe(str_query("")),".")
Set rs = ado_query("select * from cms_nav where n_aname = '"&tmparr(t0)&"' ")
%>
<!--#include file="../system/nav.asp"-->