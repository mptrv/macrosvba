:: Sitema Horários - Métodos Automáticos
::
:: * Este arquivo deverá residir no diretório do repositório. *
::
:: A função Shell() do VBA não consegue disparar o pacote de instalação,
:: durante processo de auto-atualização. Portanto, este arquivo é utilizado
:: como intermediário.
::
:: Deve-se fornecer a versão de Métodos Automáticos desejada.
::
:: Nenhuma verificação especial é realizada ao argumento fornecido, a não
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
:: (Atualmente, devido a atualização a partir de "Construção Grade Horária".)
timeout 1 /nobreak > nul

:: Dispara a atualização.
\\maua.br\sistemahorarios\metodos-automaticos-%1-a.exe
