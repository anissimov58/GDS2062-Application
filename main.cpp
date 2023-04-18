#include <QApplication>

#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QDebug>
#include <QQmlContext>

#include <QtQml/QQmlContext>
#include <QtQuick/QQuickView>
#include <QtCore/QDir>
#include "backendengine.h"
#include "backendengine.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);   //Должно использоваться именно QApplication тк приложение использует Qt Graphics View Framework для отрисовки графиков

    QQuickView viewer; //то, где будет отрисовываться интерфейс

    //нужно для того, чтобы приложение работало без неоходимости устанавливать модули в среде запуска
#ifdef Q_OS_WIN
    QString extraImportPath(QStringLiteral("%1/../../../../%2"));
#else
    QString extraImportPath(QStringLiteral("%1/../../../%2"));
#endif

    //добавить все qml файлы которые лежат в одной папке с приложением в движок приложения
    viewer.engine()->addImportPath(extraImportPath.arg(QGuiApplication::applicationDirPath(),QString::fromLatin1("qml")));

    //соединяем сигнал закрытия окна QML с закрытием окна отрисовки приложения
    QObject::connect(viewer.engine(),&QQmlEngine::quit, &viewer,&QWindow::close);

    //титры прокрасивше
    viewer.setTitle(QStringLiteral("GDS by Anisimov"));

    BackEndEngine bee(&viewer); //в качестве параметров передаем окошко, в котором будет отрисовываться интерфейс

    //добавляем "Свойство" в QML чтобы можно было общаться
    viewer.rootContext()->setContextProperty("bee",&bee);

    //добавляем ЧТО именно отрисовывать
    viewer.setSource(QUrl("qrc:/main.qml"));

    //масштабирование по корневому элементу
    viewer.setResizeMode(QQuickView::SizeRootObjectToView);

    viewer.setMinimumHeight(240);
    viewer.setMinimumWidth(320);

    //отобразить окошко
    viewer.show();

    return app.exec();
}
