@echo off
echo Atualizando...
svn up
7z e macros\consulta-sistema-horarios-oficial.7z -omacros\
pause