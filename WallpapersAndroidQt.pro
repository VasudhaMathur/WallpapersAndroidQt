TEMPLATE = app
TARGET = wallpapers_android_qt
QT += qml quick quickcontrols2

CONFIG += \
    c++11

SOURCES += \
    main.cpp

OTHER_FILES += \
    main.qml

RESOURCES += \
    qml.qrc

# Default rules for deployment.
include(deployment.pri)
