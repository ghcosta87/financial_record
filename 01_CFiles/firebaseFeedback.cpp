#include <01_CFiles/firebase.h>

void Firebase::getPostAnswer()
{
    fileHandler.logRecorder("\ngetPostAnswer(){",fileHandler.getDebugOnline());
    fileHandler.logRecorder("Complete answer from server: "+QString(answer),fileHandler.getDebugOnline());
    fileHandler.logRecorder("restType > "+QString::number(restType),fileHandler.getDebugOnline());
    //        fileHandler.logRecorder("waitingToContinue > "+QString::number(waitingToContinue),fileHandler.getDebugOnline());
    //        fileHandler.logRecorder("waitingWhat > "+waitingWhat,fileHandler.getDebugOnline());

    switch (restType) {
    case Constants::LOGINREQUEST:
        fileHandler.logRecorder("\tanswer from loguin request:",fileHandler.getDebugOnline());
        getIdToken(answer);
        break;
    case Constants::PUTREQUEST:
        fileHandler.logRecorder("\tanswer from put request:",fileHandler.getDebugOnline());
        break;
    case Constants::UPDATEREQUEST:
        fileHandler.logRecorder("\tanswer from update request:",fileHandler.getDebugOnline());
        break;
    case Constants::GETREQUEST:
        setQMLVariables(qmlClass.firebaseData,answer);
        fileHandler.logRecorder("\tanswer from get request:",fileHandler.getDebugOnline());
        break;
    case Constants::POSTREQUEST:
        fileHandler.logRecorder("\tanswer from post request:",fileHandler.getDebugOnline());
        //            emit postReplyReceived();
        break;
    }
}

void Firebase::getIdToken(QByteArray answer)
{
    fileHandler.logRecorder("\ngetIdToken(){",fileHandler.getDebugOnline());
    QJsonDocument jsonDocument=QJsonDocument::fromJson(answer);

    if(jsonDocument.object().contains("error")){
        isAuthenticated=constants.ANSWERERROR;

        QString errorAlert;
        QString response=QString(answer);

        if(response.contains(constants.googleKey)){
            errorAlert="Wrong API Key, contact your administrator";
            if(response.contains(constants.emailError) || response.contains(constants.passError)){
                errorAlert="Wrong email or password";
            }
        } else if(response.contains(constants.keyMissing))errorAlert="API Key is missing, contact your administrator";
        else errorAlert="Unkown error ...";

        fileHandler.logRecorder("\t"+errorAlert,fileHandler.getDebugOnline());
        fileHandler.logRecorder("getIdToken got an error = "+QString::number(isAuthenticated),fileHandler.getDebugOnline());

        setQMLVariables(qmlClass.alertMessage,errorAlert);
//        setQMLVariables(qmlClass.isAuthenticated,QString::number(isAuthenticated));

    }else if(jsonDocument.object().contains("registered")){
        isAuthenticated=constants.AUTHENTICATED;

        userClass.token=jsonDocument.object().value("idToken").toString();
        userClass.id=jsonDocument.object().value("localId").toString();
        userClass.email=jsonDocument.object().value("email").toString();
        userClass.name=jsonDocument.object().value("displayName").toString();

//        setQMLVariables(qmlClass.isAuthenticated,QString::number(isAuthenticated));
        setQMLVariables(qmlClass.userData,userClass.getData().toJson(QJsonDocument::Compact));
        setQMLVariables(qmlClass.alertMessage,"Login completed...");

        isTryingAgain=false;

        fileHandler.logRecorder("\t"+jsonDocument.toJson(QJsonDocument::Compact),fileHandler.getDebugOnline());
        fileHandler.logRecorder("\tgetIdToken got the idtoken = "+QString::number(isAuthenticated),fileHandler.getDebugOnline());

    }else{
        isAuthenticated=constants.ANSWERERROR;
        isTryingAgain=true;
        atemptNumber++;
        if(atemptNumber>3){
            atemptNumber=0;
            isTryingAgain=false;
            setQMLVariables(qmlClass.alertMessage,"Unkown error ...");

        }
        if(isTryingAgain)signIn(userClass.token,userClass.email,userClass.pass);
        fileHandler.logRecorder("\tsomething wrong happen ...",fileHandler.getDebugOnline());
    }

    setQMLVariables(qmlClass.isAuthenticated,QString::number(isAuthenticated));
    fileHandler.logRecorder("\tend of getIdToken()\n}",fileHandler.getDebugOnline());
}

int Firebase::authComplete(bool reset)
{
    if(reset){
        isAuthenticated=constants.NOTAUTHENTICATED;
        fileHandler.logRecorder("\nauthComplete(){ isAuthenticated reseted }",fileHandler.getDebugOnline());
    }else if (isAuthenticated!=constants.NOTAUTHENTICATED)fileHandler.logRecorder("\nauthComplete(){ isAuthenticated = "+QString::number/*intToString*/(isAuthenticated)+"}",fileHandler.getDebugOnline());

    return isAuthenticated;
}

void Firebase::communicationFinished()
{
    //    logRecorder("\ncommunicationFinished(){",debugOnline);
    //    logRecorder("waitingToContinue: "+QString::number(waitingToContinue),debugOnline);
    //    logRecorder("waitingWhat: "+waitingWhat,debugOnline);

    //    if(answer.length()<2)answer = m_networkReply->readAll();

    //    switch (waitingToContinue) {
    //    case _bankDocumentIndex:
    //        notifyComplete("Banco salvo na nuvem",waitingWhat);
    //        break;
    //    case _statmentDocumentIndex:
    //        notifyComplete("Entrada salva na nuvem",waitingWhat);
    //        break;
    //    case _billsDocumentIndex:
    //        if(m_requestType==PUTREQUEST || m_requestType==POSTREQUEST)
    //            notifyComplete("Conta gravada",waitingWhat);
    //        if(m_requestType==UPDATEREQUEST)
    //            notifyComplete("Conta atualizada",waitingWhat);
    //        break;
    //    case _billsUpdateIndex:
    //        if(m_requestType==UPDATEREQUEST)
    //            notifyComplete("Contas Pendentes",waitingWhat);
    /*
         * se é pedido de atualização
         *      -> envia pro qml o q foi atualizado & soma n total de contas enviadas
         *          => qml atualiza o banco local
         *      -> quando o total de contas atualizadas = total de contas
         *          => envia pro qml o snackbar dizendo atualização concluida
         */
    //        break;

    //    }
    //    logRecorder("}\n",debugOnline);
}

void Firebase::setCommunicationError()
{
    communicationError=true;
}

void Firebase::setQMLVariables(QString varName,QString varValue)
{
    fileHandler.logRecorder("\nsetQmlVariables(varName:"+varName+",varValue:"+varValue+"){}",fileHandler.getDebugOnline());
    QQmlProperty::write(mainQmlObject, varName, varValue);
}

void Firebase::setDebug(bool active, QString path)
{
    fileHandler.setDebugOnline(active);
    fileHandler.setDataStoragePath(path);
}
