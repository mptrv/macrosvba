@echo off
Setlocal

:: Instalador de M�todos Autom�ticos
:: ========== == ======= ===========
::
:: M�todos Autom�ticos s�o m�dulos que fazem parte do Sistema Hor�rios.


:: Diret�rios de origem e destino.

::set dir_origem=%%T
set dir_origem="E:\Projetos\macrosvba\metodos-automaticos\tmp\instalador"

::set dir_dest=%HOMEPATH%\Documentos
set dir_dest=E:\Projetos\macrosvba\metodos-automaticos\tmp\instalador\Documentos
::if not exist %dir_dest% set dir_dest=%HOMEPATH%\Documents
if not exist %dir_dest% set dir_dest=E:\Projetos\macrosvba\metodos-automaticos\tmp\instalador\Documents
if not exist %dir_dest% md %dir_dest%

set dir_dest="%dir_dest%\Metodos Automaticos"
md %dir_dest%

:: C�pia dos arquivos para o destino.

robocopy %dir_origem% %dir_dest% * /xf instalador.cmd /xd Documents /xd Documentos /e

:: Cria��o de diret�rios vazios utilizados pelas aplica��es.

md %dir_dest%\relatorios

:: Cria��o dos �cones na �rea de trabalho.
:: ...

pause
Endlocal
