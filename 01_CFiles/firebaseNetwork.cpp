#include <01_CFiles/firebase.h>


void Firebase::doPost(const QString &endPoint,const QJsonDocument &jsonData)
{
    QNetworkRequest newRequest((QUrl(endPoint)));
    newRequest.setHeader(QNetworkRequest::ContentTypeHeader,QString("application/json"));
    m_networkReply=m_networkAccessManager->post(newRequest,jsonData.toJson());
    networkConnections();
    fileHandler.logRecorder("\ndoPost("+endPoint+","+jsonData.toJson(QJsonDocument::Compact)+"){\ndoPost completed\n}\n",fileHandler.getDebugOnline());
}

void Firebase::networkConnections()
{
    fileHandler.logRecorder("\nnetworkConnections(){",fileHandler.getDebugOnline());

    if(!isTryingAgain)atemptNumber=0;

//    fileHandler.logRecorder("is internal request?\n\tinternalRequest:"+QString::number(internalRequest),fileHandler.getDebugOnline());
//    fileHandler.logRecorder("how many atempts so far?\n\tm_tryAgain:"+QString::number(m_tryAgain),fileHandler.getDebugOnline());

    if(isTryingAgain && atemptNumber<3){
        connect(m_networkReply,&QNetworkReply::readyRead,this,&Firebase::networkReplyReadyRead);
//        connect(m_networkReply,&QNetworkReply::finished,this,&Firebase::getPostAnswer);
        fileHandler.logRecorder("early finished",fileHandler.getDebugOnline());
        fileHandler.logRecorder("end of networkConnections()\n}\n",fileHandler.getDebugOnline());
        return;
    }else{
        isTryingAgain=false;
        atemptNumber=0;
    }

//    if(internalRequest && m_tryAgain<3){
//        connect(m_networkReply,&QNetworkReply::readyRead,this,&c_interface::networkReplyReadyRead);
//        connect(m_networkReply,&QNetworkReply::finished,this,&c_interface::getPostAnswer);
//        fileHandler.logRecorder("early finished",fileHandler.getDebugOnline());
//        fileHandler.logRecorder("end of networkConnections()\n}\n",fileHandler.getDebugOnline());
//        return;
//    }else{
//        internalRequest=false;
//        m_tryAgain=0;
//    }

    connect(m_networkReply,&QNetworkReply::readyRead,this,&Firebase::networkReplyReadyRead);
//    connect(m_networkReply,&QNetworkReply::errorOccurred,this,&c_interface::m_networkReplyError);

//    if(restType==LOGINREQUEST)connect(m_networkReply,&QNetworkReply::finished,this,&c_interface::getPostAnswer);
//    else connect(m_networkReply,&QNetworkReply::finished,this,&c_interface::communicationFinished);  // usar o finished para verificar o erro e filtrar as ações

    fileHandler.logRecorder("end of networkConnections()\n}\n",fileHandler.getDebugOnline());
}

void Firebase::networkReplyReadyRead()
{
    fileHandler.logRecorder("\nnetworkReplyReadyRead(){",fileHandler.getDebugOnline());
    fileHandler.logRecorder("network reply is ready to read",fileHandler.getDebugOnline());
    answer = m_networkReply->readAll();
    fileHandler.logRecorder("answer is: ",fileHandler.getDebugOnline());
    fileHandler.logRecorder(answer,fileHandler.getDebugOnline());
    fileHandler.logRecorder("end of networkReplyReadyRead()\n}\n",fileHandler.getDebugOnline());
    //    saveJson(answer,"bank_document");   //  need to organize
    //    generateChecksum(answer); // under test
    //    logRecorder("Complete answer from server: "+QString(answer),debugOnline);
}

void Firebase::getPostAnswer()
{
//        logRecorder("\ngetPostAnswer(){",debugOnline);
//        logRecorder("Complete answer from server: "+QString(answer),debugOnline);
//        logRecorder("restType > "+QString::number(restType),debugOnline);
//        logRecorder("waitingToContinue > "+QString::number(waitingToContinue),debugOnline);
//        logRecorder("waitingWhat > "+waitingWhat,debugOnline);

        switch (restType) {
        case LOGINREQUEST:
//            getIdToken(answer);
            break;
        case PUTREQUEST:
            //            break;
        case UPDATEREQUEST:
            break;
        case GETREQUEST:
            break;
        case POSTREQUEST:
//            emit postReplyReceived();
            break;
        }
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
