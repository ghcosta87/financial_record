import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id:root

    width: rootWidth * widthMultiplier
    height: rootHeight * widthMultiplier
    anchors.horizontalCenter: alignment

    property var widthMultiplier: 1
    property var rootWidth
    property var rootHeight
    property var alignment
    property string title
    property string theme
    signal pressed
    signal released

    Rectangle {
        id: buttonItemContainer
        radius: 40
        anchors.fill: parent
        border.width: 1
        border.color: theme
        color: theme
        Text {
            id: buttonText
            text: title
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.capitalization: Font.AllUppercase
        }
        MouseArea {
            id: clickArea
            anchors.fill: parent
            onPressed: {
                buttonItemContainer.color = 'transparent'
                root.pressed()
            }
            onReleased: {
                buttonItemContainer.color = theme
                releasedSignalDelay.start()
            }
        }
        Timer{
            id: releasedSignalDelay
            interval: 100
            repeat: false
            onTriggered: {
                root.released()
            }
        }
    }
}
