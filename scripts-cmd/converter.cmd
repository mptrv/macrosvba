@echo off
if [%3] == [] goto sintaxe

ffmpeg -i %1 -s %2 -c:a copy %3

goto :eof

:sintaxe
echo.
echo Sintaxe:
echo.
echo    converter video_entra resolucao video_sai
echo.
echo Exemplo:
echo.
echo    converter video_entra.mp4 hd480 video_sai.mp4
echo.
echo Sugestäes de resolu‡Æo:
echo.
echo    hd480
echo    hd730
echo    hd1080
echo.
