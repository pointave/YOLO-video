@echo off
setlocal enabledelayedexpansion

rem Get the folder containing extracted frames and audio dropped onto the batch file.
set "input_folder=%~1"

rem Prompt the user for the desired output FPS.
set /p "output_fps=Enter the desired FPS (e.g., 24): "

rem Extract the base file name from the input folder.
for %%F in ("!input_folder!") do set "base_name=%%~nF"

rem Create the output MP4 file path.
set "output_mp4=!base_name!.mp4"

rem Check if the audio file exists
if exist "!input_folder!\!base_name!.mp3" (
    rem Use FFmpeg to recreate the MP4 from frames and audio.
    ffmpeg -framerate !output_fps! -i "!input_folder!\%%05d.jpg" -i "!input_folder!\!base_name!.mp3" -c:v libx265 -x265-params crf=18 -c:a aac  "!output_mp4!"
) else (
    rem Create the MP4 without audio
    ffmpeg -framerate !output_fps! -i "!input_folder!\%%05d.jpg" -c:v libx265 -x265-params crf=18 "!output_mp4!"
)

rem Notify the user.
echo MP4 recreated with frames at !output_fps! FPS: !output_mp4!

endlocal
