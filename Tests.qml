import QtQuick 2.0

// MyText.qml
Text {
    enum TextType {
        Normal,
        Heading
    }

    property int textType: MyText.TextType.Normal

    font.bold: textType == MyText.TextType.Heading
    font.pixelSize: textType == MyText.TextType.Heading ? 24 : 12
}
