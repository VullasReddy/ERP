@echo off
setlocal EnableDelayedExpansion
title NCET CMS - Django server (keep this window open)
cd /d "%~dp0"
set "ZIP=Collage-Management-System-For-GiFt-collage--main.zip"
set "APPDIR=%~dp0gift-cms\Collage-Management-System-For-GiFt-collage--main"

rem ---- find a full Python (must have venv + pip) ----
set "PY="
for %%C in ("py -3.12" "py -3.11" "py -3.13" "py -3" "python" "python3") do (
  if not defined PY (
    %%~C -c "import venv, ensurepip" >nul 2>nul && set "PY=%%~C"
  )
)
if not defined PY (
  for /d %%D in ("%LOCALAPPDATA%\Programs\Python\Python3*" "C:\Program Files\Python3*" "C:\Python3*") do (
    if not defined PY if exist "%%~D\python.exe" (
      "%%~D\python.exe" -c "import venv, ensurepip" >nul 2>nul && set PY="%%~D\python.exe"
    )
  )
)
if not defined PY (
  echo.
  echo  No full Python installation was found on this PC.
  echo  Install Python 3.12 from https://www.python.org/downloads/
  echo  and TICK "Add python.exe to PATH" on the first screen.
  echo  Then double-click this file again.
  echo.
  pause & exit /b 1
)
echo Using Python: %PY%
%PY% --version

rem ---- unzip (first run only) ----
if not exist "%APPDIR%\manage.py" (
  echo Unzipping project...
  powershell -NoProfile -Command "Expand-Archive -Force -LiteralPath '%ZIP%' -DestinationPath 'gift-cms'" || goto :fail
)
cd /d "%APPDIR%"

rem ---- virtual env + packages (first run only) ----
if not exist ".venv\Scripts\python.exe" (
  if exist ".venv" rmdir /s /q ".venv"
  echo Creating virtual environment...
  %PY% -m venv .venv || goto :fail
  echo Installing packages, this takes a few minutes...
  ".venv\Scripts\python.exe" -m pip install --upgrade pip
  ".venv\Scripts\python.exe" -m pip install -r requirements.txt || (rmdir /s /q ".venv" & goto :fail)
)
if not exist ".env" copy .env.example .env >nul

rem ---- database + demo data ----
".venv\Scripts\python.exe" manage.py migrate || goto :fail
if not exist ".seeded" (
  ".venv\Scripts\python.exe" manage.py seed_demo --flush || goto :fail
  echo done> .seeded
)

echo.
echo ==========================================================
echo  Website: http://127.0.0.1:8000
echo  Portal : http://127.0.0.1:8000/portal/
echo  Demo login: admin / Gift@2026   (or student, faculty...)
echo  Keep this window open. Press Ctrl+C to stop the server.
echo ==========================================================
start "" cmd /c "timeout /t 4 >nul & start http://127.0.0.1:8000"
".venv\Scripts\python.exe" manage.py runserver 127.0.0.1:8000
pause
exit /b 0

:fail
echo.
echo  *** Setup stopped because of the error above. Take a screenshot and send it to Claude. ***
pause
exit /b 1
