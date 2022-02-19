import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {

    //
    signal textLenghChanged
    signal whenTextChanged(string currentText)

    //  requeried configuration
    property string iconPath
    property string textHint

    //  non required configuration
    property string setInputMask
    property string fontSelected
    property string forbidenChars
    property int inputStandard: Qt.ImhNone
    property int echoModeSelection: TextInput.Normal
    property bool timerActive: true
    property bool firstTime: true
    property int maxLengh:100
    property int animationSpeed: 350
    property int inputMaskOption

    //  output
    property string myText: textInputValue.text
    property string enterText

    //
    property string filterCriterias: []

    //  inputMaskOption:
    readonly property int lettersOnly: 1
    readonly property int numbersOnly: 2
    readonly property int emailFormat: 3

    function externalInput(){
        mouseArea.visible = false
        hintAnimation.running = true
    }

    function checkForbiddenChar(inputText, option) {
        var lookUp
        let allowedChar
        let inputChar = inputText.split('')
        switch(option){
        case 1:
            allowedChar = userAllowedInput.split('')
            break
        case 2:
            allowedChar = passwordAllowedInput.split('')
            break
        case 3:
            allowedChar = emailAllowedInput.split('')
            break
        default: return true
        }

        let isAccepted
        let i
        for (i = 0; i < inputChar.length; ++i) {
            lookUp = inputChar[i]
            isAccepted = allowedChar.find(field => {
                                              if (field === lookUp)
                                              return true
                                          })
            if (!isAccepted) return false
        }
        return true
    }

    FontLoader {
        id: myFont
        source: "qrc:/Font/Roboto-LightItalic.ttf"
    }

    Component.onCompleted: hintAnimation.running = false

    id: root
    anchors.fill: parent
    color: 'transparent'

    Timer {
        id: searchTimer
        interval: 1500
        repeat: true
        onTriggered: timerActive ? searchAgain() : print("search off")
    }

    Rectangle {
        id: rectangle
        color: 'transparent'
        radius: 40
        border.width: 1
        border.color: 'white'
        anchors.fill: parent
        Image {
            id: myIcon
            width: myIcon.height
            source: iconPath
            fillMode: Image.PreserveAspectFit
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
                leftMargin: mediumWidthMargin * 3
                topMargin: mediumWidthMargin * 5
                bottomMargin: mediumWidthMargin * 5
            }
        }

        TextInput {
            id: textInputValue
            color: 'white'
            text: enterText
            echoMode: echoModeSelection
            clip: false
            font.pixelSize: rectangle.height * 0.28
            font.family: myFont.name
            font.italic: true
            maximumLength: maxLengh
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            inputMethodHints: inputStandard
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: myIcon.right
                leftMargin: mediumHeightMargin * 2
                right: parent.right
            }
            inputMask: setInputMask
            onTextChanged: {
                if (!checkForbiddenChar(textInputValue.text,
                                        inputMaskOption)) {
                    textInputValue.text = textInputValue.text.slice(0, -1)
                }
                let currentText=textInputValue.text
                root.whenTextChanged(currentText)
            }
            onFocusChanged: {
                if (!firstTime) {
                    if (text === "") {
                        mouseArea.visible = true
                        if (!activeFocus)
                            hintAnimationToOriginal.running = true
                    }
                }
                if (firstTime)
                    firstTime = false
            }
            onLengthChanged: {
                root.textLenghChanged()
                //                if (timerActive)
                //                    searchTimer.start()
                mouseArea.visible = false
            }
        }

        Text {
            id: hint
            color: 'white'//MyColors.NIGHT_THEME_00
            font.family: myFont.name
            text: textHint
            x: (parent.width / 2) - (textRuler.width / 2)
            y: (parent.height / 2) - (textRuler.height / 2)
            font.pixelSize: rectangle.height * 0.28
            font.italic: true
            Rectangle {
                id: textRuler
                border.color: 'yellow'
                color: 'transparent'
                anchors.fill: parent
                visible: false
            }
        }

        ParallelAnimation {
            id: hintAnimation
            onFinished: textInputValue.forceActiveFocus()
            YAnimator {
                target: hint
                from: hint.y
                to: (-0.05) * hint.height
                easing.type: Easing.Linear //Easing.OutExpo
                duration: animationSpeed
            }
            XAnimator {
                target: hint
                from: hint.x
                to: myIcon.width - 15 //(-0.001) * hint.width
                easing.type: Easing.Linear
                duration: animationSpeed
            }
            ScaleAnimator {
                target: hint
                from: 1
                to: 0.6
                easing.type: Easing.Linear
                duration: animationSpeed
            }
        }

        ParallelAnimation {
            id: hintAnimationToOriginal
            YAnimator {
                target: hint
                from: hint.y
                to: (parent.height / 2) - (textRuler.height / 2)
                easing.type: Easing.Linear //Easing.OutExpo
                duration: animationSpeed
            }
            XAnimator {
                target: hint
                from: hint.x
                to: (parent.width / 2) - (textRuler.width / 2)
                easing.type: Easing.Linear
                duration: animationSpeed
            }
            ScaleAnimator {
                target: hint
                from: 0.6
                to: 1
                easing.type: Easing.Linear
                duration: animationSpeed
            }
        }

        MouseArea {
            id: mouseArea
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: myIcon.right
                leftMargin: mediumWidthMargin
                right: parent.right
            }
            onClicked: {
                mouseArea.visible = false
                hintAnimation.running = true
                //                hint.visible = false
                textInputValue.forceActiveFocus()
            }
        }
    }

    readonly property string userAllowedInput: "abscdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ "
    readonly property string passwordAllowedInput: "0123456789"
    readonly property string emailAllowedInput: "abscdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.@"
}
