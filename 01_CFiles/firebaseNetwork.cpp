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

    fileHandler.logRecorder("\tsetting up connections ...",fileHandler.getDebugOnline());

    connect(m_networkReply,&QNetworkReply::readyRead,this,&Firebase::networkReplyReadyRead);
    connect(m_networkReply,&QNetworkReply::errorOccurred,this,&Firebase::setCommunicationError);
    connect(m_networkReply,&QNetworkReply::finished,this,&Firebase::getPostAnswer);

    if(isTryingAgain && atemptNumber>3){
        isTryingAgain=false;
        atemptNumber=0;

        fileHandler.logRecorder("\treseting error counter ...",fileHandler.getDebugOnline());
    }else fileHandler.logRecorder("\t this is the "+QString::number(atemptNumber )+"·̣ atempt",fileHandler.getDebugOnline());

    //    fileHandler.logRecorder("is internal request?\n\tinternalRequest:"+QString::number(internalRequest),fileHandler.getDebugOnline());
    //    fileHandler.logRecorder("how many atempts so far?\n\tm_tryAgain:"+QString::number(m_tryAgain),fileHandler.getDebugOnline());

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

//    connect(m_networkReply,&QNetworkReply::readyRead,this,&Firebase::networkReplyReadyRead);
    //    connect(m_networkReply,&QNetworkReply::errorOccurred,this,&c_interface::m_networkReplyError);



    fileHandler.logRecorder("end of networkConnections()\n}\n",fileHandler.getDebugOnline());
}

void Firebase::networkReplyReadyRead()
{
    fileHandler.logRecorder("\nnetworkReplyReadyRead(){",fileHandler.getDebugOnline());
    fileHandler.logRecorder("network reply is ready to read ... ",fileHandler.getDebugOnline());
    answer = m_networkReply->readAll();
    fileHandler.logRecorder("answer is: ",fileHandler.getDebugOnline());
    fileHandler.logRecorder(answer,fileHandler.getDebugOnline());
    fileHandler.logRecorder("end of networkReplyReadyRead()\n}\n",fileHandler.getDebugOnline());
    //    saveJson(answer,"bank_document");   //  need to organize
    //    generateChecksum(answer); // under test
    //    logRecorder("Complete answer from server: "+QString(answer),debugOnline);
}

