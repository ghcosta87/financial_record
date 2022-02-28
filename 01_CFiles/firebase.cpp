#include <01_CFiles/firebase.h>

Firebase::Firebase(QObject *parent)
    : QObject{parent}
{
//    fileHandler.setDebugOnline(true);
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

    restType=constants.LOGINREQUEST;
    doPost(singInEndPoint,jsonPayload);
    fileHandler.logRecorder("}\n",fileHandler.getDebugOnline());
}

void Firebase::signIn(const QString &token, const QString &email, const QString &password)
{
    fileHandler.logRecorder("\nsignIn(const QString &token:"+token+",const QString &email:"+email+",const QString &password:"+password+"){",fileHandler.getDebugOnline());

    QString link="https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=";
    QString singInEndPoint = link+token;

    userClass.token=token;
    userClass.email=email;
    userClass.pass=password;
    answer="";

    QVariantMap authData;
    authData["email"]=email;
    authData["password"]=password;
    authData["returnSecureToken"]=true;
    //    setUserPass(password);

    QJsonDocument jsonPayload=QJsonDocument::fromVariant(authData);
    fileHandler.logRecorder("doPost with credentials",fileHandler.getDebugOnline());

    restType=constants.LOGINREQUEST;
    doPost(singInEndPoint,jsonPayload);
    fileHandler.logRecorder("}\n",fileHandler.getDebugOnline());
}

void Firebase::initializer(bool debugValue, QString storagePath)
{
    fileHandler.setDebugOnline(debugValue);
    fileHandler.setDataStoragePath(storagePath);
}

void Firebase::setMainQmlObject(QObject *value)
{
    mainQmlObject=value;
}

QString Firebase::getConstants()
{
    QJsonDocument myJson;
    myJson = Constants::getConstants();
    QString output=myJson.toJson(QJsonDocument::Compact);
    return output;
}

QString Firebase::getUserData()
{
    QJsonDocument myJson;
    QString output;
    myJson=userClass.getData();
    output=myJson.toJson(QJsonDocument::Compact);
    return output;
}


