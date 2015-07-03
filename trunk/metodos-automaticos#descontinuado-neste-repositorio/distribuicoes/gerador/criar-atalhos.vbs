' Parte do Instalador de M�todos Autom�ticos
' ===== == ========== == ======= ===========
' Complementos da instala��o.
'
' M�todos Autom�ticos s�o m�dulos que fazem parte do Sistema Hor�rios.

' ---------------------------------------------------
' Rotinas e Fun��es

Public oWS
Public dir_origem
Public dir_dest

Private Sub CriarAtalhos()

	area_trab = oWS.SpecialFolders("Desktop")

	sLinkFile = area_trab & "\Constru��o Grade Hor�ria.lnk"

	Set oLink = oWS.CreateShortcut(sLinkFile)
		oLink.TargetPath = dir_dest & "\macros\construcao-grade_horaria.xlsm"
		oLink.Arguments = ""
		oLink.Description = "Constru��o Grade Hor�ria - Sistema de Hor�rios"
		oLink.HotKey = "ALT+CTRL+G"
		oLink.IconLocation = dir_dest & "\imagens\cgh.ico"
		oLink.WindowStyle = "1"
		oLink.WorkingDirectory = dir_dest & "\macros"
	oLink.Save
	Set oLink = nothing

	sLinkFile = area_trab & "\Consulta Sistema Hor�rios.lnk"

	Set oLink = oWS.CreateShortcut(sLinkFile)
		oLink.TargetPath = dir_dest & "\macros\consulta-sistema-horarios-oficial.accdr"
		oLink.Arguments = ""
		oLink.Description = "Consulta Sistema Hor�rios - Sistema de Hor�rios"
		oLink.HotKey = "ALT+CTRL+C"
		oLink.IconLocation = dir_dest & "\imagens\csh.ico"
		oLink.WindowStyle = "1"
		oLink.WorkingDirectory = dir_dest & "\macros"
	oLink.Save
	Set oLink = nothing

End Sub

Private Sub InstalarSQLNCLI()	

	Set oFS = WScript.CreateObject("Scripting.FileSystemObject")

	' Identifica��o do diret�rio do sistema.
	dirsystem = oWS.Environment("PROCESS").Item("SYSTEMROOT") & "\System"

	' Identifica��o da arquitetura do processador (� a da instala��o do Windows?)
	arquitetura = "x86"
	if (oWS.Environment("PROCESS").Item("PROCESSOR_ARCHITEW6432") = "AMD64") or _
	   (oWS.Environment("PROCESS").Item("PROCESSOR_ARCHITECTURE") = "AMD64") then _
	   	arquitetura = "amd64"

	' Instala��o do 'driver' apenas se n�o instalado.
	if not (oFS.FileExists(dirsystem & "\sqlncli10.dll") or _
		oFS.FileExists(dirsystem & "32\sqlncli10.dll")) then

		msgbox "A executar: " & "msiexec IACCEPTSQLNCLILICENSETERMS=YES /i " & _
			dir_origem & "\redistribuiveis\sqlncli_" & arquitetura & ".msi"
		oWS.Run "msiexec IACCEPTSQLNCLILICENSETERMS=YES /i " & _
			dir_origem & "\redistribuiveis\sqlncli_" & arquitetura & ".msi"
		'TODO: depurar o efeito de se inserir "IACCEPTSQLNCLILICENSETERMS=YES".

	end if			  	

End Sub

Private Sub InstalarInstantClient()

	' TODO: Depurar.

	oWS.Run "robocopy " & dir_origem & "\redistribuiveis\instantclient_12_1 " & _
		"c:\oracle\instantclient_12_1 " & "* /e > nul"

	oWS.Run "c:\oracle\instantclient_12_1\odbc_install.exe"

		' TODO: Configurar ODBC: instalar, ajustar PATH, criar conex�o de sistema,
		' criar TNSNAMES.ora.
			  
End Sub		

' ---------------------------------------------------
' Programa Principal

' Defini��es de vari�veis globais.

Set oWS = WScript.CreateObject("WScript.Shell")

dir_origem = oWS.Environment("PROCESS").Item("DIR_ORIGEM")
dir_dest = oWS.Environment("PROCESS").Item("DIR_DEST")

' Instala��es

CriarAtalhos
InstalarSQLNCLI
InstalarInstantClient

' Mensagem de conclus�o.

MsgBox _
		  "Instala��o Conclu�da!" & vblf & vblf & _
		  "Os atalhos foram criados na �rea de trabalho.", _
		  vbOKOnly + vbInformation, _
		  "M�todos Autom�ticos - Sistema Hor�rios"

Set oWS = nothing
