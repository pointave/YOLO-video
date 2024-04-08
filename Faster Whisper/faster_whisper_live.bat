@echo on
call c:\users\point\appdata\local\anaconda3\scripts\activate.bat
call cd Github\faster-whisper
call conda activate whisper
call python transcribe_live.py

