@echo off
Setlocal

:: Instalador de Métodos Automáticos
:: ========== == ======= ===========
::
:: Métodos Automáticos são módulos que fazem parte do Sistema Horários.

:: Diretórios de origem e destino.

set dir_origem=%~dp0

set dir_dest=%HOMEDRIVE%%HOMEPATH%\Documentos
if not exist "%dir_dest%" set dir_dest=%HOMEDRIVE%%HOMEPATH%\Documents
if not exist "%dir_dest%" goto dirdoc_nao_encontrado

set dir_dest=%dir_dest%\Metodos Automaticos
if not exist "%dir_dest%" goto dirma_nao_encontrado

:: Cópia dos arquivos para o destino.

robocopy %dir_origem% "%dir_dest%" * /xf atualizador.cmd /e > nul

:: Criação de diretórios vazios utilizados pelas aplicações.

if not exist "%dir_dest%\relatorios" md "%dir_dest%\relatorios" &:: Já existente em atualizações.

:: Mensagem final.
echo.
echo SUCESSO! A atualizacao foi realizada.

goto fim

:dirdoc_nao_encontrado
echo.
echo O diretório "Documentos" não foi encontrado.
echo.
echo ATUALIZACAO NAO REALIZADA!
goto fim

:dirma_nao_encontrado
echo.
echo O diretório da instalacao "Metodos Automaticos" não foi encontrado.
echo.
echo ATUALIZACAO NAO REALIZADA!
goto fim

:fim
echo.
pause
Endlocal
