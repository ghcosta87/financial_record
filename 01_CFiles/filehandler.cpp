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
        QString filename = dataStoragePath+"/debug.log";
        QFile file(filename);
        if (file.open(QIODevice::Append)) {
            QTextStream stream(&file);
//            stream<< buf << ": " << dataRecord << Qt::endl;
            stream<<" " << dataRecord << Qt::endl;
        }
    }
}

bool FileHandler::getDebugOnline() const
{
    return debugOnline;
}

void FileHandler::setDebugOnline(bool newDebugOnline)
{
    debugOnline = newDebugOnline;
}

const QString &FileHandler::getDataStoragePath() const
{
    return dataStoragePath;
}

void FileHandler::setDataStoragePath(const QString &newDataStoragePath)
{
    dataStoragePath = newDataStoragePath;
}
