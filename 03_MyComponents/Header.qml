import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item {
    //  signals
    signal userIconPresed
    signal secondaryIconPressed

    //  itens configuration
    //  colors
    property string localBackgroundColor:'blue'
    property string localBorderColor:'red'
    property string localTextColor:'black'
    property string localPressedColor:'grey'
    property string localReleasedColor:'black'
    property string localIconsColor: 'black'

    //  sizes and margins
    property int textSpacing: 10
    property int vMargins: 10
    property int hMargins: 10
    property int fontSize: 10

    //  texts and fonts
    property string welcomeName
    property string setFont
    property string setAppDate

    //  icons and images
    property string setUserIcon: 'qrc:/Images/systemIcons/user_black.svg'
    property string setSecondaryIcon: 'qrc:/Images/systemIcons/net_black.svg'

    id: root

    Rectangle {
        id: rootContainer
        color: localBackgroundColor
        anchors.fill: parent

        Image {
            id: myIcon
            source: setUserIcon
            width: height
            autoTransform: true
            fillMode: Image.PreserveAspectFit
            visible: true
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                margins: hMargins*1.5
            }
            ColorOverlay {
                color:localIconsColor
                anchors.fill: myIcon
                source: myIcon
            }
            Rectangle{
                anchors.fill: parent
                color: 'transparent'
            }
            MouseArea{
                anchors.fill: parent
                onClicked: root.userIconPresed()
            }
        }

        Column {
            spacing: textSpacing
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: myIcon.right
                right: settingsIcon.left
                margins: hMargins
            }
            Text {
                id: userTextField
                text: 'Olá, ' + welcomeName
                font.family: setFont
                font.pointSize: fontSize
                color: localTextColor
            }
            Text {
                id: userWelcomeField
                text: 'Bem vindo!'
                font.family: setFont
                font.pixelSize: userTextField.font.pixelSize * 0.5
                color: userTextField.color
            } Text {
                id: spacer
                text: '  '
                font.family: setFont
                font.pixelSize: userTextField.font.pixelSize * 0.5
                color: userTextField.color
            }
            Text {
                id: appDate
                text: setAppDate
                font.family: setFont
                font.pixelSize: userTextField.font.pixelSize * 0.5
                color: userTextField.color
            }
        }

        Image {
            id: settingsIcon
            source: setSecondaryIcon
            width: height
            autoTransform: true
            visible: true
            fillMode: Image.Stretch
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
                bottomMargin: parent.height/2
                topMargin: vMargins
                rightMargin: hMargins
            }
            ColorOverlay {
                anchors.fill: settingsIcon
                source: settingsIcon
                color: localIconsColor
            }
            MouseArea{
                anchors.fill: parent
                onClicked: root.secondaryIconPressed()
            }
        }
    }
}
