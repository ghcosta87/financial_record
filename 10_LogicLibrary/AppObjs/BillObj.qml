pragma Singleton

import QtQuick 2.0

QtObject {
    property string name
    property string category
    property string tax
    property string expire
    property string bank
    property string auto
    property string value
    property string nextValue
    property string status
    property string link
    property string sinc

    property var sqlData: []
    property var firebaseData: []

    property var exportValue: {
        'name':name,
        'category':category,
        'tax':tax,
        'expire':expire,
        'bank':bank,
        'auto':auto,
        'value':value,
        'nextValue':nextValue,
        'status':status,
        'link':link,
        'sinc':sinc
    }
}
