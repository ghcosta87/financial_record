pragma Singleton

import QtQuick 2.0

QtObject {
    property var bank_document
    property string bills
    property string card_document
    property string fullStatment
    property string id

    property var setObj:()=>{

    }

    property var getObj: ()=>{
        let obj=new Object
//        obj['name']=name
        return obj
    }
}
