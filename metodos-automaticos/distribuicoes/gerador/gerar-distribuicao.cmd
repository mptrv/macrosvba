@echo off
Setlocal

:: Gerador de Distribui��o de M�todos Autom�ticos
:: ======= == ============ == ======= ===========
::
:: M�todos Autom�ticos s�o m�dulos que fazem parte do Sistema Hor�rios.


:: Diret�rios relativos.

set dirbase=..\..
set dirdist=..

:: Montagem do nome da distribui��o.

if [%1] == [] goto sintaxe

set nomedist=metodos-automaticos-%1

if exist %dirdist%\%nomedist%.7z goto distexistente
if exist %dirdist%\%nomedist%.exe goto distexistente

:: Compacta��o dos arquivos.

pushd %dirbase%
7z a distribuicoes\%nomedist%.7z @distribuicoes\gerador\arquivos-distribuicao.txt
popd

:: Adi��o do instalador.

7z a %dirdist%\%nomedist%.7z instalador.cmd > nul

:: Cria��o do arquivo auto-extr�til.

copy /b 7zS.sfx + config.txt + %dirdist%\%nomedist%.7z %dirdist%\%nomedist%.exe > nul

:: Exclus�o do arquivo compactado.

del %dirdist%\%nomedist%.7z

:: Finaliza��o.

echo.
echo Finalizado!

goto fim

:: Mensagens

:sintaxe
echo.
echo Uso: gerar-distribuicao VERSAO
echo.
echo Por favor, informar a vers�o.
goto fim

:distexistente
echo.
echo Distribui��o existente.
goto fim


:fim
Endlocal
