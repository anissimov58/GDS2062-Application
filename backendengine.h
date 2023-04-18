#ifndef BACKENDENGINE_H
#define BACKENDENGINE_H

#include <QtCharts/QXYSeries>
#include <QtCharts/QAreaSeries>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QtCore/QRandomGenerator>
#include <QtCore/QtMath>
#include <QTime>
#include <QObject>
#include <QtCharts/QAbstractSeries>
#include <QtSerialPort/QSerialPort>
#include <QSerialPortInfo>
#include <QDebug>
#include <QTimer>
#include <QVector>
#include <QSettings>

QT_BEGIN_NAMESPACE
class QQuickView;
QT_END_NAMESPACE

QT_CHARTS_USE_NAMESPACE

class BackEndEngine : public QObject
{
    Q_OBJECT
public:
    explicit BackEndEngine(QQuickView *appViewer, QObject *parent = nullptr);
    int status =-1;

    //список всех доступных команды, чтобы вызывать команды не переписывая их каждый раз а по ID
    QVector<QByteArray> command = {
        "*idn?\n",
        ":AUToset\n",
        ":acq1:mem?\n",
        ":chan1:offs?\n",
        ":chan1:scal?\n",
        ":acq2:mem?\n",
        ":chan2:offs?\n",
        ":chan2:scal?\n",
        ":chan1:offs?;:chan1:scal?;:acq1:mem?\n",
        ":chan2:offs?;:chan2:scal?;:acq2:mem?\n",
        ":chan1:offs?;:chan1:scal?;:acq1:mem?;:chan2:offs?;:chan2:scal?;:acq2:mem?\n",
        ":disp:acq?\n",
        "*lrn?\n",
        ":MEASure:SOURce 1:MEASure:FREQuency?\n",
        ":MEASure:SOURce 2;:MEASure:FREQuency?\n",
    };

Q_SIGNALS:

signals:
    //сигнал о получении статуса, вызовется когда будет успешное подключение к Осциллографу
    Q_INVOKABLE void idnReady();
    Q_INVOKABLE void deviceReady();
    Q_INVOKABLE void deviceFraud();
    Q_INVOKABLE void vmaxminfound();
    Q_INVOKABLE void erroroccured();
public slots:

    //слот получения указателей на графики из QML, чтобы мы знали куда данные отправлять
    void getSeriesFromQML(QAbstractSeries *series1,
                          QAbstractSeries *series2,
                          QAbstractSeries *series3,
                          QAbstractSeries *series4,
                          QAbstractSeries *series5,
                          QAbstractSeries *series6
                          );

    //слоты преобразования сырых данных в кошегхные вектогха
    void getDataChannel1(QByteArray);
    void getDataChannel2(QByteArray);

    //слот настройки  порта
    void setUp(QString _name);

    //статус текущего подключения
    //1 - либо ошибка либо еще не подключался
    //0 - подключение успешно
    int getStatus();

    //слот получения строки состояния
    QString getIDN();

    //слот обработки сигнала readyread от порта
    void handleReadyRead();

    //слот посылания команды на порт по ID
    void sendCommand(int _id);

    //собрать информацию о всех портах которые есть на компьютере для их отображения
    void getComData();

    //тестовая заглушка
    void recallPortData();

    //Набор методов передачи значений во время заполнения списка портов в QML
    QString getPortName(int i);
    QString getPortLocation(int i);
    QString getPortdescription(int i);
    QString getPortManufacturer(int i);
    QString getPortSerialNumber(int i);
    QString getPortVendorID(int i);
    QString getPortProductID(int i);
    QString getPortBusy(int i);
    int getPortsNumber();

    //для загрузки и выгрузки из файла конфигурации
    int loadSettings();
    void saveSettings();

    void changePort(int i);

    void closePort();

    void parseLRN(QByteArray);

    QString getMax1();
    QString getMin1();
    QString getVpp1();
    QString getFreq1();
    QString getPer1();

    QString getMax2();
    QString getMin2();
    QString getVpp2();
    QString getFreq2();
    QString getPer2();

    QString getT1();
    QString getT2();
    QString getTdelta();
    QString getTfreq();

    QString getV1();
    QString getV2();
    QString getVdelta();

    QString getScaleChannel1();
    QString getScaleChannel2();

    QString getTimeScale();

    QString getErrorString();

    void SetCursors();

private slots:
    void handleError(QSerialPort::SerialPortError error);

private:
    QQuickView *m_appViewer; //окошко для отображения интерфейса

    QSerialPort *m_serial = new QSerialPort();

    //Буфферы для получения и обработки данных
    QByteArray mainbuffer="";
    QByteArray mainbufferChannel1="";
    QByteArray mainbufferChannel1Header="";
    QByteArray mainbufferChannel2="";
    QByteArray mainbufferChannel2Header="";

    //Строка состояния осциллографа
    QByteArray idn ="";

    //байты для проверки на принадлежность первому и второму каналу
    QByteArray one="1";
    QByteArray two="2";

    //для конфигурации порта
    QString m_sSettingsFile;

    QString freq1="-",
            freq2="-",
            per1="-",
            per2="-",
            vmax1="-",
            vmax2="-",
            vmin1="-",
            vmin2="-",
            vpp1="-",
            vpp2="-",
            curT1="-",
            curT2="-",
            curTdelta="-",
            curTfreq="-",
            curV1="-",
            curV2="-",
            curVdelta="-",
            scale1string = "-",
            scale2string = "-",
            timescalestring = "-",
            errorstring = "-"
    ;

    //флаги для проверки на принадлежность первому и второму каналу
    bool dataFromFirstChannel=false;
    bool dataFromSecondChannel=false;

    //список всех доступных портов
    QList<QSerialPortInfo> ports;

    //вектор точек для первого и второго канала
    QVector<QPointF> points1;
    QVector<QPointF> points2;
    QVector<QPointF> cursorX1;
    QVector<QPointF> cursorX2;
    QVector<QPointF> cursorY1;
    QVector<QPointF> cursorY2;

    //смещение для канала 1
    double offset1=0;
    //масштаб для канала 1
    double scale1=0;
    //смещение для канала 2
    double offset2=0;
    //масштаб канала 2
    double scale2=0;

    double freq=0;
    double per=0;

    double timescale=0;
    double cursorX1value=0;
    double cursorX2value=0;

    double cursorY1value=0;
    double cursorY2value=0;

    bool cursorXActive=false;
    bool cursorYActive=false;

    //ID текущей команды для того, чтобы понимать что мы обрабатываем
    int currentCommand=-1;

    //тестовые переменные для подсчета количества ошибок от полчения векторов.
    int errorcount1=0;
    int errorcount2=0;

    //указатели на графики в QML, в них будут переданы указатели на графики при завершении построения интерфейса
    QXYSeries   *xySeries1,
                *xySeries2,
                *xySeries3,
                *xySeries4,
                *xySeries5,
                *xySeries6;
};

#endif // BACKENDENGINE_H
