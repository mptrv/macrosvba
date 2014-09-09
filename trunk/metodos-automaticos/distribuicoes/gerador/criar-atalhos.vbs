' Parte do Instalador de Métodos Automáticos
' ===== == ========== == ======= ===========
' Criação dos atalhos na área de trabalho
'
' Métodos Automáticos são módulos que fazem parte do Sistema Horários.

Set oWS = WScript.CreateObject("WScript.Shell")

dir_origem = oWS.Environment("PROCESS").Item("DIR_ORIGEM")
dir_dest = oWS.Environment("PROCESS").Item("DIR_DEST")
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

MsgBox _
	"Instalação Concluída!" & vblf & vblf & _
	"Os atalhos foram criados na área de trabalho.", _
	vbOKOnly + vbInformation, _
	"Métodos Automáticos - Sistema Horários"

Set oWS = nothing
