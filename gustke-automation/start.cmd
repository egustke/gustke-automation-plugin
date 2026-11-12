@echo off
rem Startet einen Werkzeugkasten von Gustke Automation fuer Claude.
rem Aufruf aus dem Plugin:  start.cmd gmail
rem
rem Die Werkzeuge selbst gehoeren zur Installation des Werkstatt-Assistenten
rem (Setup von Gustke Automation) - sie greifen auf Lexware, Gmail, ERP und das
rem Firmenlaufwerk dieses Rechners zu. Hier wird nur gesucht, wo sie liegen.
rem Auf stdout darf nichts erscheinen ausser dem Protokoll, darum alles still.
setlocal
set "WA="
if defined WERKSTATT_ASSISTENT set "WA=%WERKSTATT_ASSISTENT%"
rem Liegt das Plugin im Programmordner (so richtet es das Setup ein), stehen
rem die Werkzeuge zwei Ordner darueber - egal, wohin installiert wurde.
if not defined WA if exist "%~dp0..\..\server\fuer_claude.py" set "WA=%~dp0..\.."
rem Kommt das Plugin aus einem Marktplatz, liegt es in Claudes eigenem Ordner;
rem dann an den ueblichen Orten suchen.
if not defined WA if exist "%LOCALAPPDATA%\Programs\Gustke Automation\Werkstatt-Assistent\Assistent\server\fuer_claude.py" set "WA=%LOCALAPPDATA%\Programs\Gustke Automation\Werkstatt-Assistent\Assistent"
rem Anderswo installiert: den Ort hat einrichtung\claude_plugin.py gemerkt.
set "ORT=%LOCALAPPDATA%\Gustke Automation\werkstatt-ort.txt"
if not defined WA if exist "%ORT%" set /p WA=<"%ORT%"
if defined WA if not exist "%WA%\server\fuer_claude.py" set "WA="
if not defined WA (
  echo Die Werkstatt-Programme von Gustke Automation sind auf diesem Rechner nicht installiert. Bitte zuerst das Setup ausfuehren. 1>&2
  exit /b 1
)
"%WA%\.venv\Scripts\python.exe" "%WA%\server\fuer_claude.py" %1
