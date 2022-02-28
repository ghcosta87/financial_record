#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QTranslator>
#include <QQmlContext>
#include <QSslSocket>
#include <QLocale>
#include <QDir>

#include <01_CFiles/filehandler.h>
#include <01_CFiles/firebase.h>

int main(int argc, char *argv[])
{
    //#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    //    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    //#endif
    QGuiApplication app(argc, argv);

    //    QTranslator translator;
    //    const QStringList uiLanguages = QLocale::system().uiLanguages();
    //    for (const QString &locale : uiLanguages) {
    //        const QString baseName = "financial_record_" + QLocale(locale).name();
    //        if (translator.load(":/i18n/" + baseName)) {
    //            app.installTranslator(&translator);
    //            break;
    //        }
    //    }

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    FileHandler myLog;

    QString productName=QSysInfo::prettyProductName();
    QStringList productNameCheck=productName.split(" ");
    QString customPath;

    if(productNameCheck.size()>1){
        if(productNameCheck[0]=="Linux"){customPath = "/home/gabriel/Documentos/financas_localstorage"; }
        else if(productNameCheck[0]=="Android"){
            customPath = "/storage/emulated/0/financas_localstorage";
        }else{
            customPath="unknow";
        }
    }
    QDir dir;
    if(customPath!="unknow"){
        if(dir.mkpath(QString(customPath))){
            engine.setOfflineStoragePath(QString(customPath));
        }
    }

    myLog.setDataStoragePath(QString(customPath));

    myLog.logRecorder("\n",true);
    myLog.logRecorder("██████╗░███████╗░██████╗░██╗███╗░░██╗██╗███╗░░██╗░██████╗░",true);
    myLog.logRecorder("██╔══██╗██╔════╝██╔════╝░██║████╗░██║██║████╗░██║██╔════╝░",true);
    myLog.logRecorder("██████╦╝█████╗░░██║░░██╗░██║██╔██╗██║██║██╔██╗██║██║░░██╗░",true);
    myLog.logRecorder("██╔══██╗██╔══╝░░██║░░╚██╗██║██║╚████║██║██║╚████║██║░░╚██╗",true);
    myLog.logRecorder("██████╦╝███████╗╚██████╔╝██║██║░╚███║██║██║░╚███║╚██████╔╝",true);
    myLog.logRecorder("╚═════╝░╚══════╝░╚═════╝░╚═╝╚═╝░░╚══╝╚═╝╚═╝░░╚══╝░╚═════╝░",true);
    myLog.logRecorder(" ",true);


    myLog.logRecorder("\nmain(){",true);
    if(QSslSocket::supportsSsl())myLog.logRecorder("\tSSL Support ENABLE",true);
    else myLog.logRecorder("\tSSL Support DISABLE",true);
    myLog.logRecorder("\t"+QSslSocket::sslLibraryBuildVersionString(),true);
    myLog.logRecorder("\t"+QSslSocket::sslLibraryVersionString(),true);
    myLog.logRecorder("\tDatabase path is "+customPath,true);
    myLog.logRecorder("\tRunning the application now",true);
    myLog.logRecorder("\tend of main()\n}",true);

    Firebase firebase;

    engine.rootContext()->setContextProperty("fileHandler",new FileHandler);
    engine.rootContext()->setContextProperty("firebase",new Firebase);
    engine.rootContext()->setContextProperty("storagePath",QString(customPath));
//    engine.rootContext()->setContextProperty("constants",QVariant::fromValue(firebase.getConstants()));

    engine.load(url);

    return app.exec();
}

