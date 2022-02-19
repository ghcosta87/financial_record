pragma Singleton

import QtQuick 2.0

QtObject {

    //  theme scheme selection
    readonly property int _default:0
    readonly property int _red:1
    readonly property int _colorful:2
    readonly property int _dark:3

    //  colors
    readonly property var _background: ['','','','#707070']

}
