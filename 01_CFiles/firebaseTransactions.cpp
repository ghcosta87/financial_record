#include <01_CFiles/firebase.h>

void Firebase::firebaseAPI(QString token,QString stringToSend,QString uidPath,QString firebasePath,int requestType)
{
    fileHandler.logRecorder("\ntalkToFirebase(){\t\nrequestType is > "+constants.getNames(requestType),fileHandler.getDebugOnline());

    QString firebaseLink="https://qfintechapp-default-rtdb.firebaseio.com/";
    QString authElement=".json?auth=";
    QString endPoint=firebaseLink+uidPath+'/'+firebasePath+authElement+token;
    QJsonDocument jsonToSend;

    //      stringToSend=keyValidation(stringToSend);

    if(stringToSend!="")jsonToSend= QJsonDocument::fromJson(stringToSend.toUtf8());
    fileHandler.logRecorder("\tendpoint > "+endPoint+"\n\tstringToSend > "+stringToSend+"\n\tjsonToSend > "+jsonToSend.toJson(QJsonDocument::Compact),fileHandler.getDebugOnline());

    restType=requestType;

    userClass.token=token;
    userClass.id=uidPath;
    firebaseClass.stringToSend=stringToSend;
    firebaseClass.path=firebasePath;
    firebaseClass.restType=requestType;

    switch (requestType) {
    case Constants::PUTREQUEST:
//        doPut(endPoint,jsonToSend);
        break;
    case Constants::UPDATEREQUEST:
//        doPatch(endPoint,jsonToSend);
        break;
    case Constants::POSTREQUEST:
        doPost(endPoint,jsonToSend);
        break;
    case Constants::GETREQUEST:
        doGet(endPoint);
        break;
    case Constants::DELETEREQUEST:
//        doDelete(endPoint);
        break;
    }

    //      logRecorder("end of talkToFirebase()\n}\n",debugOnline);
}
