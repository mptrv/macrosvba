@echo off
Setlocal

:: Gerador de Distribuição de Métodos Automáticos
:: ======= == ============ == ======= ===========
::
:: Métodos Automáticos são módulos que fazem parte do Sistema Horários.


:: Diretórios relativos.

set dirbase=..\..
set dirdist=..

:: Montagem do nome da distribuição.

if [%1] == [] goto sintaxe

set nomedist=metodos-automaticos-%1

if exist %dirdist%\%nomedist%.7z goto distexistente
if exist %dirdist%\%nomedist%.exe goto distexistente

:: Compactação dos arquivos.

pushd %dirbase%
7z a distribuicoes\%nomedist%.7z @distribuicoes\gerador\arquivos-distribuicao.txt
popd

:: Adição do instalador.

7z a %dirdist%\%nomedist%.7z instalador.cmd > nul

:: Criação do arquivo auto-extrátil.

copy /b 7zS.sfx + config.txt + %dirdist%\%nomedist%.7z %dirdist%\%nomedist%.exe > nul

:: Exclusão do arquivo compactado.

del %dirdist%\%nomedist%.7z

:: Finalização.

echo.
echo Finalizado!

goto fim

:: Mensagens

:sintaxe
echo.
echo Uso: gerar-distribuicao VERSAO
echo.
echo Por favor, informar a versão.
goto fim

:distexistente
echo.
echo Distribuição existente.
goto fim


:fim
Endlocal
