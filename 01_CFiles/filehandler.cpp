#include "filehandler.h"

FileHandler::FileHandler(QObject *parent)
    : QObject{parent}
{
    setDebugOnline(true);
}

void FileHandler::logRecorder(QString dataRecord, bool active)
{
    if(active){
        //        QString recordMoment;
        time_t     now = time(0);
        struct tm  tstruct;
        char       buf[80];
        tstruct = *localtime(&now);
        strftime(buf, sizeof(buf), "%Y-%m-%d.%X", &tstruct);
        QString filename = getDataStoragePath()+"/debug.log";
        QFile file(filename);
        if (file.open(QIODevice::Append)) {
            QTextStream stream(&file);
            //            stream<< buf << ": " << dataRecord << Qt::endl;
            stream<<" " << dataRecord << Qt::endl;
        }
    }
}

void FileHandler::initializer(bool debugValue, QString storagePath)
{
    setDebugOnline(debugValue);
    setDataStoragePath(storagePath);
}

 QString FileHandler::getDataStoragePath()
{
    return dataStoragePath;
}
void FileHandler::setDataStoragePath(QString newDataStoragePath)
{
    dataStoragePath = newDataStoragePath;
}

 QString FileHandler::getGoogleKey()
{
    return googleKey;
}void FileHandler::setGoogleKey()
{
    QFile inputFile(dataStoragePath+"/google.key");
    if (inputFile.open(QIODevice::ReadOnly))
    {
        QTextStream in(&inputFile);
        while (!in.atEnd())
        {
            QString line = in.readLine();
            googleKey= line;
        }
        inputFile.close();
    }else googleKey="";
}

QString FileHandler::getRapidApiKey()
{
    return rapidApiKey;
}
void FileHandler::setRapidApiKey()
{
    QFile inputFile(dataStoragePath+"/rapidapi.key");
    if (inputFile.open(QIODevice::ReadOnly))
    {
        QTextStream in(&inputFile);
        while (!in.atEnd())
        {
            QString line = in.readLine();
            rapidApiKey=line;
        }
        inputFile.close();
    }else rapidApiKey="";
}

bool FileHandler::getDebugOnline()
{
    return debugOnline;
}

void FileHandler::setDebugOnline(bool newDebugOnline)
{
    debugOnline = newDebugOnline;
}
