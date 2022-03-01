#ifndef USERCLASS_H
#define USERCLASS_H

#endif // USERCLASS_H

#include <QString>
#include <QJsonDocument>

class UserClass
{
public:
    QJsonDocument getData();

    QString name;
    QString email;
    QString token;
    QString id;
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
