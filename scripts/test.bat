@echo off
setlocal enabledelayedexpansion

REM ============================================
REM CONFIGURACION - Modifica estos valores
REM ============================================
set LOKI_URL=http://localhost:3100
set APP_NAME=test
set ENV_NAME=dev
set LOG_MESSAGE=Log de prueba desde BAT

REM ============================================
REM NO MODIFICAR DEBAJO DE ESTA LINEA
REM ============================================

echo Probando conexion con Loki en: %LOKI_URL%
echo App: %APP_NAME%
echo Env: %ENV_NAME%
echo.

REM Probar que Loki esta corriendo
echo 1. Verificando que Loki este activo...
curl -s %LOKI_URL%/ready
echo.
echo.

REM Enviar log de prueba
echo 2. Enviando log de prueba: "%LOG_MESSAGE%"
echo.

REM Crear y enviar el log
for /f %%i in ('powershell -Command "[DateTimeOffset]::UtcNow.ToUnixTimeMilliseconds() * 1000000"') do set TIMESTAMP=%%i
for /f "tokens=*" %%i in ('powershell -Command "Get-Date -Format 'yyyy-MM-dd HH:mm:ss'"') do set DATETIME=%%i

set "JSON={\"streams\":[{\"stream\":{\"app\":\"%APP_NAME%\",\"env\":\"%ENV_NAME%\"},\"values\":[[\"!TIMESTAMP!\",\"!LOG_MESSAGE! - !DATETIME!\"]]}]}"

curl -X POST %LOKI_URL%/loki/api/v1/push -H "Content-Type: application/json" -d "%JSON%"

echo.
echo.
echo 3. Listo! Ahora ve a Grafana:
echo    http://localhost:3000
echo.
echo    En Explore usa la query: {app="%APP_NAME%"}
echo.
pause
