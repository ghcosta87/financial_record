import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.15
import QtQuick.Shapes 1.2

Item {
    signal clicked(int index)

    property var mySource: ['file:///home/gabriel/Projetos/Design/Icons/alert-circle.svg',
        'file:///home/gabriel/Projetos/Design/Icons/alert-circle.svg',
        'file:///home/gabriel/Projetos/Design/Icons/alert-circle.svg',
        'file:///home/gabriel/Projetos/Design/Icons/alert-circle.svg']
    //source: (filehandler.fileExist(/*'file://'+*/iconSource[index])) ? 'file://'+iconSource[index] : __SYSTEM_DEFAULT_ICON.error

   default property string myIconSource: 'file:///home/gabriel/Projetos/Design/Icons/alert-circle.svg'
    property string pressedColor: 'white'
    property string  myIconColor: 'black'

    property int myRadius: 30

    property string myBackgroundColor: 'green'
    onMyBackgroundColorChanged: redraw()

    property string buttonColor: 'yellow'

    property bool debug: false

    property int barComponentTopMargin: root.height*0.92

    property real barHeight: container.height

    property real myCanvasAngle: 31.2
    onMyCanvasAngleChanged: redraw()

    property real myCanvasDepth:0.5
    onMyCanvasDepthChanged: redraw()

    property real shapeAngle: 30
    onShapeAngleChanged: redraw()

    function redraw(){
        canvasContainer.context.reset()
        canvasContainer.requestPaint()
    }

    function menuOpened(state){
        if(state){
            roundIcon.state="clockwise"
            //            currentState=true
        }
        if(!state){
            roundIcon.state="counterclockwise"
            //            currentState=false
        }
    }

    id:root
    //    anchors.fill: parent
    width: 400
    height: 800

    readonly property int buttonsMargin: 10

    Button{
        id:b1
        visible: debug
        text: 'myCanvasAngle\nincrease to '+myCanvasAngle
        width: (parent.width/2)-(buttonsMargin)*2
        height: parent.height*0.06
        anchors{
            left:parent.left
            top:parent.top
            margins:buttonsMargin
        }
        onClicked:{
            myCanvasAngle+=0.05
        }
    }
    Button{
        visible: debug
        text: 'myCanvasAngle\ndecrease to '+myCanvasAngle
        width: b1.width
        height: b1.height
        anchors{
            right:parent.right
            top:parent.top
            margins:buttonsMargin
        }
        onClicked:{
            myCanvasAngle-=0.05
        }
    }
    Button{
        id:b2
        visible: debug
        text: 'myCanvasDepth\nincrease to '+myCanvasDepth
        width: b1.width
        height: b1.height
        anchors{
            left:parent.left
            top:b1.bottom
            margins:buttonsMargin
        }
        onClicked:{
            myCanvasDepth+=0.05
        }
    }
    Button{
        visible: debug
        text: 'myCanvasDepth\ndecrease to '+myCanvasDepth
        width: b1.width
        height: b1.height
        anchors{
            right:parent.right
            top:b1.bottom
            margins:buttonsMargin
        }
        onClicked:{
            myCanvasDepth-=0.05
        }
    }
    Button{
        visible: debug
        text: 'shapeAngle\nincrease to '+shapeAngle
        width: b1.width
        height: b1.height
        anchors{
            left:parent.left
            top:b2.bottom
            margins:buttonsMargin
        }
        onClicked:{
            shapeAngle+=0.05
        }
    }
    Button{
        visible: debug
        text: 'shapeAngle\ndecrease to '+shapeAngle
        width: b1.width
        height: b1.height
        anchors{
            right:parent.right
            top:b2.bottom
            margins:buttonsMargin
        }
        onClicked:{
            shapeAngle-=0.05
        }
    }
    Text{
        text: textDebug.text
        anchors.fill:parent
        font.bold: true
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    Rectangle{
        id:container
        color:'transparent'
        border.width: (debug) ? 2:0
        border.color: 'black'
        anchors{
            fill:parent
            topMargin: barComponentTopMargin
        }

        Path{
            property int startYPoint: parentContainer.height - container.height
            id: myPath
            startX: 0+shapeAngle; startY: startYPoint

            PathLine {x: ((container.width/2)-(shapeAngle*1.1)); relativeY: 0}
            PathArc {
                relativeX: shapeAngle ;y: 0 //relativeY: -container.height*myCanvasDepth
                radiusX: myCanvasAngle; radiusY: myCanvasAngle
                useLargeArc: false
                direction: PathArc.Clockwise
            }
            PathArc {
                relativeX: (roundButton.width/2)+((shapeAngle*0.3)) ; y: myPath.startYPoint // relativeY: container.height*myCanvasDepth
                radiusX: myCanvasAngle; radiusY:myCanvasAngle
                useLargeArc: false
                direction: PathArc.Clockwise
            }
            PathLine {x: ((container.width)-shapeAngle); relativeY: 0}
            PathArc {
                relativeX: shapeAngle ; relativeY: container.height*myCanvasDepth
                radiusX: myCanvasAngle; radiusY:myCanvasAngle*0.7
                useLargeArc: false
                direction: PathArc.Clockwise
            }
            PathLine {x: container.width; y: parentContainer.height}
            PathLine {x: 0; y: parentContainer.height}
            PathLine {x: 0; relativeY: -container.height*myCanvasDepth}
            PathArc {
                relativeX: shapeAngle ;relativeY: -container.height*myCanvasDepth
                radiusX: myCanvasAngle; radiusY:myCanvasAngle*0.7
                useLargeArc: false
                direction: PathArc.Clockwise
            }
        }

        Rectangle{
            id:parentContainer
            width: container.width
            height: container.height*1.4
            color:'transparent'
            border.width: (debug) ? 2:0
            border.color: 'orange'
            anchors{
                bottom:parent.bottom
                left:parent.left
                right:parent.right
            }

            Canvas{
                id:canvasContainer
                anchors.fill:parent
                contextType: "2d"
                onPaint: {
                    context.fillStyle= myBackgroundColor
                    context.path = myPath
                    context.fill()
                }
                Text{
                    id:textDebug
                    visible:debug
                    text: container.width+' - '+shapeAngle+' - '+myCanvasAngle.toFixed(2)+' - '+myCanvasDepth.toFixed(2)+' - '+shapeAngle.toFixed(2)
                    anchors.fill:parent
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }

        }


        Rectangle{
            property real componentMargin:root.height*0.005
            id:roundButton
            x:(root.width/2)-(shapeAngle*0.9)
            y:-(container.height*(myCanvasDepth-0.15))
            color: 'transparent' //buttonColor
            height: width
            width: shapeAngle*1.8
            radius: 50
            border.width: (debug) ? 2:0
            border.color:'black'
            MouseArea{
                property bool isOpen:false
                id:roundIconMouseArea
                anchors.fill:parent
                onClicked: {
                    isOpen=!isOpen
                    root.menuOpened(isOpen)
                    root.clicked(4)
                }
                Image {
                    id: roundIcon
                    source: myIconSource
                    anchors.fill: parent
                    clip: true
                    smooth: true
                    asynchronous: true
                    mipmap: true
                    fillMode: Image.PreserveAspectFit
                    //                anchors.margins: parent.componentMargin
                    states: State {
                        name: "clockwise"
                        PropertyChanges { target: roundIcon; rotation: 90 }
                    }
                    State {
                        name: "couterclockwise"
                        PropertyChanges { target: roundIcon; rotation: -90 }
                    }
                    transitions: Transition {
                        RotationAnimation { duration: 350}
                    }
                }
                ColorOverlay {
                    id:roundmyIconColor
                    color: (roundIconMouseArea.pressed) ? pressedColor : myIconColor
                    anchors.fill: roundIcon
                    rotation: roundIcon.rotation
                    source: roundIcon
                }
            }
        }

        Rectangle{
            id:iconsContainerLeft
            x:shapeAngle/2
            color:'transparent'
            width: (container.width/2)-(shapeAngle*1.8)
            height: container.height
            border.width: (debug) ? 2:0
            border.color: 'yellow'
            Row{
                id:row
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter:parent.verticalCenter
                }
                spacing: (iconsContainerLeft.width-(roundButton.width*2))/3 //4
                Repeater{
                    id:repeater
                    model:2
                    Rectangle{
                        height: roundButton.height
                        width: roundButton.width
                        border.width: (debug) ? 2:0
                        border.color: 'blue'
                        color:'transparent'
                        MouseArea{
                            anchors.fill:parent
                            onClicked: root.clicked(index)
                            Image {
                                id: leftImg
                                anchors.fill: parent
                                clip: true
                                smooth: true
                                asynchronous: true
                                mipmap: true
                                fillMode: Image.PreserveAspectFit
                                anchors.margins: roundButton.componentMargin //root.height*0.015
                                source: mySource[index]
                            }
                            ColorOverlay {
                                id:leftImgColor
                                color: (parent.pressed) ? pressedColor : myIconColor
                                anchors.fill: leftImg
                                source: leftImg
                            }
                        }
                    }
                }
            }
        }

        Rectangle{
            id:iconsContainerRight
            x: (root.width/2)+(shapeAngle)
            color:'transparent'
            width: (container.width/2)-(shapeAngle*1.8)
            height: container.height
            border.width: (debug) ? 2:0
            border.color: 'yellow'
            Row{
                id:rightRow
                anchors{
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter:parent.verticalCenter
                }
                spacing: (iconsContainerLeft.width-(roundButton.width*2))/3 //4
                Repeater{
                    id:rightRepeater
                    model:2
                    Rectangle{
                        height: roundButton.height
                        width: roundButton.width
                        border.width: (debug) ? 2:0
                        border.color: 'pink'
                        color:'transparent'
                        MouseArea{
                            anchors.fill:parent
                            onClicked: root.clicked(index+2)
                            Image {
                                id: rightImg
                                anchors.fill: parent
                                clip: true
                                smooth: true
                                asynchronous: true
                                mipmap: true
                                fillMode: Image.PreserveAspectFit
                                anchors.margins: roundButton.componentMargin
                                source: mySource[index+2]
                            }
                            ColorOverlay {
                                id:rightImgColor
                                color: (parent.pressed) ? pressedColor : myIconColor
                                anchors.fill: rightImg
                                source: rightImg
                            }
                        }

                    }
                }
            }
        }
    }
}
