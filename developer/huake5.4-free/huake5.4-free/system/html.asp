<%
'该程序通过使用ASP的FSO功能，减少数据库的读取。经测试，可以减少90%的服务器负荷。页面访问速度基本与静态页面相当。
'使用方法：将该文件放在网站里，然后在需要引用的文件的“第一行”用include引用即可。如有问题，可以反馈supfree@gmail.com

'=======================参数区=============================

DirName="txt\"  '静态文件保存的目录，结尾应带"\"。无须手动建立，程序会自动建立。
TimeDelay=1440      '更新的时间间隔，单位为分钟，如1440分钟为1天。生成的静态文件在该间隔之后会被删除。

'======================主程序区============================

foxrax=Request("foxrax")
if foxrax="" then
	FileName=GetStr()&".txt"
	FileName=replace(FileName,"/","xi")
	FileName=replace(FileName,"?","we")
	FileName=replace(FileName,"\","fa")
	FileName=DirName&FileName
	if tesfold(DirName)=false then
		createfold(Server.MapPath(".")&"\"&DirName)
	end if	
	if ReportFileStatus(Server.MapPath(".")&"\"&FileName)=true then
		List=ReadFile(FileName)
	else
		List=getHTTPPage(GetUrl())&"!@#$%"&now()
		WriteFile(FileName)
	end if
	Lists=split(List,"!@#$%")
	if DateDiff("n",Lists(1),now())>TimeDelay then
		del_file(FileName)
	end if
	Response.write Lists(0)
	Response.end
end if


'========================函数区============================

'获取当前页面url
Function GetStr() 
On Error Resume Next 
Dim strTemps 
strTemps = strTemps & Request.ServerVariables("URL") 
If Trim(Request.QueryString) <> "" Then 
	strTemps = strTemps & "?" & Trim(Request.QueryString) 
else
	strTemps = strTemps 
end if
GetStr = strTemps 
End Function

'获取缓存页面url
Function GetUrl() 
On Error Resume Next 
Dim strTemp 
If LCase(Request.ServerVariables("HTTPS")) = "off" Then 
	 strTemp = "http://"
Else 
	 strTemp = "https://"
End If 
strTemp = strTemp & Request.ServerVariables("SERVER_NAME") 
If Request.ServerVariables("SERVER_PORT") <> 80 Then 
	 strTemp = strTemp & ":" & Request.ServerVariables("SERVER_PORT") 
end if
strTemp = strTemp & Request.ServerVariables("URL") 
If Trim(Request.QueryString) <> "" Then 
	 strTemp = strTemp & "?" & Trim(Request.QueryString) & "&foxrax=foxrax"
else
	 strTemp = strTemp & "?" & "foxrax=foxrax"
end if
GetUrl = strTemp 
End Function


'抓取页面
Function getHTTPPage(url)
	Set Mail1 = Server.CreateObject("CDO.Message")
	Mail1.CreateMHTMLBody URL,31
	AA=Mail1.HTMLBody
	Set Mail1 = Nothing
	getHTTPPage=AA
End Function

'写入文件
Function WriteFile(filename)
	set fso=createobject("scripting.filesystemobject")
	filepathx=server.mappath(filename)
	set f=fso.createtextfile(filepathx,true)
	f.writeline(list)
	f.close
End Function

'读取文件
Public Function ReadFile( xVar )
	xVar = Server.Mappath(xVar)
	Set Sys = Server.CreateObject("Scripting.FileSystemObject") 
	If Sys.FileExists( xVar ) Then 
	Set Txt = Sys.OpenTextFile( xVar, 1 ) 
	msg = Txt.ReadAll
	Txt.Close 
	Else
	msg = "无"
	End If 
	Set Sys = Nothing
	ReadFile = msg
End Function

'检测文件是否存在
Function ReportFileStatus(FileName)
	set fso = server.createobject("scripting.filesystemobject")
	if fso.fileexists(FileName) = true then
	    ReportFileStatus=true
	    else
	    ReportFileStatus=false
	end if 
	set fso=nothing
end function

'检测目录是否存在
function tesfold(foname) 
   set fs=createobject("scripting.filesystemobject")
   filepathjm=server.mappath(foname)
   if fs.folderexists(filepathjm) then
      tesfold=True
   else
      tesfold= False
   end if
   set fs=nothing
end function

 '建立目录
sub createfold(foname) 
   set fs=createobject("scripting.filesystemobject")
   fs.createfolder(foname)
   set fs=nothing
end sub

'删除文件
function del_file(path)      'path，文件路径包含文件名
set objfso = server.createobject("scripting.FileSystemObject")
'path=Server.MapPath(path)
if objfso.FileExists(path) then     '若存在则删除
	objfso.DeleteFile(path)         '删除文件
else
	'response.write "<script language='Javascript'>alert('文件不存在')</script>"
end if 
set objfso = nothing
end function	
%>