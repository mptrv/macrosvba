@echo off
Setlocal

:: Gerador de Distribui��o de M�todos Autom�ticos
:: ======= == ============ == ======= ===========
::
:: M�todos Autom�ticos s�o m�dulos que fazem parte do Sistema Hor�rios.

if [%1] == [] (
	echo Por favor, informar o n�mero da vers�o.
	exit
)

set nomedist=metodos-automaticos-%1

pushd ..
7z a distribuicoes\%nomedist%.7z @distribuicoes\arquivos-distribuicao.txt
popd

copy /b 7zS.sfx + config.txt + %nomedist%.7z %nomedist%.exe

Endlocal
