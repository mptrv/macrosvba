@echo off
Setlocal

:: Instalador de Métodos Automáticos
:: ========== == ======= ===========
::
:: Métodos Automáticos são módulos que fazem parte do Sistema Horários.


:: Diretórios de origem e destino.

set dir_origem=%~dp0

set dir_dest=%HOMEPATH%\Documentos
::set dir_dest=E:\Projetos\macrosvba\metodos-automaticos\tmp\instalador\Documentos
if not exist %dir_dest% set dir_dest=%HOMEPATH%\Documents
::if not exist %dir_dest% set dir_dest=E:\Projetos\macrosvba\metodos-automaticos\tmp\instalador\Documents
if not exist %dir_dest% md %dir_dest%

set dir_dest="%dir_dest%\Metodos Automaticos"
if not exist %dir_dest% md %dir_dest% &:: Já existente em atualizações.

:: Cópia dos arquivos para o destino.

robocopy %dir_origem% %dir_dest% * /xf instalador.cmd /xd Documents /xd Documentos /e > nul

:: Criação de diretórios vazios utilizados pelas aplicações.

if not exist %dir_dest%\relatorios md %dir_dest%\relatorios &:: Já existente em atualizações.

:: Criação dos ícones na área de trabalho.
:: ...

:: Compartilhamento.
:: ...

:: Finalização.

echo.
echo INSTALACAO CONCLUIDA!
echo.
echo Os atalhos encontram-se na area de trabalho.
echo.
pause

Endlocal

