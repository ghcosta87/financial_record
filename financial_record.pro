QT += quick
CONFIG += c++17

# You can make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        01_CFiles/filehandler.cpp \
        01_CFiles/firebase.cpp \
        01_CFiles/firebaseFeedback.cpp \
        01_CFiles/firebaseNetwork.cpp \
        01_CFiles/toolbox.cpp \
        main.cpp

RESOURCES += qml.qrc

TRANSLATIONS += \
    financial_record_en_US.ts
CONFIG += lrelease
CONFIG += embed_translations

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target
android: include(/home/gabriel/Android/Sdk/android_openssl/openssl.pri)

DISTFILES += \
    00_Android/00_AndroidManifest.xml \
    00_Android/build.gradle \
    00_Android/gradle.properties \
    00_Android/gradle/wrapper/gradle-wrapper.jar \
    00_Android/gradle/wrapper/gradle-wrapper.properties \
    00_Android/gradlew \
    00_Android/gradlew.bat \
    00_Android/res/drawable-hdpi/icon.png \
    00_Android/res/drawable-hdpi/logo.png \
    00_Android/res/drawable-hdpi/logo_landscape.png \
    00_Android/res/drawable-hdpi/logo_portrait.png \
    00_Android/res/drawable-ldpi/icon.png \
    00_Android/res/drawable-ldpi/logo_landscape.png \
    00_Android/res/drawable-ldpi/logo_portrait.png \
    00_Android/res/drawable-mdpi/icon.png \
    00_Android/res/drawable-mdpi/logo_landscape.png \
    00_Android/res/drawable-mdpi/logo_portrait.png \
    00_Android/res/values/libs.xml

00_Android_PACKAGE_SOURCE_DIR = $$PWD/00_Android

HEADERS += \
    01_CFiles/filehandler.h \
    01_CFiles/firebase.h \
    01_CFiles/toolbox.h \
    02_CObjects/Constants.h \
    02_CObjects/QmlClass.h \
    02_CObjects/UserClass.h
