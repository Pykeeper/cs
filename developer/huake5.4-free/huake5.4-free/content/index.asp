<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="../system/inc.asp"-->
<%
tmparr = Split(str_safe(str_query("")), ".")
Set rs = ado_query("select * from cms_content where c_fname = '"&tmparr(t0)&"' ")
%>
<!--#include file="../system/content.asp"-->