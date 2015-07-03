
@echo off
if [%2] == [] (

   echo.
   echo Uso: svnco-distr versao-origem versao-destino

) else (

   echo.
   echo Realizando copia da versao em 'tags/'...
   svn co https://macrosvba.googlecode.com/svn/tags/metodos-automaticos-%1 metodos-automaticos-%2

   echo.
   echo Descompactando...
   cd metodos-automaticos-%2
   7z x metodos-automaticos-%1.7z
   
   echo.
   echo Removendo o controle de versao do arquivo...
   svn rm metodos-automaticos-%1.7z

   echo.
   echo Copiando as macros...
   copy /y ..\..\macros\construcao-grade_horaria.xlsm macros\construcao-grade_horaria.xlsm
   copy /y ..\..\macros\consulta-sistema-horarios-oficial.accdb macros\consulta-sistema-horarios-oficial.accdr

   echo.
   echo *** NESTE MOMENTO, PODEM-SE ACRESCENTAR OU AJUSTAR OUTROS ARQUIVOS! ***
   echo.
   pause

   echo.
   echo Compactando...
   7z a -r metodos-automaticos-%2.7z bases imagens logos macros modelos relatorios

   echo.
   echo Apagando diretorios...
   rd /s /q bases
   rd /s /q imagens
   rd /s /q logos
   rd /s /q macros
   rd /s /q modelos
   rd /s /q relatorios

   echo.
   echo Adicionando arquivo ao repositorio...
   svn add metodos-automaticos-%2.7z

   echo.
   echo Enviando copia de trabalho para 'tags/'...
   echo.
   cd ..
   svn copy metodos-automaticos-%2 https://macrosvba.googlecode.com/svn/tags/ -m "Lançamento da versão %2 de Métodos Automáticos."

   echo.
   echo Concluido.
)