<%
Response.Charset = "utf-8"
Session.CodePage = "65001"
Dim s_path,data_path,connstr,conn
s_path = "/"
data_path = ""&s_path&"data/#huakedata.mdb"
connstr = "Provider = Microsoft.Jet.OLEDB.4.0; Data Source = "&Server.MapPath(data_path)&""
Set conn = Server.CreateObject("ADODB.CONNECTION")
conn.Open connstr
%>
