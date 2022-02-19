import QtQuick 2.12
import QtQuick.Controls 2.12

import '.'
import './20_Login'

Item {

    StackView {
        id: stackView
        anchors.fill: parent
        clip: false
        initialItem: loginQML
    }

    Component{id:loginQML;Login{}}

    Component{id:signInQML;SignIn{}}

    Component{id:testQML;Tests{}}
}
