@echo off
Setlocal

:: Instalador de Métodos Automáticos
:: ========== == ======= ===========
::
:: Métodos Automáticos são módulos que fazem parte do Sistema Horários.
::
:: TODO: Avaliar: Reescrever todo este 'script' em VBS, junto com
:: criar-atalhos.vbs?


:: Diretórios de origem e destino.

set dir_origem=%~dp0

set dir_dest=%HOMEDRIVE%%HOMEPATH%\Documentos
if not exist "%dir_dest%" set dir_dest=%HOMEPATH%\Documents
if not exist "%dir_dest%" md "%dir_dest%"

set dir_dest=%dir_dest%\Metodos Automaticos
if not exist "%dir_dest%" md "%dir_dest%" &:: Já existente em atualizações.

:: Cópia dos arquivos para o destino.

robocopy %dir_origem% "%dir_dest%" * /xf instalador.cmd /xf criar-atalhos.vbs /e > nul

:: Criação de diretórios vazios utilizados pelas aplicações.

if not exist "%dir_dest%\relatorios" md "%dir_dest%\relatorios" &:: Já existente em atualizações.

:: Compartilhamento.
:: ...

:: Criação dos atalhos na área de trabalho e informação de conclusão.
 
cscript criar-atalhos.vbs //Nologo

:: Finalização.

Endlocal
