#ifndef FIREBASECLASS_H
#define FIREBASECLASS_H

#endif // FIREBASECLASS_H

#ifndef USERCLASS_H
#define USERCLASS_H

#endif // USERCLASS_H

#include <QString>
#include <QJsonDocument>

class FirebaseClass
{
public:
    QJsonDocument getData();
    QString dataValidation();

    QString stringToSend;
    QString path;
    int restType;
};

inline QJsonDocument FirebaseClass::getData()
{
    QVariantMap output;
    output["stringToSend"]=stringToSend;
    output["path"]=path;
    output["restType"]=restType;

    QJsonDocument jsonPayload=QJsonDocument::fromVariant(output);
    return jsonPayload;
}
