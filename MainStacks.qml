import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.LocalStorage 2.0
import Qt.labs.platform 1.0
import QtGraphicalEffects 1.15

import QtQuick.Window 2.2
import QtQml.Models 2.2

Item {

    StackView {
        id: stackView
        anchors.fill: parent
        anchors.margins: 20
        clip: false
        initialItem: loginForm
        pushEnter: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 500
            }
        }
        pushExit: Transition {
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 500
            }
        }
    }

}
