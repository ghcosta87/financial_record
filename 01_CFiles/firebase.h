#ifndef FIREBASE_H
#define FIREBASE_H

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QNetworkReply>
#include <QObject>

#include "./01_CFiles/filehandler.h"

class Firebase : public QObject
{
    Q_OBJECT
public:
    //    explicit Firebase(QObject *parent = 0);
    explicit Firebase(QObject *parent = nullptr);

    Q_INVOKABLE void signUp(const QString &token,const QString &email,const QString &password);
    Q_INVOKABLE void signIn(const QString &token,const QString &email,const QString &password);

    Q_INVOKABLE void initializer(bool debugValue,QString storagePath);

    void doPost(const QString &endPoint,const QJsonDocument &jsonData);
    void doPut(const QString &endPoint,const QJsonDocument &jsonData);
    void doPatch(const QString &endPoint,const QJsonDocument &jsonData);
    void doGet(const QString &endPoint);
    void doDelete(const QString &endPoint);

    Q_INVOKABLE static int getPUTREQUEST();
    Q_INVOKABLE static int getUPDATEREQUEST();
    Q_INVOKABLE static int getPOSTREQUEST();
    Q_INVOKABLE static int getLOGINREQUEST();
    Q_INVOKABLE static int getGETREQUEST();
    Q_INVOKABLE static int getDELETEREQUEST();

signals:

public slots:
    void networkReplyReadyRead();
    void getPostAnswer();

private:
    FileHandler fileHandler;

    QNetworkAccessManager *m_networkAccessManager;
    QNetworkReply *m_networkReply;
    void networkConnections();
    void communicationFinished();
    QByteArray answer;

    int atemptNumber=0;
    bool isTryingAgain=false;

    int restType;
    const static int PUTREQUEST=0;
    const static int UPDATEREQUEST=1;
    const static int POSTREQUEST=2;
    const static int LOGINREQUEST=3;
    const static int GETREQUEST=4;
    const static int DELETEREQUEST=6;
};

#endif // FIREBASE_H
