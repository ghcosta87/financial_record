import QtQuick 2.0
import QtQuick.Controls 1.4

Item {
    signal alertBarClicked

    property var show: (message)=>{
                           alertBarText=message
                           fadeIn.running=true
                           alertBarTimeOut=1000
                           alertBarShowTime=1000
                       }

//    function show(message,){
//        alertBarText=message
//        fadeIn.running=true
//        alertBarTimeOut=1000
//        alertBarShowTime=1000
//    }

    //  Settings
    property real alertBarOpacity: 0.9
    property var alertBarFont
    property int alertBarTimeOut: 800
    property int alertBarShowTime: 2000

    //  Sizes
    property int alertBarTextSize: 25
    property int alertBarRadius: 20

    //  Texts
    property string alertBarText: 'Your message here'

    //  Colors
    property string alertBarTextColor: 'white'
    property string alertBarBackgroundColor: 'blue'

    //  Animations
    property PropertyAnimation fadeIn: PropertyAnimation {
        target: rootItem
        property: "opacity"
        to: 1
        duration: alertBarTimeOut
    }

    property PropertyAnimation fadeOut: PropertyAnimation {
        target: rootItem
        property: "opacity"
        to: 0
        duration: alertBarTimeOut
    }

    Timer {
        id: closeTimer
        interval: alertBarShowTime
        repeat: false
        onTriggered: {
            fadeOut.running=true
        }
    }

    onOpacityChanged: if(opacity===1)closeTimer.running=true

    id:rootItem
    width: 300
    height: 100

    Component.onCompleted: opacity=0

    Rectangle{
        id:container
        opacity: alertBarOpacity
        anchors.fill:parent
        color: alertBarBackgroundColor
        radius: alertBarRadius
        clip: true
        Text{
            id: message
            text: alertBarText
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            //            wrapMode: Text.WordWrap
            anchors{
                verticalCenter: parent.verticalCenter
                left: parent.left
                right: parent.right
                leftMargin: 20
                rightMargin: 20
            }
            font.family: alertBarFont
            font.pointSize:alertBarTextSize
            color: alertBarTextColor
            minimumPointSize: 1
            fontSizeMode: Text.HorizontalFit
        }
    }
    MouseArea{
        id:mouseArea
        anchors.fill: parent
        onClicked: {
            rootItem.alertBarClicked()
            fadeOut.running=true
        }
    }
}
