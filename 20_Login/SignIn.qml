import QtQuick 2.0

Item {    
    property var title: ['texto 1','texto 2','texto 3']
    property int xPos
    property int yPos
    
    id:root
    height: 200
    width: 120
    x:xPos
    y:yPos

    Rectangle{
        anchors.fill: parent
        color: 'yellow'
        Column{
            spacing: 1
            anchors.fill: parent
            Repeater{
                id:myRepeater
                model: 3
                //                model:  ListModel {
                //                    id: myModel
                //                }
                delegate: Rectangle{
                    color: 'white'
                    border.width: 1
                    border.color: 'yellow'
                    Text {
                        id: name
                        anchors.fill: parent
                        text: title[index]
                    }
                }
            }
        }
    }
}
