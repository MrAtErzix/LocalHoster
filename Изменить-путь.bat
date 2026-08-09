@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"
echo.
echo   Укажите путь к папке сайта.
echo   Перетащите папку в это окно и нажмите Enter:
set /p SITE=
set "SITE=!SITE:"=!"
if "!SITE!"=="" (
  echo   Пусто - ничего не изменено.
  pause
  exit /b 1
)
>"%~dp0путь.txt" echo !SITE!
echo.
echo   Новый путь сохранён: !SITE!
echo   Запустите "Запуск.bat"
echo.
pause