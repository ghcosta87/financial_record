import QtQuick 2.15
import QtQuick.Window 2.2
import QtQuick.LocalStorage 2.0
import QtQuick.Controls 2.1
import Qt.labs.calendar 1.0
import QtGraphicalEffects 1.0
import QtCharts 2.3
import QtQuick.Controls 2.15

import '../03_MyComponents'

Rectangle {
    id: root
    anchors.fill: parent
    color: 'transparent'

    Component.onCompleted: {
        busyIndicator.running = false
    }

    //    Timer {
    //        id: loginTimer
    //        interval: 10000
    //        repeat: false
    //        onTriggered: {
    //            loginTimer.stop()
    //            busyIndicator.running = false
    //        }
    //        onRunningChanged: {
    //            console.log('runing changed')
    //        }
    //    }

    Rectangle {
        id: emailContainer
        color: 'transparent'
        anchors {
            fill: parent
            topMargin: parent.height * 0.3
            bottomMargin: parent.height * 0.6
            leftMargin: parent.width * 0.1
            rightMargin: parent.width * 0.1
        }
        MyTextInput {
            id: userEmail
            textHint: "Digite seu email"
            anchors.fill: parent
            iconPath: MyIcons.mailIcon
            timerActive: false
            maxLengh: 50
            inputMaskOption: emailFormat
        }
    }

    Rectangle {
        id: nicknameContainer
        color: 'transparent'
        height: emailContainer.height
        anchors {
            top: emailContainer.bottom
            left: parent.left
            right: parent.right
            topMargin: parent.height * 0.05
            leftMargin: parent.width * 0.1
            rightMargin: parent.width * 0.1
        }
        MyTextInput {
            id: nickname
            textHint: "Digite seu usuário"
            anchors.fill: parent
            iconPath: MyIcons.userIcon
            timerActive: false
            maxLengh: 6
            inputMaskOption: lettersOnly
        }
    }

    Rectangle {
        id: passwordContainer
        color: 'transparent'
        height: emailContainer.height
        anchors {
            top: nicknameContainer.bottom
            left: parent.left
            right: parent.right
            topMargin: parent.height * 0.05
            leftMargin: parent.width * 0.1
            rightMargin: parent.width * 0.1
        }
        MyTextInput {
            id: userPassword
            textHint: "Digite sua senha"
            anchors.fill: parent
            iconPath: MyIcons.passcodeIcon
            echoModeSelection: TextInput.Password
            inputMaskOption: numbersOnly
            timerActive: false
            maxLengh: 6
        }
    }

    Rectangle {
        id: buttonContainer
        color: 'transparent'
        height: emailContainer.height
        anchors {
            top: passwordContainer.bottom
            left: parent.left
            right: parent.right
            topMargin: parent.height * 0.05
        }
        MyButton {
            rootWidth: emailContainer.width
            rootHeight: emailContainer.height
            title: "cadastrar"
            alignment: parent.horizontalCenter
            theme: MyColors.NIGHT_THEME_00
            onPressed: {

            }
            onReleased: {
                cpp_signUp(cvar_googleKey(),userEmail.myText,userPassword.myText,nickname.myText)
//                runC.signUp(runC.getAuthToken(), userEmail.myText,userPassword.myText,nickname.myText)
                busyIndicator.running = true
                authCycle.start()
            }
        }
    }

    Timer {
        id: authCycle
        interval: 500
        repeat: true
        onTriggered: {
            switch(qmlVar_isAuthenticated){
            case _LOGIN_AUTHENTICATED:
                myLog('\tsignUpCycle => onTriggered(){ User logged }')
                __USER_HANDLER.recordCurrentUser(userObj.getObj())
                authCycle.stop()
                busyIndicator.running = false
                alert.show('Bem Vindo '+userObj.name+' !')
                __FIREBASE_HANDLER.getAll()
                stackView.push(homePage)
                break
            case _LOGIN_INCOMPLETEMSG:
                break
            case _LOGIN_NOTAUTHENTICATED:
                busyIndicator.running = false
                break
            case _LOGIN_ANSWERERROR:
                busyIndicator.running = false
                break
            }

//            if (runC.authComplete(false)===1) {
//                authCycle.stop()
//                busyIndicator.running = false

//                USERHANDLER.recordCurrentUser()

//                //salvar nickname no firebase
//                stackView.push(main_menu)
//            }
//            if (runC.authComplete(false)===2) {
//                authCycle.stop()
//                busyIndicator.running = false
//                //                JsonCheck.errorParse(runC.jsonFeedback())
//                runC.authComplete(true)
//            }
        }
    }

    Rectangle {
        id: backButtonContainer
        color: 'transparent'
        anchors {
            top: buttonContainer.bottom
            left: parent.left
            right: parent.right
            topMargin: parent.height * 0.05 * 0.5
        }
        MyButton {
            rootWidth: passwordContainer.width
            rootHeight: passwordContainer.height
            title: "voltar"
            alignment: parent.horizontalCenter
            theme: MyColors.NIGHT_THEME_00
            onPressed: {

            }
            onReleased: {
                stackView.push(loginForm)
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: MyColors.NIGHT_THEME_60
        opacity: 0.7
        visible: busyIndicator.running
    }

    BusyIndicator {
        id: busyIndicator
        palette.dark: MyColors.NIGHT_THEME_00
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.fill: parent
        height: busyIndicator.width
        anchors {
            leftMargin: parent.width * 0.3
            rightMargin: parent.width * 0.3
        }
    }
}
