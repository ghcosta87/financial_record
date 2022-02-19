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
    // Funcions used on Login.qml
    readonly property int _LOCAL_checkCurrentUser: 0
    readonly property int _LOCAL_recordCurrentUser:1

    //verificar uso
    readonly property int _LOCAL_userData:3
    readonly property int _LOCAL_createUserTable:0 // ??

    function localFunctions(choice){
        switch(choice){
        case _LOCAL_checkCurrentUser:
            return USERHANDLER.checkCurrentUser()
        case _LOCAL_recordCurrentUser:
            return USERHANDLER.recordCurrentUser()

        case ___recordCurrentUser:
            //            __USER_HANDLER.recordCurrentUser(userInfo)
            return USERHANDLER.recordCurrentUser(userInfo)
        case ___userData:
            return runC.userData(0," ")
        }
    }

    id: root
    anchors.fill: parent
    color: 'transparent'

    property bool click: false

    Component.onCompleted: {
        hideDrawer=true
        loginTimer.start()
        myLog("\nQML LoginOnCompleted(){ Login component completed }")
    }

    Timer {
        id: loginTimer
        interval: 2500
        repeat: false
        onTriggered: {
            myLog('\nQML loginTimerOnTriggered()')
            loginTimer.stop()
            if(__USER_HANDLER.checkCurrentUser()){
                runC.userData(true,userInfo)
                appMonthObj.changed=__JAVASCRIPT.monthChanged()
                showSnackBar(__STRING._welcomeText[__LANGUAGE._US])
                stackView.push(mainPage)
            }else{
                busyIndicator.running=false
            }
        }
        //            if(USERHANDLER.checkCurrentUser()){
        //            if(localFunctions(___checkCurrentUser)){
    }

    Rectangle {
        id: loginContainer
        color: 'transparent'
        anchors {
            fill: parent
            topMargin: parent.height * 0.3
            bottomMargin: parent.height * 0.6
            leftMargin: parent.width * 0.1
            rightMargin: parent.width * 0.1
        }
        MyTextInput {
            id: userLogin
            textHint: "Digite seu email"
            anchors.fill: parent
            iconPath: MyIcons.mailIcon
            inputMaskOption: emailFormat
            timerActive: false
            maxLengh: 50
        }
    }

    Rectangle {
        id: passwordContainer
        color: 'transparent'
        height: loginContainer.height
        anchors {
            top: loginContainer.bottom
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

    BusyIndicator {
        id: busyIndicator
        palette.dark: MyColors.NIGHT_THEME_00
        anchors {
            top: passwordContainer.bottom
            left: parent.left
            right: parent.right
            topMargin: parent.height * 0.05
            leftMargin: parent.width * 0.1
            rightMargin: parent.width * 0.1
        }
    }

    Rectangle {
        id: signInContainer
        visible: !busyIndicator.running
        color: 'transparent'
        height: loginContainer.height * 0.5

        anchors {
            top: passwordContainer.bottom
            topMargin: parent.height * 0.02
            left: parent.left
            right: parent.right
        }
        Text {
            id: signInField
            text: "Cadastre-se aqui" //animar a dica do texto diminuindo e subindo
            anchors.fill: parent
            font.pixelSize: 15
            color: click ? MyColors.NIGHT_THEME_20 : MyColors.NIGHT_THEME_00
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
        MouseArea {
            id: signInFieldClick
            anchors.fill: parent
            onPressed: click=!click
            onClicked:   {
                stackView.push(signIn)
            }
        }
    }

    Rectangle {
        id: buttonContainer
        color: 'transparent'
        anchors {
            top: busyIndicator.bottom
            left: parent.left
            right: parent.right
            topMargin: parent.height * 0.07
        }
        MyButton {
            rootWidth: passwordContainer.width
            rootHeight: passwordContainer.height
            title: "enter"
            alignment: parent.horizontalCenter
            theme: MyColors.NIGHT_THEME_00
            onPressed: {

            }
            onReleased: {
                //stackView.push(main_menu)
                //runC.getAuthToken()
                runC.signIn(runC.getAuthToken(),userLogin.myText,userPassword.myText)
                busyIndicator.running=true
                signCycle.start()
            }
        }
    }

    Timer {
        id: signCycle
        interval: 500
        repeat: true
        onTriggered: {
            if (runC.authComplete(false)===1) {
                //                                userInfo=runC.userData()
                userInfo=localFunctions(___userData)
                //                                USERHANDLER.createUserTable()
                localFunctions(___createUserTable)
                //                                USERHANDLER.recordCurrentUser(userInfo)
                localFunctions(___recordCurrentUser)
                runC.authComplete(true)
                myLog('user logged')
                signCycle.stop()
                busyIndicator.running = false
                showSnackBar('Bem Vindo!')
                stackView.push(mainPage)
            }
            if (runC.authComplete(false)===2) {
                busyIndicator.running = false
                showSnackBar('Connection error ...')
                runC.authComplete(true)
                myLog('erro user not logged')
                //criar um popup para receber código de error
                //e tambem salvar os dados no log via c++
            }
        }
    }

}
