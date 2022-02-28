#ifndef CONSTANTS_H
#define CONSTANTS_H
#endif // CONSTANTS_H

#include <QJsonDocument>
#include <QStringLiteral>

class Constants
{
public:
    QJsonDocument static getConstants();

    const static int PUTREQUEST=0;
    const static int UPDATEREQUEST=1;
    const static int POSTREQUEST=2;
    const static int LOGINREQUEST=3;
    const static int GETREQUEST=4;
    const static int DELETEREQUEST=6;

    const static int NOTAUTHENTICATED=0;
    const static int AUTHENTICATED=1;
    const static int ANSWERERROR=2;
    const static int INCOMPLETEMSG=2;

    static const inline QString googleKey="\"code\": 400";
    static const inline QString emailError="\"message\": \"EMAIL_NOT_FOUND\"";
    static const inline QString passError="\"message\": \"INVALID_PASSWORD\"";

    static const inline QString keyMissing="\"code\": 403";
};

inline QJsonDocument Constants::getConstants()
{
    QVariantMap output;
    output["PUTREQUEST"]=PUTREQUEST;
    output["UPDATEREQUEST"]=UPDATEREQUEST;
    output["POSTREQUEST"]=POSTREQUEST;
    output["LOGINREQUEST"]=LOGINREQUEST;
    output["GETREQUEST"]=GETREQUEST;
    output["DELETEREQUEST"]=DELETEREQUEST;

    output["NOTAUTHENTICATED"]=NOTAUTHENTICATED;
    output["AUTHENTICATED"]=AUTHENTICATED;
    output["ANSWERERROR"]=ANSWERERROR;
    output["INCOMPLETEMSG"]=INCOMPLETEMSG;

    QJsonDocument jsonPayload=QJsonDocument::fromVariant(output);
    return jsonPayload;
}
