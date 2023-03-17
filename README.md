# QMLVideoPlayer
A simple video player made using QML and QT Creator.


Task: Build a simple QML based program that: • Loads a video file from File Picker dialog • Have play and pause buttons and a progress slider • Slider should also allow user to drag to seek playback position of the video file that’s being played. Bonus: - Do not use Qt widgets and do not use Qt quick controls.

## Features
* Browse files through file picker (Required)
* Play and Pause Buttons (Required)
* Progress Slider and Video Controller (Required)
* No Qt Widgets (Bonus)
* No Qt Quick Controls (Bonus)
* Timestamp
* Fullscreen mode
* Mute Button
* Keyboard Shortcuts
* Auto-Hide Overlay
* Volume Control

## Video Player Elements

![Picture of the Video Player with labelled elements](https://imgur.com/XqqMCol.png)

1. Video File Url and Name
2. Browse Videos (opens a file browser)
3. Video Progress and Conrtol (drag the handle or click along the seeker to change video position)
4. Play Button (play the video if video present, if not open file browser)
5. Pause Button (pauses the video)
6. Timestamp (shows the current video position with the total video duration in Minutes:Seconds format)
7. Mute Button (toggles video sound on or off)
8. Fullscreen mode (make the window visiblity fullscreen)
9. Browse Videos (opens a file browser)


## Keyboard Shortcuts

1. Spacebar Key [ __ ]      : pause/play the video 
2. Right Arrow Key [→]    : skip the video 5 seconds forward
3. Left Arrow Key [←]     : skip the video 5 seconds back
4. Up Arrow Key [↑]       : increase the volume by 5%
5. Down Arrow Key [↓]     : decrease the volume by 5%
6. Escape Key [esc]       : exit fullscreen

## How to Run this project

1. Clone this project to your local machine
2. Open Qt Creator and Click on Open File or Project under the "Files" menu, locate the cloned project folder then click on "CMakeLists.txt" and click "Open"
3. On the configue project page select "Desktop Qt 6.4.2 MinGW 64-bit" option then click on "Configure Project" <br> <br>
![Image of configure project page](https://imgur.com/itEhDlg.png) <br>
4. Under the project view on the left side panel click on the file "main.qml" under "appQMLVideoPlayer" <br> <br>
![Image of configure project page](https://imgur.com/KDLU9Wc.png) <br>
5. Click on the "Build" on the toolbar then "Run"

The program should run after the build process has finished.

## Demo


https://user-images.githubusercontent.com/20756787/225789100-ec1270a2-9b44-4a58-bac8-33c842c19d30.mp4




