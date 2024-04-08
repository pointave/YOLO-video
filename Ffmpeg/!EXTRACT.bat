@echo off
setlocal enabledelayedexpansion

rem Get the input video file dropped onto the batch file.
set "input_file=%~1"

rem Prompt the user for the desired output FPS.
set /p "output_fps=Enter the desired FPS (e.g., 24): "

rem Extract the file name without extension from the input file.
for %%F in ("!input_file!") do set "file_name=%%~nF"

rem Create a folder for frames.
set "output_folder=!file_name!_fps!output_fps!"
mkdir "!output_folder!"

rem Use FFmpeg to extract frames as JPG images.
ffmpeg -i "!input_file!" -vf "fps=!output_fps!" -q:v 0 "!output_folder!\%%05d.jpg"

rem Use FFmpeg to extract audio as MP3.
ffmpeg -i "!input_file!" -vn -acodec libmp3lame -ab 192k "!output_folder!\!file_name!_fps!output_fps!.mp3"

rem Notify the user.
echo Frames extracted at !output_fps! FPS and audio extracted to !output_folder!

endlocal
