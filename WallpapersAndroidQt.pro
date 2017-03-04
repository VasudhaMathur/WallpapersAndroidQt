TEMPLATE = app
TARGET = wallpapers_android_qt
QT += qml quick quickcontrols2 svg androidextras
QTPLUGIN += qsvg

android: {
    QT += androidextras
    ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
}

CONFIG += \
    c++11

SOURCES += \
    main.cpp \
    src/downloadmanager.cpp

OTHER_FILES += \
    main.qml

RESOURCES += \
    qml.qrc

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    src/downloadmanager.h

DISTFILES += \
    android/AndroidManifest.xml \
    android/gradle/wrapper/gradle-wrapper.jar \
    android/gradlew \
    android/res/values/libs.xml \
    android/build.gradle \
    android/gradle/wrapper/gradle-wrapper.properties \
    android/gradlew.bat \
    android/gradle/wrapper/gradle-wrapper.properties~ \
    android/res/drawable-hdpi/icon.png \
    android/res/drawable-ldpi/icon.png \
    android/res/drawable-mdpi/icon.png \
    android/src/turanmahmudov/wallpapers/WallpapersInJava.java \
    android/gradle.properties \
    android/local.properties

ANDROID_PACKAGE_SOURCE_DIR = $$PWD/android
