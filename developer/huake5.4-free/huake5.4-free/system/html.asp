<%
'�ó���ͨ��ʹ��ASP��FSO���ܣ��������ݿ�Ķ�ȡ�������ԣ����Լ���90%�ķ��������ɡ�ҳ������ٶȻ����뾲̬ҳ���൱��
'ʹ�÷����������ļ�������վ�Ȼ������Ҫ���õ��ļ��ġ���һ�С���include���ü��ɡ��������⣬���Է���supfree@gmail.com

'=======================������=============================

DirName="txt\"  '��̬�ļ������Ŀ¼����βӦ��"\"�������ֶ�������������Զ�������
TimeDelay=1440      '���µ�ʱ��������λΪ���ӣ���1440����Ϊ1�졣���ɵľ�̬�ļ��ڸü��֮��ᱻɾ����

'======================��������============================

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


'========================������============================

'��ȡ��ǰҳ��url
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

'��ȡ����ҳ��url
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


'ץȡҳ��
Function getHTTPPage(url)
	Set Mail1 = Server.CreateObject("CDO.Message")
	Mail1.CreateMHTMLBody URL,31
	AA=Mail1.HTMLBody
	Set Mail1 = Nothing
	getHTTPPage=AA
End Function

'д���ļ�
Function WriteFile(filename)
	set fso=createobject("scripting.filesystemobject")
	filepathx=server.mappath(filename)
	set f=fso.createtextfile(filepathx,true)
	f.writeline(list)
	f.close
End Function

'��ȡ�ļ�
Public Function ReadFile( xVar )
	xVar = Server.Mappath(xVar)
	Set Sys = Server.CreateObject("Scripting.FileSystemObject") 
	If Sys.FileExists( xVar ) Then 
	Set Txt = Sys.OpenTextFile( xVar, 1 ) 
	msg = Txt.ReadAll
	Txt.Close 
	Else
	msg = "��"
	End If 
	Set Sys = Nothing
	ReadFile = msg
End Function

'����ļ��Ƿ����
Function ReportFileStatus(FileName)
	set fso = server.createobject("scripting.filesystemobject")
	if fso.fileexists(FileName) = true then
	    ReportFileStatus=true
	    else
	    ReportFileStatus=false
	end if 
	set fso=nothing
end function

'���Ŀ¼�Ƿ����
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

 '����Ŀ¼
sub createfold(foname) 
   set fs=createobject("scripting.filesystemobject")
   fs.createfolder(foname)
   set fs=nothing
end sub

'ɾ���ļ�
function del_file(path)      'path���ļ�·�������ļ���
set objfso = server.createobject("scripting.FileSystemObject")
'path=Server.MapPath(path)
if objfso.FileExists(path) then     '��������ɾ��
	objfso.DeleteFile(path)         'ɾ���ļ�
else
	'response.write "<script language='Javascript'>alert('�ļ�������')</script>"
end if 
set objfso = nothing
end function	
%>