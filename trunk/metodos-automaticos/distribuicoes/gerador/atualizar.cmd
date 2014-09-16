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
\\maua.br\sistemahorarios\metodos-automaticos-%1-a.exe
