@echo off

setlocal

set /p Revisao=Digite a revisao desejada (deixar em branco para ultima revisao): 

if [%Revisao%] == [] (
	set Revisao=head
)

svn co -r %Revisao% http://macrosvba.googlecode.com/svn/trunk/metodos-automaticos/bases/oficial/ .  && (
	echo.
	echo Feito!
) || (
	echo.
	echo *** Houve erro! ***
)

echo.
pause