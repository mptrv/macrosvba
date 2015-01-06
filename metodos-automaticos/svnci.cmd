@echo off
echo Realizando 'commit'...
7z u macros\consulta-sistema-horarios-oficial.7z macros\consulta-sistema-horarios-oficial.accdb
svn ci -F texto_do_commit.txt
pause
