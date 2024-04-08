@echo off
setlocal enabledelayedexpansion

REM Check if ffmpeg is installed
where ffmpeg >nul 2>nul
if %errorlevel%==0 (
    set "ffmpeg_installed=true"
) else (
    set "ffmpeg_installed=false"
)

REM Extract the folder path from the dragged folder
set "folder=%~1"

REM List all mp4 files in the dragged folder
for %%i in ("%folder%\*.mp4") do (
    echo file '%%i'>> "%folder%\list.txt"
)

REM Concatenate mp4 files into one long video with folder name
if %ffmpeg_installed%==true (
    ffmpeg -f concat -safe 0 -i "%folder%\list.txt" -c copy "%~dp1%~n1.mp4"
    del "%folder%\list.txt"
    pause
) else (
    echo "ffmpeg is not installed. Please install it and try again."
    pause
)
