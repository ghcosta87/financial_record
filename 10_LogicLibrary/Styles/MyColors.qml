pragma Singleton

import QtQuick 2.0

QtObject {

    //  theme scheme selection
    readonly property int _default:0
    readonly property int _red:1
    readonly property int _colorful:2
    readonly property int _dark:3

    readonly property string _dark_primary: '#9e9e9e'
    readonly property string _dark_light: '#cfcfcf'
    readonly property string _dark_dark: '#707070'

    //  colors
    readonly property var _background: ['','','',_dark_dark]
}
