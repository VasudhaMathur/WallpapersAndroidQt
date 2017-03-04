#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickStyle>

#include <src/downloadmanager.h>

int main(int argc, char *argv[])
{
    QGuiApplication::setApplicationName("Wallpapers");
    QGuiApplication::setOrganizationName("turanmahmudov");
    QGuiApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    // Create download manager object
    qmlRegisterType<DownloadManager>("DownloadManager",1,0,"DownloadManager");

    QQuickStyle::setStyle("Material");

    QQmlApplicationEngine engine;
    engine.load(QUrl("qrc:/main.qml"));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
