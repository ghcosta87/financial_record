import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.0
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.15

import QtQuick.Window 2.2
import QtQml.Models 2.2

import '.'
import './03_MyComponents'

Window {
    readonly property string versionNumber: '20.0'

    id: mainWindow
    width: 360
    height: 640
    visible:true
    //    visibility: SCRIPTS.visibilityType()
    title: qsTr("Financial record "+ versionNumber)

    MainStacks{
        anchors.fill:parent
    }

    /*
header

body

footer
*/

}
