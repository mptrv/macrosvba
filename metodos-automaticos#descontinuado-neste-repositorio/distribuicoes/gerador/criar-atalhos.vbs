' Parte do Instalador de Métodos Automáticos
' ===== == ========== == ======= ===========
' Complementos da instalação.
'
' Métodos Automáticos são módulos que fazem parte do Sistema Horários.

' ---------------------------------------------------
' Rotinas e Funções

Public oWS
Public dir_origem
Public dir_dest

Private Sub CriarAtalhos()

	area_trab = oWS.SpecialFolders("Desktop")

	sLinkFile = area_trab & "\Construção Grade Horária.lnk"

	Set oLink = oWS.CreateShortcut(sLinkFile)
		oLink.TargetPath = dir_dest & "\macros\construcao-grade_horaria.xlsm"
		oLink.Arguments = ""
		oLink.Description = "Construção Grade Horária - Sistema de Horários"
		oLink.HotKey = "ALT+CTRL+G"
		oLink.IconLocation = dir_dest & "\imagens\cgh.ico"
		oLink.WindowStyle = "1"
		oLink.WorkingDirectory = dir_dest & "\macros"
	oLink.Save
	Set oLink = nothing

	sLinkFile = area_trab & "\Consulta Sistema Horários.lnk"

	Set oLink = oWS.CreateShortcut(sLinkFile)
		oLink.TargetPath = dir_dest & "\macros\consulta-sistema-horarios-oficial.accdr"
		oLink.Arguments = ""
		oLink.Description = "Consulta Sistema Horários - Sistema de Horários"
		oLink.HotKey = "ALT+CTRL+C"
		oLink.IconLocation = dir_dest & "\imagens\csh.ico"
		oLink.WindowStyle = "1"
		oLink.WorkingDirectory = dir_dest & "\macros"
	oLink.Save
	Set oLink = nothing

End Sub

Private Sub InstalarSQLNCLI()	

	Set oFS = WScript.CreateObject("Scripting.FileSystemObject")

	' Identificação do diretório do sistema.
	dirsystem = oWS.Environment("PROCESS").Item("SYSTEMROOT") & "\System"

	' Identificação da arquitetura do processador (é a da instalação do Windows?)
	arquitetura = "x86"
	if (oWS.Environment("PROCESS").Item("PROCESSOR_ARCHITEW6432") = "AMD64") or _
	   (oWS.Environment("PROCESS").Item("PROCESSOR_ARCHITECTURE") = "AMD64") then _
	   	arquitetura = "amd64"

	' Instalação do 'driver' apenas se não instalado.
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

		' TODO: Configurar ODBC: instalar, ajustar PATH, criar conexão de sistema,
		' criar TNSNAMES.ora.
			  
End Sub		

' ---------------------------------------------------
' Programa Principal

' Definições de variáveis globais.

Set oWS = WScript.CreateObject("WScript.Shell")

dir_origem = oWS.Environment("PROCESS").Item("DIR_ORIGEM")
dir_dest = oWS.Environment("PROCESS").Item("DIR_DEST")

' Instalações

CriarAtalhos
InstalarSQLNCLI
InstalarInstantClient

' Mensagem de conclusão.

MsgBox _
		  "Instalação Concluída!" & vblf & vblf & _
		  "Os atalhos foram criados na área de trabalho.", _
		  vbOKOnly + vbInformation, _
		  "Métodos Automáticos - Sistema Horários"

Set oWS = nothing
