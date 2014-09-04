@echo off
Setlocal

:: Gerador de Distribuição de Métodos Automáticos
:: ======= == ============ == ======= ===========
::
:: Métodos Automáticos são módulos que fazem parte do Sistema Horários.

if [%1] == [] (
	echo Por favor, informar o número da versão.
	exit
)

set nomedist=metodos-automaticos-%1

pushd ..
7z a distribuicoes\%nomedist%.7z @distribuicoes\arquivos-distribuicao.txt
popd

copy /b 7zS.sfx + config.txt + %nomedist%.7z %nomedist%.exe

Endlocal
