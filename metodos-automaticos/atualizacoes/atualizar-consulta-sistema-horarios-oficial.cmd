@echo off

setlocal

if [%1] == [] (
	set Revisao=head
) ELSE (
	set Revisao=%1
)

svn co -r %Revisao% http://macrosvba.googlecode.com/svn/trunk/metodos-automaticos/bases/oficial/ .  && (
	echo.
	echo Feito!
) || (
	echo.
	echo *** Houve erro! ***
)