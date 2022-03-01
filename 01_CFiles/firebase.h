#ifndef FIREBASE_H
#define FIREBASE_H

#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QJsonDocument>
#include <QNetworkReply>
#include <QQmlProperty>
#include <QJsonObject>
#include <QObject>

#include "./01_CFiles/filehandler.h"
#include "./02_CObjects/UserClass.h"
#include "./02_CObjects/Constants.h"
#include "./02_CObjects/QmlClass.h"
#include "./02_CObjects/FirebaseClass.h"

class Firebase : public QObject
{
    Q_OBJECT
public:
    //    explicit Firebase(QObject *parent = 0);
    explicit Firebase(QObject *parent = nullptr);

    Q_INVOKABLE void signUp(const QString &token,const QString &email,const QString &password,const QString &displayName);
    Q_INVOKABLE void signIn(const QString &token,const QString &email,const QString &password);
    Q_INVOKABLE void firebaseAPI(QString token,QString stringToSend,QString uidPath,QString firebasePath,int requestType);
    Q_INVOKABLE int authComplete(bool reset);

    Q_INVOKABLE void initializer(bool debugValue,QString storagePath);

    Q_INVOKABLE void setMainQmlObject( QObject *value);

    void doPost(const QString &endPoint,const QJsonDocument &jsonData);
    void doPut(const QString &endPoint,const QJsonDocument &jsonData);
    void doPatch(const QString &endPoint,const QJsonDocument &jsonData);
    void doGet(const QString &endPoint);
    void doDelete(const QString &endPoint);

    Q_INVOKABLE QString getConstants();
    Q_INVOKABLE QString getUserData();

    Q_INVOKABLE void setDebug(bool active,QString path);

signals:

public slots:
    void networkReplyReadyRead();
    void getPostAnswer();

private:
    FileHandler fileHandler;
    UserClass userClass;
    static Constants constants;
    QmlClass qmlClass;
    FirebaseClass firebaseClass;

    QObject *mainQmlObject;
    void setQMLVariables(QString varName,QString varValue);

    QNetworkAccessManager *m_networkAccessManager;
    QNetworkReply *m_networkReply;
    QByteArray answer;
    void getIdToken(QByteArray answer);
    void networkConnections();
    void communicationFinished();
    void setCommunicationError();
    bool communicationError=false;
    int isAuthenticated;

    int atemptNumber=0;
    bool isTryingAgain=false;

    int restType;

//    colocar as contasntyes do isauth aki
};

#endif // FIREBASE_H
