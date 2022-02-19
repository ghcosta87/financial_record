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
    explicit FileHandler(QObject *parent = nullptr);

    Q_INVOKABLE void logRecorder(QString dataRecord,bool active);

    Q_INVOKABLE bool getDebugOnline() const;
    Q_INVOKABLE void setDebugOnline(bool newDebugOnline);

    const QString &getDataStoragePath() const;
    Q_INVOKABLE void setDataStoragePath(const QString &newDataStoragePath);

signals:

private:
    bool debugOnline;
    QString dataStoragePath;
};

#endif // FILEHANDLER_H
