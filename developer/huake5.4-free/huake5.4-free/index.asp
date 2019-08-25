<%@LANGUAGE="VBSCRIPT" CODEPAGE="65001"%>
<!--#include file="system/inc.asp"-->
<%
current_navigation = "index.asp"
 if ismobi() then
    echo ob_get_contents(mskin&"index.asp")
else
    echo ob_get_contents(skin&"index.asp")
end If
%>