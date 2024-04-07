@echo on
call c:\users\point\appdata\local\anaconda3\scripts\activate.bat
call cd Github\yolov9
call conda activate yolo

set /p video_path="Enter the path of the video: "
set "video_path=%video_path:"=%"
call python detect.py --weights yolov9-c.pt --img 640 --conf 0.3 --device 0 --view-img --source "%video_path%"

pause
