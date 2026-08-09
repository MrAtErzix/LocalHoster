@echo off
setlocal enabledelayedexpansion
cd /d "%~dp0"

set "SITEFILE=%~dp0путь.txt"

if not exist "%SITEFILE%" ( call :askpath )

if not exist "%SITEFILE%" (
  echo Путь-файл не создан. Повторите.
  pause
  exit /b 1
)
set /p SITE=<"%SITEFILE%"
set "SITE=!SITE:"=!"
if not exist "%SITE%\index.html" (
  echo.
  echo   Папка не найдена: %SITE%
  echo   index.html в ней нет. Откройте "Изменить-путь.bat" и укажите правильную папку.
  echo.
  pause
  exit /b 1
)

set "PORT="
for %%P in (8080 8081 8082 8083 8084 8085) do if not defined PORT (
  netstat -ano | findstr /R /C:":%%P .*LISTENING" >nul 2>nul
  if errorlevel 1 set "PORT=%%P"
)
if not defined PORT set "PORT=8089"

echo.
echo   Сайт: %SITE%
echo   Адрес: http://localhost:%PORT%/
echo   Остановка: закройте это окно или нажмите Ctrl+C
echo.
start "" /min cmd /c "timeout /t 2 /nobreak >nul & start http://localhost:%PORT%/"

where python >nul 2>nul
if !errorlevel!==0 (
  python -m http.server %PORT% -d "%SITE%"
  exit /b 0
)
where py >nul 2>nul
if !errorlevel!==0 (
  py -m http.server %PORT% -d "%SITE%"
  exit /b 0
)
where node >nul 2>nul
if !errorlevel!==0 (
  node "%~dp0server.js" "%SITE%" %PORT%
  exit /b 0
)
echo.
echo   Не найден ни Python, ни Node.js - не могу запустить сервер.
echo.
pause
exit /b 1

:askpath
echo.
echo   === ПЕРВЫЙ ЗАПУСК ===
echo   Перетащите папку сайта в это окно и нажмите Enter,
echo   либо впишите полный путь вручную:
set /p SITE=
set "SITE=!SITE:"=!"
if "!SITE!"=="" (
  echo Пусто - повторите ввод.
  goto :askpath
)
>"%SITEFILE%" echo !SITE!
echo.
echo   Путь сохранён: !SITE!
goto :eof