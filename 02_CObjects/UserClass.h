#ifndef USERCLASS_H
#define USERCLASS_H

#endif // USERCLASS_H

#include <QString>
#include <QJsonDocument>

class UserClass
{
public:
    QJsonDocument getData();

    QString token;
    QString id;
    QString email;
    QString name;
    QString pass;
};

inline QJsonDocument UserClass::getData()
{
    QVariantMap output;
    output["token"]=token;
    output["id"]=id;
    output["email"]=email;
    output["name"]=name;
    output["pass"]=pass;

    QJsonDocument jsonPayload=QJsonDocument::fromVariant(output);
    return jsonPayload;
}
