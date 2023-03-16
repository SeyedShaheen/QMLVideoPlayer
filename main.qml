import QtQuick
import QtQuick.Window
import QtQuick.Dialogs
import QtMultimedia

Window {
    id: window
    width: 800
    height: 600
    visible: true
    title: qsTr("Simple Video Player")

    //detect mouse movements within the window. hide the overlay when mouse is stationary.
    MouseArea{
        id: movementDetect
        anchors.fill: parent
        hoverEnabled: true
        enabled: false


        onPositionChanged: {

            showHideHud.showHideHud(true)
            movementDetect.cursorShape = Qt.ArrowCursor
            timer.restart()
        }

        onDoubleClicked: {
            window.visibility == 2 ?
            window.visibility = "FullScreen" :
            window.visibility = "Windowed"
        }
    }


    //Video and Controls Container (Black Bars if the video does not fit the window)
    Rectangle{
        width: parent.width
        height: parent.height
        color: 'black'
        anchors.centerIn: parent

        //button to browse to file
        Rectangle{
            id: browseBtn
            width: 150
            height: 40
            color: 'white'
            visible: true
            anchors.centerIn: parent


            HoverHandler{
                acceptedDevices: PointerDevice.Mouse
            }

            Text{
                text: 'Browse Videos'
                font.pointSize: 12
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    fileDialog.open()
                }
            }
        }

        //Video Output
        Video {
            id: video
            width : parent.width
            height : parent.height
            source: fileDialog.currentFile
            volume: 0.5


            onStopped: {
                browseBtnTop.visible = false
                browseBtn.visible = true
            }


            onPlaying: {

            }

            focus: true

            Keys.onSpacePressed: {
                video.playbackState == 2 || 0 ? video.play() : video.pause()
            }

            Keys.onEscapePressed: {
                window.visibility = "Windowed"
            }

            Keys.onDownPressed: video.volume = video.volume - 0.05
            Keys.onUpPressed: video.volume = video.volume + 0.05

            Keys.onLeftPressed: video.position = video.position - 5000
            Keys.onRightPressed: video.position = video.position + 5000

        }

        //base for text and HUD for better visiblity
        Rectangle{
            id: frameTop
            height: 150
            gradient: Gradient {
                GradientStop { position: 0.0; color: "black" }
                GradientStop { position: 1.0; color: "transparent" }
            }
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
        }

        Rectangle{
            id: frameBottom
            height: 150
            gradient: Gradient {
                GradientStop { position: 1.0; color: "black" }
                GradientStop { position: 0.0; color: "transparent" }
            }
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        //show the loaded video file url
        Text{
            id: videoTitle
            wrapMode: Text.Wrap
            text: ''
            font.family: "Helvetica"
            font.pointSize: 14
            color: 'white'
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.topMargin: 25
        }

        //Play Button
        Rectangle{
            id: playbtn
            width: 20
            height: 20
            color: 'transparent'
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 20

            Text{
                text: '▶'
                color: 'white'
                font.pointSize: 24
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    video.hasVideo ?
                    video.play() : fileDialog.open()
                }
            }
        }

        //Pause Button
        Rectangle{
            id: pausebtn
            width: 20
            height: 20
            color: 'transparent'
            anchors.bottom: parent.bottom
            anchors.left: playbtn.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 20

            Text{
                text: '▌▌'
                color: 'white'
                font.pointSize: 10
                anchors.centerIn: parent
            }


            MouseArea {
                anchors.fill: parent
                onClicked: {
                    video.pause()
                }
            }
        }

        //converting millisecond video position and duration to minutes and seconds for timestamp
        Item{

            id: timestamp

            property int curMinutes: video.position/(60000)
            property int curSeconds: (video.position % 60000)/1000
            property int totMinutes: video.duration/(60000)
            property int totSeconds: (video.duration % 60000)/1000


        }

            //video timestamp and duration shown on the overlay
            Text{
                id: timestampText
                text:  timestamp.curMinutes + ":" + timestamp.curSeconds + "/" + timestamp.totMinutes + ":" + timestamp.totSeconds
                color: 'white'
                font.pointSize: 10
                anchors.left: pausebtn.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 10
                anchors.rightMargin: 10
                anchors.topMargin: 10
                anchors.bottomMargin: 20

            }


        //Browse File Button
        Rectangle{
            id: browseBtnTop
            visible: false
            width: 50
            height: 50
            color: 'transparent'
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 10

            Text {
                text: '📂'
                font.pointSize: 24
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    fileDialog.open()
                }
            }
        }

        //Seeker done without Quick Controls
        //Seek Line - video progress indicator
        Rectangle{
            id: seekLine
            height: 5
            color: 'white'
            radius: 16
            anchors.bottom: playbtn.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.bottomMargin: 20


            Rectangle{
            height: parent.height
            color: 'deepskyblue'
            radius: 16
            anchors.left: seekLine.left
            anchors.right: seekHandle.right
            }

            MouseArea{
                anchors.fill: parent

                onPressed: {
                    video.position = mouseX/(seekLine.width - seekHandle.width)*(video.duration)
                }

            }


            //Seek Handle - video position controller
            Rectangle{
                id: seekHandle
                width: 20
                height: 20
                color: 'cyan'
                radius: 32
                anchors.verticalCenter: parent.verticalCenter

                //set the Seek Handle position according to the video position
                x: ((video.position/video.duration)*(seekLine.width - seekHandle.width))

                MouseArea {
                           anchors.fill: parent
                           drag.target: seekHandle
                           drag.axis: Drag.XAxis
                           drag.minimumX: 0.1
                           drag.maximumX: seekLine.width - seekHandle.width

                           onPressed: {
//                                console.log(seekHandle.x/(seekLine.width - seekHandle.width)*100)
//                                console.log(video.position/(video.duration)*100)
//                                console.log(((video.position/video.duration)*100)/((seekLine.width - seekHandle.width)*100))

                                //pause the video when the seek handle is pressed (onMouseDown)
                                video.pause()

                           }

                           onReleased: {

                                //change the position of the video if the user drags and releases the seek handle (OnMouseUp)
                                video.position = seekHandle.x/(seekLine.width - seekHandle.width)*(video.duration)
                                video.play()
                           }


                       }


            }
        }

        //Mute Button
        Rectangle{
            id: volbtn
            width: 20
            height: 20
            color: 'transparent'
            anchors.bottom: parent.bottom
            anchors.right: fullscreenbtn.left
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 20

                Text{
                    text: video.muted || video.volume == 0 ? '🔈' : '🔊'
                    color: 'white'
                    font.pointSize: 14
                    anchors.centerIn: parent
                }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                   video.muted ? video.muted = false : video.muted = true
                }
            }
        }

        Rectangle{
            id: fullscreenbtn
            width: 20
            height: 20
            color: 'transparent'
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.leftMargin: 10
            anchors.rightMargin: 10
            anchors.topMargin: 10
            anchors.bottomMargin: 22

            Text{
                text: window.visibility == 2 ? '🗖' : '🡷'
                color: 'white'
                font.pointSize: 16
                anchors.centerIn: parent
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    window.visibility == 2 ?
                    window.visibility = "FullScreen" :
                    window.visibility = "Windowed"
                }
            }

        }

        //Timer used to hide text and controls overlay to avoid video obstruction
        //if the mouse is stationery for 3 seconds hide all overlay
        Timer {
            id: timer
            interval: 3000; running: false; repeat: false
            onTriggered: {

                showHideHud.showHideHud(false)
                movementDetect.cursorShape = Qt.BlankCursor

            }
           }

        //function to show or hide the overlay based on mouse inactivity and timer
        Item {
            id: showHideHud

            function showHideHud(value){
                videoTitle.visible = value
                frameTop.visible = value
                frameBottom.visible = value
                playbtn.visible = value
                pausebtn.visible = value
                timestampText.visible = value
                volbtn.visible = value
                fullscreenbtn.visible = value
                seekLine.visible = value
                seekHandle.visible = value
                browseBtnTop.visible = value
            }
        }


        //File Browser, only accepts video files
        FileDialog {
            id: fileDialog
            title: "Please choose a file"
            nameFilters: ["Video Files (*.mp4 *.mov *.wmv *mkv)"]
            onAccepted: {
                browseBtnTop.visible = true
                browseBtn.visible = false
                timer.running = true
                movementDetect.enabled = true
                video.play()
                videoTitle.text = fileDialog.currentFile
                console.log("Loaded File: " + fileDialog.currentFile)




            }
            onRejected: {
                console.log("Canceled")
            }
        }

    }

}
