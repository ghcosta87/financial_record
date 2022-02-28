import QtQuick 2.12
import QtQuick.Controls 2.12

import '.'
import './20_Login'
import './21_Main'

Item {

    StackView {
        id: stackView
        anchors.fill: parent
        clip: false
        initialItem: loginQML
    }

    Component{id:loginQML;Login{}}

    Component{id:signInQML;SignIn{}}

    Component{id:homePage;HomePage{}}

    Component{id:testQML;Tests{}}
}
