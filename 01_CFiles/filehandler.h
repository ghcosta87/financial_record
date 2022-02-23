#ifndef FILEHANDLER_H
#define FILEHANDLER_H

#include <QTextStream>
#include <QObject>
#include <QFile>
#include <QDebug>

class FileHandler : public QObject
{
    Q_OBJECT

public:
    explicit FileHandler(QObject *parent = 0);

    Q_INVOKABLE void logRecorder(QString dataRecord,bool active);

    Q_INVOKABLE void initializer(bool debugValue,QString storagePath);

    Q_INVOKABLE bool getDebugOnline();
    void setDebugOnline(bool newDebugOnline);

    Q_INVOKABLE QString getDataStoragePath() ;
    Q_INVOKABLE void setDataStoragePath(QString newDataStoragePath);

    Q_INVOKABLE QString getGoogleKey() ;
    Q_INVOKABLE void setGoogleKey();

    Q_INVOKABLE QString getRapidApiKey() ;
    Q_INVOKABLE void setRapidApiKey();

signals:

private:
    bool debugOnline;
    QString dataStoragePath;

    QString googleKey;
    QString rapidApiKey;
};

#endif // FILEHANDLER_H
