:: Sitema Hor�rios - M�todos Autom�ticos
::
:: * Este arquivo dever� residir no diret�rio do reposit�rio. *
::
:: A fun��o Shell() do VBA n�o consegue disparar o pacote de instala��o,
:: durante processo de auto-atualiza��o. Portanto, este arquivo � utilizado
:: como intermedi�rio.
::
:: Deve-se fornecer a vers�o de M�todos Autom�ticos desejada.
::
:: Nenhuma verifica��o especial � realizada ao argumento fornecido, a n�o
:: ser seu fornecimento.

@echo off

if [%1] == [] goto :eof

if not exist \\maua.br\sistemahorarios\metodos-automaticos-%1-a.exe (
	echo.
	echo * FALHA NA ATUALIZACAO! *
	echo.
	echo O arquivo de atualizacao nao foi encontrado.
	echo Por favor, entre em contato com o departamento de TI ^(gti@maua.br^).
	echo.
	pause
	goto :eof
)

:: Espera o fechamento de algum programa.
:: (Atualmente, devido a atualiza��o a partir de "Constru��o Grade Hor�ria".)
timeout 1 /nobreak > nul

:: Dispara a atualiza��o.
\\maua.br\sistemahorarios\metodos-automaticos-%1-a.exe
