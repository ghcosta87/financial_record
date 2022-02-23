#include <01_CFiles/firebase.h>

Firebase::Firebase(QObject *parent)
    : QObject{parent}
{
  m_networkAccessManager = new QNetworkAccessManager(this);
}

void Firebase::signUp(const QString &token,const QString &email,const QString &password)
{
    fileHandler.logRecorder("\nsignUp(const QString &token:"+token+",const QString &email:"+email+",const QString &password:"+password+"){",fileHandler.getDebugOnline());

    QString link="https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=";
    QString singInEndPoint = link+token;

    QVariantMap authData;
    authData["email"]=email;
    authData["password"]=password;
    authData["returnSecureToken"]=true;
    //    setUserPass(password);

    QJsonDocument jsonPayload=QJsonDocument::fromVariant(authData);
    fileHandler.logRecorder("doPost with credentials",fileHandler.getDebugOnline());

    restType=LOGINREQUEST;
    doPost(singInEndPoint,jsonPayload);
    fileHandler.logRecorder("}\n",fileHandler.getDebugOnline());
}

void Firebase::signIn(const QString &token, const QString &email, const QString &password)
{
    fileHandler.logRecorder("\nsignIn(const QString &token:"+token+",const QString &email:"+email+",const QString &password:"+password+"){",fileHandler.getDebugOnline());

    QString link="https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";
    QString singInEndPoint = link+token;

    QVariantMap authData;
    authData["email"]=email;
    authData["password"]=password;
    authData["returnSecureToken"]=true;
    //    setUserPass(password);

    QJsonDocument jsonPayload=QJsonDocument::fromVariant(authData);
    fileHandler.logRecorder("doPost with credentials",fileHandler.getDebugOnline());

    restType=LOGINREQUEST;
    doPost(singInEndPoint,jsonPayload);
    fileHandler.logRecorder("}\n",fileHandler.getDebugOnline());
}

void Firebase::initializer(bool debugValue, QString storagePath)
{
    fileHandler.setDebugOnline(debugValue);
    fileHandler.setDataStoragePath(storagePath);
}

int Firebase::getPUTREQUEST(){return PUTREQUEST;}
int Firebase::getUPDATEREQUEST(){return UPDATEREQUEST;}
int Firebase::getPOSTREQUEST(){return POSTREQUEST;}
int Firebase::getLOGINREQUEST(){return LOGINREQUEST;}
int Firebase::getGETREQUEST(){return GETREQUEST;}
int Firebase::getDELETEREQUEST(){return DELETEREQUEST;}


