pragma Singleton

import QtQuick 2.0

QtObject {
    property string name
    property string email
    property string token
    property string pass
    property string id

    property var setObj:(new_name,new_email,new_token,new_pass,new_id)=>{
        name=new_name
        email=new_email
        token=new_token
        pass=new_pass
        id=new_id
    }

    property var getObj: ()=>{
        let obj=new Object
        obj['name']=name
        obj['email']=email
        obj['token']=token
        obj['pass']=pass
        obj['id']=id
        return obj
    }
}
