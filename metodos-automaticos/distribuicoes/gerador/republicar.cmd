@echo off
SetLocal
:: ========================================================
:: Publicação da distribuição na rede
:: ========================================================

:: Montagem do nome da distribuição e diretórios.

set versao=%1
if [%1] == [] goto pedirversao

:continuar
set nomedist=metodos-automaticos-%versao%
set dirdist=..
set dirrede=\\maua.br\sistemahorarios

:: Cópia para a rede.
 
echo.
echo Copiando distribuicao: %nomedist%
echo   para: %dirrede%...
robocopy %dirdist% %dirrede% %nomedist%* > nul
echo Concluido.

goto :eof

:: ========================================================
:: Entradas de usuário

:pedirversao
set /p versao=Por favor, informar a versao: 
if errorlevel 1 goto sintaxe
goto continuar

:: ========================================================
:: Mensagens

:sintaxe
echo.
echo Uso: republicar VERSAO
echo.
echo Por favor, informar a versao.
goto :eof
