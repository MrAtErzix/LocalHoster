@echo off
cd /d "%~dp0"
echo.
echo   ======================
echo    ПУБЛИЧНЫЙ ДОСТУП
echo   ======================
echo.
echo   Условие: сайт должен быть уже запущен на порту 8080
echo   через "Запуск.bat". Через несколько секунд появится
echo   ссылка https://xxx.trycloudflare.com - отправьте её
echo   любому. Остановка: Ctrl+C или закрыть окно.
echo.
set "CF=%~dp0cloudflared.exe"
if not exist "%CF%" set "CF=C:\Users\user\AppData\Local\Temp\opencode\cloudflared.exe"
"%CF%" tunnel --url http://localhost:8080 --no-autoupdate
echo.
pause