@echo off
Setlocal

:: Gerador de Distribui��o de M�todos Autom�ticos
:: ======= == ============ == ======= ===========
::
:: M�todos Autom�ticos s�o m�dulos que fazem parte do Sistema Hor�rios.


:: Montagem do nome da distribui��o e diret�rios.

set versao=%1
if [%1] == [] goto pedirversao

:continuar_de_pedirversao
set nomedist=metodos-automaticos-%versao%

call :construir_distribuicao %nomedist% i &:: distribui��o de instala��o
if %_result% EQU 0 call :construir_distribuicao %nomedist% a &:: distribui��o de atualiza��o

if %_result% EQU 1 goto distexistente

:: C�pia para o diret�rio de distribui��o da rede.

call republicar.cmd %versao%

:: Finaliza��o.

echo.
echo Distribuicao gerada: %nomedist%
echo.
echo Finalizado!

goto fim

:: ========================================================
:: Construir Distribui��o
::    Par�metros:
::      %1 : nome da distribui��o
::      %2 : modo de distribui��o: i - instala��o; a - atualiza��o
::    Retornos:
::       0 : sucesso
::       1 : distribui��o existente
:construir_distribuicao

SetLocal

:: Interpreta��o dos par�metros.

set nomedist=%1-%2
if [%2] == [i] set modo=instalacao
if [%2] == [a] set modo=atualizacao

:: Diret�rios relativos.

set dirbase=..\..
set dirdist=..

:: Verifica se a distribui��o j� existe.

if not exist %dirdist%\%nomedist%.7z if not exist %dirdist%\%nomedist%.exe goto continua

:: Retorno com c�digo de erro.
set _result=1
goto fim_construir_distribuicao

:continua

:: Compacta��o dos arquivos.

pushd %dirbase%

pushd macros
call gerar-accdr.cmd
popd

7z a distribuicoes\%nomedist%.7z @distribuicoes\gerador\arquivos-distribuicao-%modo%.txt

popd

:: Adi��o do instalador e scripts auxiliares.

if [%modo%] == [instalacao] 7z a %dirdist%\%nomedist%.7z instalador.cmd criar-atalhos.vbs > nul
if [%modo%] == [atualizacao] 7z a %dirdist%\%nomedist%.7z atualizador.cmd > nul

:: Cria��o do arquivo auto-extr�til.

copy /b 7zS.sfx + config-%modo%.txt + %dirdist%\%nomedist%.7z %dirdist%\%nomedist%.exe > nul

:: Exclus�o do arquivo compactado.

del %dirdist%\%nomedist%.7z

:: Retorno com sucesso.
set _result=0

:fim_construir_distribuicao
EndLocal & set _result=%_result%
goto :eof

:: ========================================================
:: Entradas de usu�rio

:pedirversao
set /p versao=Por favor, informar a versao: 
if errorlevel 1 goto sintaxe
goto continuar_de_pedirversao

:: ========================================================
:: Mensagens

:sintaxe
echo.
echo Uso: gerar-distribuicao VERSAO
echo.
echo Por favor, informar a versao.
goto fim

:distexistente
echo.
echo Distribuicao existente.
goto fim

:: ========================================================
:: Fim do 'script'
:fim
if [%1] == [] echo. & pause
Endlocal
