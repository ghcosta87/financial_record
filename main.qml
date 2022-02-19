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

    //  application variables
    property int theme: _LIBCOLOR._dark

    //  user control variables
    property bool userLogged: false



    id: mainWindow
    width: 360
    height: 640
    visible:true
    //    visibility: SCRIPTS.visibilityType()
    title: qsTr("Financial record "+ versionNumber)

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
