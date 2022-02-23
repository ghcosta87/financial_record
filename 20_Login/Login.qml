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
            return __USER_HANDLER.checkCurrentUser()
        case _LOCAL_recordCurrentUser:
            return __USER_HANDLER.recordCurrentUser()

            //        case ___recordCurrentUser:
            //            //            __USER_HANDLER.recordCurrentUser(userInfo)
            //            return USERHANDLER.recordCurrentUser(userInfo)
            //        case ___userData:
            //            return runC.userData(0," ")
        }
    }

    id: root
    anchors.verticalCenter: parent.verticalCenter
    color: 'transparent'

    property bool click: false

    Component.onCompleted: {
        loginTimer.start()
        myLog("\nLogin.qml_nCompleted(){ Login component completed }")
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

    Rectangle{
        id:rootContainer
        color:'transparent'
        height: (__fieldHeight+__spacing)*4
        width: __fieldWidth
        anchors{
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        MyTextInput {
            id: userLogin
            height: __fieldHeight
            width:__fieldWidth
            textHint: "Digite seu email"
            iconPath: MyIcons.mailIcon
            inputMaskOption: emailFormat
            timerActive: false
            maxLengh: 50
            anchors {
                horizontalCenter: parent.horizontalCenter
                top:parent.top
            }
        }

        MyTextInput {
            id: userPassword
            textHint: "Digite sua senha"
            height: __fieldHeight
            width:__fieldWidth
            iconPath: MyIcons.passcodeIcon
            echoModeSelection: TextInput.Password
            inputMaskOption: numbersOnly
            timerActive: false
            maxLengh: 6
            anchors{
                horizontalCenter: parent.horizontalCenter
                top:userLogin.bottom
                topMargin: __spacing
            }
        }

        BusyIndicator {
            id: busyIndicator
            height: __fieldHeight
            palette.dark: MyColors.NIGHT_THEME_00
            anchors{
                horizontalCenter: parent.horizontalCenter
                top:userPassword.bottom
                topMargin: __spacing
            }
        }

        Text {
            visible: !busyIndicator.running
            height: userLogin.height * 0.5
            text: "Cadastre-se aqui" //animar a dica do texto diminuindo e subindo
            font.pixelSize: 15
            color: click ? MyColors.NIGHT_THEME_20 : MyColors.NIGHT_THEME_00
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors {
                horizontalCenter: parent.horizontalCenter
                top:userPassword.bottom
                topMargin: __spacing
            }                id: signInField
            MouseArea {
                id: signInFieldClick
                anchors.fill: parent
                onPressed: click=!click
                onClicked:   {stackView.push(signInQML)}
            }
        }

        MyButton {
            rootWidth: __fieldWidth
            rootHeight: __fieldHeight
            title: "enter"
            alignment: parent.horizontalCenter
            theme: 'white'
            onPressed: {}
            onReleased: {
                cpp_signIn(cvar_googleKey(),userLogin.myText,userPassword.myText)
                busyIndicator.running=true
                signCycle.start()
            }
            anchors{
                horizontalCenter: parent.horizontalCenter
                top:busyIndicator.bottom
                topMargin: __spacing
            }
        }
    }
}
