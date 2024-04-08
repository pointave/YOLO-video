@echo off
call c:\users\point\appdata\local\anaconda3\scripts\activate.bat
call cd Github\faster-whisper
call conda activate whisper

REM Check if any arguments are passed
IF "%~1"=="" (
    echo No file path provided.
    pause
    exit /b
)

REM Run the Python script with the provided file path
call python transcribe_from_file.py "%~1"

pause
