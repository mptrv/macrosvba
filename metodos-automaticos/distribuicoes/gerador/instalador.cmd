@echo off
Setlocal

:: Instalador de Métodos Automáticos
:: ========== == ======= ===========
::
:: Métodos Automáticos são módulos que fazem parte do Sistema Horários.


:: Diretórios de origem e destino.

::set dir_origem=%%T
set dir_origem="E:\Projetos\macrosvba\metodos-automaticos\tmp\instalador"

::set dir_dest=%HOMEPATH%\Documentos
set dir_dest=E:\Projetos\macrosvba\metodos-automaticos\tmp\instalador\Documentos
::if not exist %dir_dest% set dir_dest=%HOMEPATH%\Documents
if not exist %dir_dest% set dir_dest=E:\Projetos\macrosvba\metodos-automaticos\tmp\instalador\Documents
if not exist %dir_dest% md %dir_dest%

set dir_dest="%dir_dest%\Metodos Automaticos"
md %dir_dest%

:: Cópia dos arquivos para o destino.

robocopy %dir_origem% %dir_dest% * /xf instalador.cmd /xd Documents /xd Documentos /e

:: Criação de diretórios vazios utilizados pelas aplicações.

md %dir_dest%\relatorios

:: Criação dos ícones na área de trabalho.
:: ...

pause
Endlocal
