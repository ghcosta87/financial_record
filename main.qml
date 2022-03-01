import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.0
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.15

import QtQuick.Window 2.2
import QtQml.Models 2.2

import '.'
import './03_MyComponents'
import './10_LogicLibrary'
import './10_LogicLibrary/Styles'
import './10_LogicLibrary/SqlTables'

import './11_Handlers/UserHandler.js' as UserHandler
import './11_Handlers/FirebaseHandler.js' as FirebaseHandler


import './10_LogicLibrary/AppObjs'

ApplicationWindow {
    // ############ application constants ############
    readonly property string versionNumber: '20.6'
    readonly property string emptyField: '---'

    // ############# application pragmas #############
    readonly property var _LIBCOLOR: MyColors
    readonly property var _LIBFONT: MyFont

    // ############ application variables ############
    property int theme: _LIBCOLOR._dark

    // ############ application settings #############
    property bool logEnable: true

    // ########## application font control ###########
    readonly property string myFont: defaultFont.name
    readonly property var setFont: (fontName)=>{defaultFont.source=fontName}
    FontLoader {
        id: defaultFont
        source: _LIBFONT._robotoThin
    }

    // ############# application sizes ###############
    property real __fieldHeight: mainWindow.height*0.096
    property real __fieldWidth: mainWindow.width*0.78
    property real __spacing: mainWindow.width*0.08

    // ########### user control variables ############
    property bool userLogged: false

    // ############### SQL constants #################
    readonly property string dbId: 'MyDatabase'
    readonly property string dbVersion: '1.0'
    readonly property string dbDescription: 'Database application'
    readonly property int dbsize: 1000000

    // ############ SQL Table commands ################
    readonly property var __USER_TABLE: UserTable

    // ############ Javascript Handlers ###############
    readonly property var __USER_HANDLER: UserHandler
    readonly property var __FIREBASE_HANDLER: FirebaseHandler

    // ################## Objects ####################
    readonly property var userObj: UserObj

    // ################ C functions ##################
    // => FileHandler
    readonly property var cpp_setDebug: fileHandler.setDebugOnline         // ( bool )
    readonly property var cpp_dataLog: fileHandler.logRecorder             // ( string , bool )
    readonly property var cpp_setPath: fileHandler.setDataStoragePath      // ( string )
    readonly property var cpp_setGoogleKey: fileHandler.setGoogleKey       // ( )
    readonly property var cpp_setRapidApiKey: fileHandler.setRapidApiKey   // ( )
    // => Firebase
    readonly property var cpp_firebaseInit: firebase.initializer           // ( bool , string )
    readonly property var cpp_signUp: firebase.signUp                      // ( string , sring )
    readonly property var cpp_signIn: firebase.signIn                      // ( string , sring )
    readonly property var cpp_firebaseLog: firebase.setDebug               // ( bool,string )
    readonly property var cpp_firebaseAPI: firebase.firebaseAPI               // ( bool,string )


    // ################ C variables ##################
    // => FileHandler
    readonly property var cvar_debugStatus: fileHandler.getDebugOnline
    readonly property var cvar_googleKey: fileHandler.getGoogleKey
    readonly property var cvar_rapidApiKey: fileHandler.getRapidApiKey
    // => Firebase
    property var qmlVar_userData
    onQmlVar_userDataChanged: {
        let myData=JSON.parse(qmlVar_userData)
        userObj.token=myData.token
        userObj.id=myData.id
        userObj.email=myData.email
        userObj.name=myData.name
        userObj.pass=myData.pass
    }
    property string qmlVar_firebaseRestError:''
    onQmlVar_firebaseRestErrorChanged: {
        if(qmlVar_firebaseRestError!=emptyField)alert.show(qmlVar_firebaseRestError)
        qmlVar_firebaseRestError=emptyField
    }

    property var qmlVar_isAuthenticated
    onQmlVar_isAuthenticatedChanged: {
        console.log('LOGGED => qmlVar_isAuthenticated:'+qmlVar_isAuthenticated)
    }

    property var qmlVar_firebaseData
    onQmlVar_firebaseDataChanged: {
        alert.show('Database updated')
        myLog('\nonQmlVar_firebaseDataChanged{\n'+qmlVar_firebaseData+"\n}")
    }

    // ################ C constants ##################
    readonly property var cParse: JSON.parse(firebase.getConstants())
    readonly property int _REST_PUTREQUEST: cParse.PUTREQUEST
    readonly property int _REST_UPDATEREQUEST: cParse.UPDATEREQUEST
    readonly property int _REST_POSTREQUEST: cParse.POSTREQUEST
    readonly property int _REST_LOGINREQUEST: cParse.LOGINREQUEST
    readonly property int _REST_GETREQUEST: cParse.GETREQUEST
    readonly property int _REST_DELETEREQUEST: cParse.DELETEREQUEST

    readonly property string _LOGIN_NOTAUTHENTICATED: cParse.NOTAUTHENTICATED
    readonly property string _LOGIN_AUTHENTICATED: cParse.AUTHENTICATED
    readonly property string _LOGIN_ANSWERERROR: cParse.ANSWERERROR
    readonly property string _LOGIN_INCOMPLETEMSG: cParse.INCOMPLETEMSG

    // ############## global functions ###############
    function myLog(myLogArg){
        cpp_dataLog(myLogArg,cvar_debugStatus())
    }

    function errorHandling(functionInput,errorString){  //  call back function to handle the errors
        try{
            functionInput()
            return true
        }catch(e){
            myLog('\n\t\t>ERROR<\n\tgot an error from '+errorString)
            myLog('\tmessage: '+e.message+'\n')
            return false
        }
    }

    function openDatabase(){    // open database withtry catch protection
        try {
            return LocalStorage.openDatabaseSync(dbId, dbVersion,
                                                 dbDescription, dbsize)
        } catch (err) {
            myLog('☓ openDatabase error: '+err.message)
            return null
        }
    }

    function valueNullHandling(value,type){ //  return value for an undefined or null
        switch(type){
        case 'text':
            if(typeof value==='undefined' || value === null)return ' '
            break
        case 'number':
            if(typeof value==='undefined' || value === null)return 0
            break
        }
        return value
    }

    id: mainWindow
    width: 360
    height: 640
    visible:true
    title: qsTr("Financial record "+ versionNumber)

    Component.onCompleted: {
        firebase.setMainQmlObject(mainWindow)

        cpp_firebaseLog(logEnable,storagePath)
        cpp_setPath(storagePath)
        cpp_setGoogleKey()
        cpp_setRapidApiKey()

        __USER_HANDLER.createUserTable()

        myLog('\nmain.qml_onCompleted(){\n\tinicial variables =>{\n\t\tstoragePath: '+storagePath+'\n\t\tgoogle key: '+cvar_googleKey()+'\n\t\t rapidApi Key: '+cvar_rapidApiKey()+'\n\t\tdebug status: '+cvar_debugStatus()+'}')
    }

    Rectangle{
        anchors.fill:parent
        color: _LIBCOLOR._background[theme]
    }

    MyHeader{
        id:header
        clip:true
        width:parent.width
        height: (userLogged) ? parent.height*0.14 : 0
        anchors.top:parent.top
    }

    MainStacks{
        id:mainStacks
        anchors{
            fill:parent
            topMargin: (userLogged) ? header.height : 0
            bottomMargin: (userLogged) ? footer.height : 0
        }
    }

    QuickAccessBar{
        id:footer
        clip:true
        width:parent.width
        height: (userLogged) ? parent.height*0.14 : 0
        anchors.bottom:parent.bottom
    }

    MyAlert{
        id:alert
        alertBarFont: myFont
        height: parent.height*0.06
        alertBarRadius: parent.width*0.1
        alertBarTextColor: 'white'
        alertBarBackgroundColor: 'black'
        anchors{
            top: parent.top
            topMargin: parent.height*0.85
            horizontalCenter: parent.horizontalCenter
        }
    }
}

