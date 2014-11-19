@echo off
Setlocal

:: Gerador de Distribuição de Métodos Automáticos
:: ======= == ============ == ======= ===========
::
:: Métodos Automáticos são módulos que fazem parte do Sistema Horários.


:: Montagem do nome da distribuição e diretórios.

set versao=%1
if [%1] == [] goto pedirversao

:continuar_de_pedirversao
set nomedist=metodos-automaticos-%versao%

call :construir_distribuicao %nomedist% i &:: distribuição de instalação
if %_result% EQU 0 call :construir_distribuicao %nomedist% a &:: distribuição de atualização

if %_result% EQU 1 goto distexistente

:: Cópia para o diretório de distribuição da rede.

call republicar.cmd %versao%

:: Finalização.

echo.
echo Distribuicao gerada: %nomedist%
echo.
echo Finalizado!

goto fim

:: ========================================================
:: Construir Distribuição
::    Parâmetros:
::      %1 : nome da distribuição
::      %2 : modo de distribuição: i - instalação; a - atualização
::    Retornos:
::       0 : sucesso
::       1 : distribuição existente
:construir_distribuicao

SetLocal

:: Interpretação dos parâmetros.

set nomedist=%1-%2
if [%2] == [i] set modo=instalacao
if [%2] == [a] set modo=atualizacao

:: Diretórios relativos.

set dirbase=..\..
set dirdist=..

:: Verifica se a distribuição já existe.

if not exist %dirdist%\%nomedist%.7z if not exist %dirdist%\%nomedist%.exe goto continua

:: Retorno com código de erro.
set _result=1
goto fim_construir_distribuicao

:continua

:: Compactação dos arquivos.

pushd %dirbase%

pushd macros
call gerar-accdr.cmd
popd

7z a distribuicoes\%nomedist%.7z @distribuicoes\gerador\arquivos-distribuicao-%modo%.txt

popd

:: Adição do instalador e scripts auxiliares.

if [%modo%] == [instalacao] 7z a %dirdist%\%nomedist%.7z instalador.cmd criar-atalhos.vbs > nul
if [%modo%] == [atualizacao] 7z a %dirdist%\%nomedist%.7z atualizador.cmd > nul

:: Criação do arquivo auto-extrátil.

copy /b 7zS.sfx + config-%modo%.txt + %dirdist%\%nomedist%.7z %dirdist%\%nomedist%.exe > nul

:: Exclusão do arquivo compactado.

del %dirdist%\%nomedist%.7z

:: Retorno com sucesso.
set _result=0

:fim_construir_distribuicao
EndLocal & set _result=%_result%
goto :eof

:: ========================================================
:: Entradas de usuário

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
