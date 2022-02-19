import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.0
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.15

import QtQuick.Window 2.2
import QtQml.Models 2.2

import '.'
import './03_MyComponents'
import './10_CodeLibrary'
import './10_CodeLibrary/Styles'

Window {
    // ############ application constants ############
    readonly property string versionNumber: '20.0'

    // ############# application pragmas #############
    readonly property var _LIBCOLOR: MyColors
    readonly property var _LIBFONT: MyFont

    // ############ application variables ############
    property int theme: _LIBCOLOR._dark

    // ########## application font control ###########
    readonly property string font: defaultFont.name
    readonly property var setFont: (fontName)=>{defaultFont.source=fontName}
    FontLoader {
        id: defaultFont
        source: _LIBFONT._robotoThin
    }

    // ########### user control variables ############
    property bool userLogged: false

    // ############### SQL constants #################
    readonly property string dbId: 'MyDatabase'
    readonly property string dbVersion: '1.0'
    readonly property string dbDescription: 'Database application'
    readonly property int dbsize: 1000000
    property var db

    // ############## C functions ###############
    // => FileHandler
    readonly property var cpp_debugStatus: fileHandler.getDebugOnline   //    -
    readonly property var cpp_setDebug: fileHandler.setDebugOnline      // ( bool )
    readonly property var cpp_dataLog: fileHandler.logRecorder          // ( string , bool )
    readonly property var cpp_setPath: fileHandler.setDataStoragePath   // ( string )

    // ############## global functions ###############
    function myLog(myLogArg){
        cpp_dataLog(myLogArg,cpp_debugStatus())
    }

    //    function showSnackBar(message){
    //        snackBar.snackBarText=message
    //        snackBar.fadeIn.running=true
    //        snackBar.snackBarTimeOut=1000
    //        snackBar.snackBarShowTime=1000
    //    }

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
        cpp_setPath(storagePath)
        myLog('\nmain.qml_onCompleted(){}')
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
        anchors{
            fill:parent
            topMargin: (userLogged) ? header.height : 0
            bottomMargin: (userLogged) ? footer.height : 0
        }
    }

    MyFooter{
        id:footer
        clip:true
        width:parent.width
        height: (userLogged) ? parent.height*0.14 : 0
        anchors.bottom:parent.bottom
    }
}
