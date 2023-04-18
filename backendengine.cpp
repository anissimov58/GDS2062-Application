#include "backendengine.h"
#include <QtCharts/QXYSeries>
#include <QtCharts/QAreaSeries>
#include <QtQuick/QQuickView>
#include <QtQuick/QQuickItem>
#include <QtCore/QDebug>
#include <QtCore/QRandomGenerator>
#include <QtCore/QtMath>
#include <QTime>
#include <QApplication>
#include <QLabel>
#include <QMessageBox>

#define K 25.0

QT_CHARTS_USE_NAMESPACE

Q_DECLARE_METATYPE(QAbstractSeries *)
Q_DECLARE_METATYPE(QAbstractAxis *)

BackEndEngine::BackEndEngine(QQuickView *appViewer, QObject *parent):
    QObject (parent),
    m_appViewer(appViewer)
{
    qRegisterMetaType<QAbstractAxis*>();
    qRegisterMetaType<QAbstractSeries*>();

    QObject::connect(m_serial,&QSerialPort::readyRead,this,&BackEndEngine::handleReadyRead);
    connect(m_serial,&QSerialPort::errorOccurred,this,&BackEndEngine::handleError);
//    connect(m_serial, &QSerialPort::errorOccurred, this, &MainWindow::handleError);
    for(int i=0;i<500;i++){
        points1.append(QPointF(0.0,0.0));
        points2.append(QPointF(0.0,0.0));
    }
    cursorX1.append(QPointF(0.0,0.0));
    cursorX1.append(QPointF(0.0,0.0));

    cursorX2.append(QPointF(0.0,0.0));
    cursorX2.append(QPointF(0.0,0.0));

    cursorY1.append(QPointF(0.0,0.0));
    cursorY1.append(QPointF(0.0,0.0));

    cursorY2.append(QPointF(0.0,0.0));
    cursorY2.append(QPointF(0.0,0.0));

    m_sSettingsFile = QApplication::applicationDirPath()+"/config.ini";
    qDebug()<<"m_sSettingsFile"<<m_sSettingsFile;
}

void BackEndEngine::handleError(QSerialPort::SerialPortError error)
{
    if (error == QSerialPort::ResourceError) {
        errorstring = m_serial->errorString();
        emit erroroccured();
//        QMessageBox::critical(this, tr("Critical Error"), m_serial->errorString());
        closePort();
    }
}

void BackEndEngine::getSeriesFromQML(QAbstractSeries *series1,
                                     QAbstractSeries *series2,
                                     QAbstractSeries *series3,
                                     QAbstractSeries *series4,
                                     QAbstractSeries *series5,
                                     QAbstractSeries *series6
                                     )
{
    if(series1)
        xySeries1 = static_cast<QXYSeries *>(series1);
    if(series2)
        xySeries2 = static_cast<QXYSeries *>(series2);
    if(series3)
        xySeries3 = static_cast<QXYSeries *>(series3);
    if(series4)
        xySeries4 = static_cast<QXYSeries *>(series4);
    if(series5)
        xySeries5 = static_cast<QXYSeries *>(series5);
    if(series6)
        xySeries6 = static_cast<QXYSeries *>(series6);
}

void BackEndEngine::SetCursors()
{
    if(cursorXActive){
        cursorX1[0].rx()=250+cursorX1value/(timescale/25);
        cursorX1[0].ry()=-5;
        cursorX1[1].rx()=250+cursorX1value/(timescale/25);
        cursorX1[1].ry()=5;

        cursorX2[0].rx()=250+cursorX2value/(timescale/25);
        cursorX2[0].ry()=-5;
        cursorX2[1].rx()=250+cursorX2value/(timescale/25);
        cursorX2[1].ry()=5;
    }
    else {
        cursorX1[0].rx()=0;
        cursorX1[0].ry()=-5;
        cursorX1[1].rx()=0;
        cursorX1[1].ry()=5;
        xySeries3->replace(cursorX1);

        cursorX2[0].rx()=0;
        cursorX2[0].ry()=-5;
        cursorX2[1].rx()=0;
        cursorX2[1].ry()=5;
    }
    xySeries3->replace(cursorX1);
    xySeries4->replace(cursorX2);

    if(cursorYActive){
        cursorY1[0].rx()=100;
        cursorY1[0].ry()=cursorY1value;
        cursorY1[1].rx()=400;
        cursorY1[1].ry()=cursorY1value;

        cursorY2[0].rx()=100;
        cursorY2[0].ry()=cursorY2value;
        cursorY2[1].rx()=400;
        cursorY2[1].ry()=cursorY2value;
    }
    else{
        cursorY1[0].rx()=1;
        cursorY1[0].ry()=cursorY1value;
        cursorY1[1].rx()=2;
        cursorY1[1].ry()=cursorY1value;

        cursorY2[0].rx()=1;
        cursorY2[0].ry()=cursorY2value;
        cursorY2[1].rx()=2;
        cursorY2[1].ry()=cursorY2value;
    }

    xySeries5->replace(cursorY1);
    xySeries6->replace(cursorY2);
}

void BackEndEngine::getDataChannel1(QByteArray _mainbufferChannel1)
{
//    qDebug()<<"1"<<_mainbufferChannel1;
    for (int i=4; i<_mainbufferChannel1.size();i+=4+1){ _mainbufferChannel1.insert(i," "); }
    QByteArrayList list = _mainbufferChannel1.split(' ');
    QString temp = "";
    bool valid;
    double vmaxbuff=-10000,vminbuff=10000,vpp=0;
    for (int i=0;i<500;i++){

        temp[0] = list[i][2];
        temp[1] = list[i][3];
        temp[2] = list[i][0];
        temp[3] = list[i][1];

        union data2{
            char a[2];
            signed int abc;
        } myData3;

        myData3.abc = 0;
        myData3.a[0] = temp.left(2).toInt(&valid,16);
        myData3.a[1] = temp.right(2).toInt(&valid,16);

        if (myData3.abc > (65535/2)){
            points1[i].rx()=i;
            points1[i].ry()= static_cast<double>((myData3.abc-65535)/K)+static_cast<double>(offset1/scale1);
        } else {
            points1[i].rx()=i;
            points1[i].ry()= static_cast<double>((myData3.abc)/K)+static_cast<double>(offset1/scale1);
        }
        //Ищем максимум и минимум
#ifdef Q_OS_LINUX
        if (i==50){
            vmaxbuff=points1[50].ry();
            vminbuff=points1[50].ry();
        }
        if( i>50 && i<400){
            if (points1[i].ry()>vmaxbuff) vmaxbuff=points1[i].ry();
            if (points1[i].ry()<vminbuff) vminbuff=points1[i].ry();
        }
#endif
#ifdef Q_OS_WIN
        if (i==0){
            vmaxbuff=points1[0].ry();
            vminbuff=points1[0].ry();
        }
        if (points1[i].ry()>vmaxbuff) vmaxbuff=points1[i].ry();
        if (points1[i].ry()<vminbuff) vminbuff=points1[i].ry();
#endif
    }

    //Записать в буфер
    vmax1.clear();
    vmin1.clear();
    if (abs(vmaxbuff*scale1-offset1)<1){
        vmax1.setNum(1000.0*(vmaxbuff*scale1-offset1),'g',4);
        vmax1.append(" мВ");
    }
    else {
        vmax1.setNum(vmaxbuff*scale1-offset1,'g',4);
        vmax1.append(" В");
    }

    if (abs(vminbuff*scale1-offset1)<1){
        vmin1.setNum(1000.0*(vminbuff*scale1-offset1),'g',4);
        vmin1.append(" мВ");
    }
    else {
        vmin1.setNum(vminbuff*scale1-offset1,'g',4);
        vmin1.append(" В");
    }
    vpp = (vmaxbuff*scale1-offset1)-(vminbuff*scale1-offset1);
    if (abs(vpp)<1){
        vpp1.setNum(vpp*1000.0,'g',4);
        vpp1.append(" мВ");
    }
    else {
        vpp1.setNum(vpp,'g',4);
        vpp1.append(" В");
    }
    xySeries1->replace(points1);
    sendCommand(13);
}

void BackEndEngine::getDataChannel2(QByteArray _mainbufferChannel2)
{
    for (int i=4; i<_mainbufferChannel2.size();i+=4+1){ _mainbufferChannel2.insert(i," "); }
    QByteArrayList list = _mainbufferChannel2.split(' ');
    QString temp = "";
    bool valid;
    double vmaxbuff=-10000,vminbuff=10000,vpp=0;
    for (int i=0;i<500;i++){

        temp[0] = list[i][2];
        temp[1] = list[i][3];
        temp[2] = list[i][0];
        temp[3] = list[i][1];

        union data2{
            char a[2];
            signed int abc;
        } myData3;

        myData3.abc = 0;
        myData3.a[0] = temp.left(2).toInt(&valid,16);
        myData3.a[1] = temp.right(2).toInt(&valid,16);

        if (myData3.abc > (65535/2)){
            points2[i].rx()=i;
            points2[i].ry()= static_cast<double>((myData3.abc-65535)/K)+static_cast<double>(offset2/scale2);
        } else {
            points2[i].rx()=i;
            points2[i].ry()= static_cast<double>((myData3.abc)/K)+static_cast<double>(offset2/scale2);
        }

        //Ищем максимум и минимум
#ifdef Q_OS_LINUX
        if (i==50){
            vmaxbuff=points2[50].ry();
            vminbuff=points2[50].ry();
        }
        if( i>50 && i<400){
            if (points2[i].ry()>vmaxbuff) vmaxbuff=points2[i].ry();
            if (points2[i].ry()<vminbuff) vminbuff=points2[i].ry();
        }
#endif
#ifdef Q_OS_WIN
        if (i==0){
            vmaxbuff=points2[0].ry();
            vminbuff=points2[0].ry();
        }
        if (points2[i].ry()>vmaxbuff) vmaxbuff=points2[i].ry();
        if (points2[i].ry()<vminbuff) vminbuff=points2[i].ry();
#endif
    }

    //Записать в буфер
    vmax2.clear();
    vmin2.clear();
    if (abs(vmaxbuff*scale2-offset2)<1){
        vmax2.setNum(1000.0*(vmaxbuff*scale2-offset2),'g',4);
        vmax2.append(" мВ");
    }
    else {
        vmax2.setNum(vmaxbuff*scale2-offset2,'g',4);
        vmax2.append(" В");
    }

    if (abs(vminbuff*scale2-offset2)<1){
        vmin2.setNum(1000.0*(vminbuff*scale2-offset2),'g',4);
        vmin2.append(" мВ");
    }
    else {
        vmin2.setNum(vminbuff*scale2-offset2,'g',4);
        vmin2.append(" В");
    }
    vpp = (vmaxbuff*scale2-offset2)-(vminbuff*scale2-offset2);
    if (abs(vpp)<1){
        vpp2.setNum(vpp*1000.0,'g',4);
        vpp2.append(" мВ");
    }
    else {
        vpp2.setNum(vpp,'g',4);
        vpp2.append(" В");
    }
    xySeries2->replace(points2);
}

void BackEndEngine::setUp(QString _name)
{
    const auto serialPortInfos = QSerialPortInfo::availablePorts();
    for (const QSerialPortInfo &serialPortInfo : serialPortInfos) {
        if (serialPortInfo.portName()== _name){
            qDebug()<<serialPortInfo.description();
            qDebug()<<serialPortInfo.manufacturer();
            qDebug()<<serialPortInfo.serialNumber();
            m_serial->setPortName(serialPortInfo.portName());
            qDebug()<<m_serial->open(QIODevice::ReadWrite);
            qDebug()<<m_serial->setBaudRate(QSerialPort::Baud115200);
            qDebug()<<m_serial->setDataBits(QSerialPort::Data5);
            qDebug()<<m_serial->setParity(QSerialPort::NoParity);
            qDebug()<<m_serial->setStopBits(QSerialPort::OneStop);
            qDebug()<<m_serial->setFlowControl(QSerialPort::NoFlowControl);
            qDebug()<<serialPortInfo.portName();
            sendCommand(0);
        }
        else {
            status = 1;
            emit deviceFraud();
        }
    }
    m_serial->flush();
    m_serial->clear();
}

int BackEndEngine::getStatus()
{
    return status;
}

QString BackEndEngine::getIDN()
{
    idn.chop(1);
    return idn;
}

void BackEndEngine::handleReadyRead()
{
    switch (currentCommand) {
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//        "*idn?\n",
    case 0:
        idn.clear();
        idn= m_serial->readAll();
        qDebug()<<idn;
        if (idn.left(12) == "GW,GDS-2062,"  ){
             status = 0;
             emit idnReady();
             emit deviceReady();
        }
        else {
            emit deviceFraud();
        }
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//        ":AUToset\n",
    case 1:
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//        ":acq1:mem?\n",
    case 2:
//        mainbuffer.clear();//очищаем буфер
        mainbufferChannel1.clear();//очищаем буфер
        mainbufferChannel1.append(m_serial->readAll());//читаем все что есть у порта в буффер первого канала
        mainbufferChannel1 = mainbufferChannel1.toHex();//указываем что данные были в формате HEXadecimal

#ifdef Q_OS_WIN
        qDebug()<<"Windows";
        if((mainbufferChannel1.length()<2028)){
            mainbufferChannel1.append(m_serial->readAll());
            mainbufferChannel1 = mainbufferChannel1.toHex();
            qDebug()<<mainbufferChannel1;
        }
        else {
            mainbufferChannel1.clear();
        }
        if (mainbufferChannel1.length()==2028) {
            mainbufferChannel1Header = mainbufferChannel1.left(28);
            mainbufferChannel1=mainbufferChannel1.right(2000);//Оставить только часть с данными, это 2000 байт последних байт
            getDataChannel1(mainbufferChannel1); //преобразовать кошерный буффер в кошерный вектор и сразу же изменит график replace()
        }

        //если длина 28 байт и стоит метка первого канала то это ЗАГОЛОВОК первого канала, жрем его, и ставим флаг о том что следующая посылка будет данные первого канала
        if((mainbufferChannel1.length()==28) &&(mainbufferChannel1.at(21)==one.at(0)))
        {
            mainbufferChannel1Header = mainbufferChannel1; //
            dataFromFirstChannel = true; //ставим метку полчения заголовка от первого канала
        }

        //иначе если длина 2000 байт и стоит метка первого канала, то есть предыдущая посылка была заголовок первого канала
        else if (mainbufferChannel1.length()==2000 && dataFromFirstChannel) {
            getDataChannel1(mainbufferChannel1); //преобразовать кошерный буффер в кошерный вектор и сразу же изменит график replace()
            dataFromFirstChannel=false; //снять метку первого канала
        }

        //иначе если разделения данных не произошло, и получили Заголовок и данные вместе, то их длина будет 2028, а метки все равно остаюстся.
        else if ((mainbufferChannel1.length()==2028) &&(mainbufferChannel1.at(21)==one.at(0))) {
            mainbufferChannel1Header = mainbufferChannel1.left(28);
            mainbufferChannel1=mainbufferChannel1.right(2000);//Оставить только часть с данными, это 2000 байт последних байт
            getDataChannel1(mainbufferChannel1); //преобразовать кошерный буффер в кошерный вектор и сразу же изменит график replace()
            dataFromFirstChannel=false;
        }
        else {
            errorcount1++;
            dataFromFirstChannel=false;
        }
#else
//        qDebug()<<"Linux";
//        qDebug()<<"mainChannel1"<<mainbufferChannel1;

        if(mainbufferChannel1.left(4)=="2334"){
            mainbuffer.clear();
            mainbuffer = mainbufferChannel1;
        }
        else {
            mainbuffer.append(mainbufferChannel1);
        }
        if(mainbuffer.length()==2028){
            mainbufferChannel1Header = mainbuffer.left(28);
            mainbufferChannel1=mainbuffer.right(2000);//Оставить только часть с данными, это 2000 байт последних байт
            getDataChannel1(mainbuffer); //преобразовать кошерный буффер в кошерный вектор и сразу же изменит график replace()
            dataFromFirstChannel=false;
            mainbufferChannel1.clear();
            mainbuffer.clear();
        }
        if(mainbuffer.length()>2028)
        {
            mainbuffer.clear();
            mainbufferChannel1.clear();
        }
//        qDebug()<<"main"<<mainbuffer;
#endif

        break;

//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 3: //        ":chan1:offs?\n",
        mainbufferChannel1.clear();
        mainbufferChannel1.append(m_serial->readAll());
        if((mainbufferChannel1.length()>9) and (mainbufferChannel1.length()<12))
            offset1 = mainbufferChannel1.toDouble();
//        qDebug()<<"offset1"<<offset1;
        sendCommand(4); //        ":chan1:scal?\n"
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 4://        ":chan1:scal?\n"
        mainbufferChannel1.clear();
        mainbufferChannel1.append(m_serial->readAll());
        if((mainbufferChannel1.length()>9) and (mainbufferChannel1.length()<12))
            scale1 = mainbufferChannel1.toDouble();
        if(scale1>=1){
            scale1string.setNum(scale1);
            scale1string.append(" В");
        }
        else {
            scale1string.setNum(scale1*1000);
            scale1string.append(" мВ");
        }
        mainbufferChannel1.clear();
        mainbuffer.clear();
        sendCommand(2);//        ":acq1:mem?\n",
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 5://        ":acq2:mem?\n"

        mainbufferChannel2.clear();
        mainbufferChannel2.append(m_serial->readAll());
        mainbufferChannel2 = mainbufferChannel2.toHex();
#ifdef Q_OS_WIN
        if((mainbufferChannel2.length()==28) &&(mainbufferChannel2.at(21)==two.at(0)))
        {
            mainbufferChannel2Header = mainbufferChannel2;
            dataFromSecondChannel = true;
        }
        else if (mainbufferChannel2.length()==2000 && dataFromSecondChannel) {
            getDataChannel2(mainbufferChannel2);
            dataFromSecondChannel=false;
        }
        else if ((mainbufferChannel2.length()==2028) &&(mainbufferChannel2.at(21)==two.at(0))) {
            mainbufferChannel2=mainbufferChannel2.right(2000);
            getDataChannel2(mainbufferChannel2);
            dataFromSecondChannel=false;
        }
        else {
            errorcount2++;
            dataFromSecondChannel=false;
        }
        emit vmaxminfound();
#else
//        qDebug()<<"Linux";
//        qDebug()<<"mainChannel2"<<mainbufferChannel2;

        if(mainbufferChannel2.left(4)=="2334"){
            mainbuffer.clear();
            mainbuffer = mainbufferChannel2;
        }
        else {
            mainbuffer.append(mainbufferChannel2);
        }
        if(mainbuffer.length()==2028){
            mainbufferChannel2Header = mainbuffer.left(28);
            mainbufferChannel2=mainbuffer.right(2000);//Оставить только часть с данными, это 2000 байт последних байт
            getDataChannel2(mainbuffer); //преобразовать кошерный буффер в кошерный вектор и сразу же изменит график replace()
            dataFromSecondChannel=false;
            mainbufferChannel2.clear();
            mainbuffer.clear();
        }
        if(mainbuffer.length()>2028)
        {
            mainbuffer.clear();
            mainbufferChannel2.clear();
        }
        emit vmaxminfound();
//        qDebug()<<"main"<<mainbuffer;
#endif
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 6://        ":chan2:offs?\n",

        mainbufferChannel2.clear();
        mainbufferChannel2.append(m_serial->readAll());
        if((mainbufferChannel2.length()>9) and (mainbufferChannel2.length()<12))
            offset2 = mainbufferChannel2.toDouble();
        sendCommand(7); //        ":chan2:scal?\n"
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 7://        ":chan2:scal?\n"

        mainbufferChannel2.clear();
        mainbufferChannel2.append(m_serial->readAll());
        if((mainbufferChannel2.length()>9) and (mainbufferChannel2.length()<12))
            scale2 = mainbufferChannel2.toDouble();
        if(scale2>=1){
            scale2string.setNum(scale2);
            scale2string.append(" В");
        }
        else {
            scale2string.setNum(scale2*1000);
            scale2string.append(" мВ");
        }
        mainbuffer.clear();
        mainbufferChannel2.clear();
        sendCommand(5); //        ":acq2:mem?\n"
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 8://       ":chan1:offs?;:chan1:scal?;:acq1:mem?\n",

        mainbuffer.clear();
        mainbuffer.append(m_serial->readAll());
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 9://       ":chan2:offs?;:chan2:scal?;:acq2:mem?\n",

        mainbuffer.clear();
        mainbuffer.append(m_serial->readAll());
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 10://      ":chan1:offs?;:chan1:scal?;:acq1:mem?:chan2:offs?;:chan2:scal?;:acq2:mem?\n"

        mainbuffer.clear();
        mainbuffer.append(m_serial->readAll());
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 11://      ":disp:acq?\n"

        mainbuffer.clear();
        mainbuffer.append(m_serial->readAll());
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 12://      "*lrn?\n"
        mainbuffer.append(m_serial->readAll());
        if((mainbuffer.left(12)==":SYSTem:TIMe") &&(mainbuffer.count(";")==110)){
            parseLRN(mainbuffer);
            mainbuffer.clear();
            sendCommand(3);
        }
        if((mainbuffer.count(";")>=110)||(mainbuffer.left(12)!=":SYSTem:TIMe")){
            mainbuffer.clear();
        }
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   case 13:
        mainbufferChannel1.clear();
        mainbufferChannel1.append(m_serial->readAll());
        if((mainbufferChannel1.length()>1) and (mainbufferChannel1.length()<20)){
            freq = mainbufferChannel1.toDouble();
            per = 1.0/freq;
            if (freq<=1000.0){
                freq1.setNum(freq,10,3);
                freq1.append(" Гц");
                per1.setNum(per*1000.0,10,3);
                per1.append(" мс");
            }
            else{
            if ((1000.0<freq)&&(freq<1000000.0)){
                freq1.setNum(freq/1000.0,10,3);
                freq1.append(" кГц");
                per1.setNum(per*1000000.0,10,3);
                per1.append(" мкс");
            }
            else{
            if (1000000.0<=freq){
                freq1.setNum(freq/1000000.0,10,3);
                freq1.append(" МГц");
                per1.setNum(per*1000000000.0,10,3);
                per1.append(" нс");
            }
            }
            }
        }
        else{
            freq1="-";
            per1="-";
        }
        sendCommand(14);
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    case 14:
        mainbufferChannel2.clear();
        mainbufferChannel2.append(m_serial->readAll());
        if((mainbufferChannel2.length()>1) and (mainbufferChannel2.length()<20)){
            freq = mainbufferChannel2.toDouble();
            per = 1.0/freq;
            if (freq<=1000.0){
                freq2.setNum(freq,10,3);
                freq2.append(" Гц");
                per2.setNum(per*1000.0,10,3);
                per2.append(" мс");
            }
            else{
            if ((1000.0<freq)&&(freq<1000000.0)){
                freq2.setNum(freq/1000.0,10,3);
                freq2.append(" кГц");
                per2.setNum(per*1000000.0,10,3);
                per2.append(" мкс");
            }
            else{
            if (1000000.0<=freq){
                freq2.setNum(freq/1000000.0,10,3);
                freq2.append(" МГц");
                per2.setNum(per*1000000000.0,10,3);
                per2.append(" нс");
            }
            }
            }
        }
        else{
            freq2="-";
            per2="-";
        }
        sendCommand(6);
        break;
//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    default:
        qDebug()<<"Unknown Command Error";
        break;
    }
}

void BackEndEngine::sendCommand(int _id)
{
    currentCommand = _id;
    qDebug()<<"Command"<<command[_id];
    m_serial->write(command[_id]);
}

void BackEndEngine::getComData()
{
    ports = QSerialPortInfo::availablePorts();
    for (const QSerialPortInfo &serialPortInfo : ports) {
        qDebug()<<serialPortInfo.description();
        qDebug()<<serialPortInfo.manufacturer();
        qDebug()<<serialPortInfo.serialNumber();
        qDebug()<<endl
            << "Port: " << serialPortInfo.portName() << endl
            << "Location: " << serialPortInfo.systemLocation() << endl
            << "Description: " << serialPortInfo.description() << endl
            << "Manufacturer: " << serialPortInfo.manufacturer()<< endl
            << "Serial number: " << serialPortInfo.serialNumber()<< endl
            << "Vendor Identifier: " << serialPortInfo.hasVendorIdentifier()<< endl
            << "Product Identifier: " << serialPortInfo.hasProductIdentifier() << endl
            << "Busy: " << (serialPortInfo.isBusy() ? "Yes" : "No") << endl;
    }
}

void BackEndEngine::recallPortData()
{
    qDebug()<<"Total number of ports available: " << ports.count() << endl;
    for (const QSerialPortInfo &serialPortInfo : ports) {
        qDebug()<<serialPortInfo.description();
        qDebug()<<serialPortInfo.manufacturer();
        qDebug()<<serialPortInfo.serialNumber();
        qDebug()<<endl
            << "Port: " << serialPortInfo.portName() << endl
            << "Location: " << serialPortInfo.systemLocation() << endl
            << "Description: " << serialPortInfo.description() << endl
            << "Manufacturer: " << serialPortInfo.manufacturer()<< endl
            << "Serial number: " << serialPortInfo.serialNumber()<< endl
            << "Vendor Identifier: " << QByteArray::number(serialPortInfo.vendorIdentifier(), 16)<< endl
            << "Product Identifier: " << QByteArray::number(serialPortInfo.productIdentifier(), 16) << endl
            << "Busy: " << (serialPortInfo.isBusy() ? "Yes" : "No") << endl;
    }
}

QString BackEndEngine::getPortName(int i){
    return ports[i].portName();
}

QString BackEndEngine::getPortLocation(int i){
    return ports[i].systemLocation();
}

QString BackEndEngine::getPortdescription(int i){
    return (!ports[i].description().isEmpty() ? ports[i].description() : "-");
}

QString BackEndEngine::getPortManufacturer(int i){
    return (!ports[i].manufacturer().isEmpty() ? ports[i].manufacturer() : "-");
}

QString BackEndEngine::getPortSerialNumber(int i){
    return (!ports[i].serialNumber().isEmpty() ? ports[i].serialNumber() : "-");
}

QString BackEndEngine::getPortVendorID(int i){
    if(!ports[i].vendorIdentifier()){
        return "-";
    }
    else {
        return QByteArray::number(ports[i].vendorIdentifier(), 16);
    }
}

QString BackEndEngine::getPortProductID(int i){
    if(!ports[i].vendorIdentifier()){
        return "-";
    }
    else {
        return QByteArray::number(ports[i].productIdentifier(), 16);
    }
}

QString BackEndEngine::getPortBusy(int i){
    if(ports[i].isBusy()==true)
        return "Занят";
    else {
        return "Не занят";
    }
}

int BackEndEngine::getPortsNumber(){
    return ports.count();
}

int BackEndEngine::loadSettings()
{
    QSettings settings(m_sSettingsFile,QSettings::IniFormat);
    QString text2= settings.value("port","").toString();
    setUp(text2);
    return status;

}

void BackEndEngine::saveSettings()
{

}

void BackEndEngine::changePort(int i)
{
    setUp(ports[i].portName());
    QSettings settings(m_sSettingsFile,QSettings::IniFormat);
    settings.setValue("port",ports[i].portName());
}

void BackEndEngine::closePort(){
    if (m_serial->isOpen())
        m_serial->close();
}

void BackEndEngine::parseLRN(QByteArray LRNbuffer)
{
    QByteArrayList LRNbufferSplit,LRNbufferSplitSplit;
    QByteArray ba;


    LRNbufferSplit = LRNbuffer.split(';');

    LRNbufferSplitSplit=LRNbufferSplit[44].split(' ');
    scale1 = LRNbufferSplitSplit[1].toDouble();

    LRNbufferSplitSplit=LRNbufferSplit[52].split(' ');
    scale2 = LRNbufferSplitSplit[1].toDouble();

    LRNbufferSplitSplit=LRNbufferSplit[104].split(' ');
    timescale = LRNbufferSplitSplit[1].toDouble();

    if(timescale>=1){
        timescalestring.setNum(timescale);
        timescalestring.append(" c");
    }else if (timescale>=0.001) {
        timescalestring.setNum(timescale*1000);
        timescalestring.append(" мc");
    }else if (timescale>=0.000001) {
        timescalestring.setNum(timescale*1000000);
        timescalestring.append(" мкc");
    }
    else if (timescale>=0.000000001) {
            timescalestring.setNum(timescale*1000000000);
            timescalestring.append(" нc");
    }

    //Курсор Х 1
    LRNbufferSplitSplit=LRNbufferSplit[29].split(' ');
    ba  =   LRNbufferSplitSplit[1];
    if(ba.isEmpty()){
        ba = LRNbufferSplitSplit[2];
        if(ba.right(2)=="ms"){
            ba.chop(2);
            cursorX1value = ba.toDouble()/1000;
            curT1.setNum(ba.toDouble(),'g',3);
            curT1.append(" мс");
        }
        else {
            if(ba.right(2)=="us"){
                ba.chop(2);
                cursorX1value = ba.toDouble()/1000000;
                curT1.setNum(ba.toDouble(),'g',3);
                curT1.append(" мкс");
            }
            else {
                if(ba.right(2)=="ns"){
                    ba.chop(2);
                    cursorX1value = ba.toDouble()/1000000000;
                    curT1.setNum(ba.toDouble(),'g',3);
                    curT1.append(" нс");
                }
                else {
                    ba.chop(2);
                    cursorX1value = ba.toDouble();
                    curT1.setNum(ba.toDouble(),'g',3);
                    curT1.append(" с");
                }
            }
        }

    }
    else{
         ba = LRNbufferSplitSplit[1];
         if(ba.right(2)=="ms"){
             ba.chop(2);
             cursorX1value = ba.toDouble()/1000;
             curT1.setNum(ba.toDouble(),'g',3);
             curT1.append(" мс");
         }
         else {
             if(ba.right(2)=="us"){
                 ba.chop(2);
                 cursorX1value = ba.toDouble()/1000000;
                 curT1.setNum(ba.toDouble(),'g',3);
                 curT1.append(" мкс");
             }
             else {
                 if(ba.right(2)=="ns"){
                     ba.chop(2);
                     cursorX1value = ba.toDouble()/1000000000;
                     curT1.setNum(ba.toDouble(),'g',3);
                     curT1.append(" нс");
                 }
                 else {
                     ba.chop(2);
                     cursorX1value = ba.toDouble();
                     curT1.setNum(ba.toDouble(),'g',3);
                     curT1.append(" с");
                 }
             }
         }
    }


    //Курсор Х 2
    LRNbufferSplitSplit=LRNbufferSplit[30].split(' ');
    ba  =   LRNbufferSplitSplit[1];
    if(ba.isEmpty()){
        ba = LRNbufferSplitSplit[2];
        if (ba.isEmpty()) {
            cursorXActive = false;
        }
        else {
            cursorXActive=true;
        }
        if(ba.right(2)=="ms"){
            ba.chop(2);
            cursorX2value = ba.toDouble()/1000;
            curT2.setNum(ba.toDouble(),'g',3);
            curT2.append(" мс");
        }
        else {
            if(ba.right(2)=="us"){
                ba.chop(2);
                cursorX2value = ba.toDouble()/1000000;
                curT2.setNum(ba.toDouble(),'g',3);
                curT2.append(" мкс");
            }
            else {
                if(ba.right(2)=="ns"){
                    ba.chop(2);
                    cursorX2value = ba.toDouble()/1000000000;
                    curT2.setNum(ba.toDouble(),'g',3);
                    curT2.append(" нс");
                }
                else {
                    ba.chop(2);
                    cursorX2value = ba.toDouble();
                    curT2.setNum(ba.toDouble(),'g',3);
                    curT2.append(" с");
                }
            }
        }

    }
    else{
         ba = LRNbufferSplitSplit[1];
         if(ba.right(2)=="ms"){
             ba.chop(2);
             cursorX2value = ba.toDouble()/1000;
             curT2.setNum(cursorX2value,'g',3);
             curT2.append(" мс");
         }
         else {
             if(ba.right(2)=="us"){
                 ba.chop(2);
                 cursorX2value = ba.toDouble()/1000000;
                 curT2.setNum(ba.toDouble(),'g',3);
                 curT2.append(" мкс");
             }
             else {
                 if(ba.right(2)=="ns"){
                     ba.chop(2);
                     cursorX2value = ba.toDouble()/1000000000;
                     curT2.setNum(ba.toDouble(),'g',3);
                     curT2.append(" нс");
                 }
                 else {
                     ba.chop(2);
                     cursorX2value = ba.toDouble();
                     curT2.setNum(ba.toDouble(),'g',3);
                     curT2.append(" с");
                 }
             }
         }
    }

    //Курсор У1
    LRNbufferSplitSplit=LRNbufferSplit[28].split(' ');
    if(LRNbufferSplitSplit[1]=="1"){
        LRNbufferSplitSplit=LRNbufferSplit[31].split(' ');
        ba  =   LRNbufferSplitSplit[1];
        if (ba.isEmpty()) {
            ba = LRNbufferSplitSplit[2];
            if(ba.isEmpty()){
                cursorYActive = false;
            }
            else {
                cursorYActive = true;
                if(ba.right(2)=="mV"){
                    ba.chop(2);
                    cursorY1value = ((ba.toDouble()/1000)+offset1)/scale1;
                    curV1.setNum(ba.toDouble(),'g',6);
                    curV1.append(" мВ");
                }
                else{
                    ba.chop(2);
                    cursorY1value = (ba.toDouble()+offset1)/scale1;
                    curV1.setNum(ba.toDouble(),'g',6);
                    curV1.append(" В");
                }
            }
        }
        else{
            cursorYActive = true;
            if(ba.right(2)=="mV"){
                ba.chop(2);
                cursorY1value = ((ba.toDouble()/1000)+offset1)/scale1;
                curV1.setNum(ba.toDouble(),'g',6);
                curV1.append(" мВ");
            }
            else{
                ba.chop(2);
                cursorY1value = ((ba.toDouble())+offset1)/scale1;
                curV1.setNum(ba.toDouble(),'g',6);
                curV1.append(" В");
            }
        }

        LRNbufferSplitSplit=LRNbufferSplit[32].split(' ');
        ba  =   LRNbufferSplitSplit[1];
        if (ba.isEmpty()) {
            ba = LRNbufferSplitSplit[2];
            if(ba.isEmpty()){
            }
            else {
                if(ba.right(2)=="mV"){
                    ba.chop(2);
                    cursorY2value = ((ba.toDouble()/1000)+offset1)/scale1;
                    curV2.setNum(ba.toDouble(),'g',6);
                    curV2.append(" мВ");
                }
                else{
                    ba.chop(2);
                    cursorY2value = (ba.toDouble()+offset1)/scale1;
                    curV2.setNum(ba.toDouble(),'g',6);
                    curV2.append(" В");
                }
            }
        }
        else{
            if(ba.right(2)=="mV"){
                ba.chop(2);
                cursorY2value = ((ba.toDouble()/1000)+offset1)/scale1;
                curV2.setNum(ba.toDouble(),'g',6);
                curV2.append(" мВ");
            }
            else{
                ba.chop(2);
                cursorY2value = ((ba.toDouble())+offset1)/scale1;
                curV2.setNum(ba.toDouble(),'g',6);
                curV2.append(" В");
            }
        }
    }
    if(LRNbufferSplitSplit[1]=="2"){
        LRNbufferSplitSplit=LRNbufferSplit[31].split(' ');
        ba  =   LRNbufferSplitSplit[1];
        if (ba.isEmpty()) {
            ba = LRNbufferSplitSplit[2];
            if(ba.isEmpty()){
                cursorYActive = false;
            }
            else {
                cursorYActive = true;
                if(ba.right(2)=="mV"){
                    ba.chop(2);
                    cursorY1value = ((ba.toDouble()/1000)+offset2)/scale2;
                    curV1.setNum(ba.toDouble(),'g',6);
                    curV1.append(" мВ");
                }
                else{
                    ba.chop(2);
                    cursorY1value = (ba.toDouble()+offset2)/scale2;
                    curV1.setNum(ba.toDouble(),'g',6);
                    curV1.append(" В");
                }
            }
        }
        else{
            cursorYActive = true;
            if(ba.right(2)=="mV"){
                ba.chop(2);
                cursorY1value = ((ba.toDouble()/1000)+offset2)/scale2;
                curV1.setNum(ba.toDouble(),'g',6);
                curV1.append(" мВ");
            }
            else{
                ba.chop(2);
                cursorY1value = ((ba.toDouble())+offset2)/scale2;
                curV1.setNum(ba.toDouble(),'g',6);
                curV1.append(" В");
            }
        }

        LRNbufferSplitSplit=LRNbufferSplit[32].split(' ');
        ba  =   LRNbufferSplitSplit[1];
        if (ba.isEmpty()) {
            ba = LRNbufferSplitSplit[2];
            if(ba.isEmpty()){
            }
            else {
                if(ba.right(2)=="mV"){
                    ba.chop(2);
                    cursorY2value = ((ba.toDouble()/1000)+offset2)/scale2;
                    curV2.setNum(ba.toDouble(),'g',6);
                    curV2.append(" мВ");
                }
                else{
                    ba.chop(2);
                    cursorY2value = (ba.toDouble()+offset2)/scale2;
                    curV2.setNum(ba.toDouble(),'g',6);
                    curV2.append(" В");
                }
            }
        }
        else{
            if(ba.right(2)=="mV"){
                ba.chop(2);
                cursorY2value = ((ba.toDouble()/1000)+offset2)/scale2;
                curV2.setNum(ba.toDouble(),'g',6);
                curV2.append(" мВ");
            }
            else{
                ba.chop(2);
                cursorY2value = ((ba.toDouble())+offset2)/scale2;
                curV2.setNum(ba.toDouble(),'g',6);
                curV2.append(" В");
            }
        }
    }
    if(LRNbufferSplitSplit[1]=="5"){
        cursorYActive = false;
    }


    //Курсор Т Дельта и Частота
    LRNbufferSplitSplit=LRNbufferSplit[33].split(' ');
//    qDebug()<<"1"<<LRNbufferSplitSplit;
    ba  =   LRNbufferSplitSplit[1];
    if(ba.isEmpty()){
        ba = LRNbufferSplitSplit[2];
        if(ba.right(2)=="ms"){
            ba.chop(2);
            curTdelta.setNum(ba.toDouble(),'g',3);
            curTdelta.append(" мс");
            curTfreq.setNum((1/ba.toDouble())*1000,'g',3);
            curTfreq.append(" Гц");
        }else if (ba.right(2)=="us") {
            ba.chop(2);
            curTdelta.setNum(ba.toDouble(),'g',3);
            curTdelta.append(" мкс");
            curTfreq.setNum((1/ba.toDouble())*1000,'g',3);
            curTfreq.append(" кГц");
        }else if (ba.right(2)=="ns") {
            ba.chop(2);
            curTdelta.setNum(ba.toDouble(),'g',3);
            curTdelta.append(" нс");
            curTfreq.setNum((1/ba.toDouble())*1000,'g',3);
            curTfreq.append(" МГц");
        }
    }
    else{
        if(ba.right(2)=="ms"){
            ba.chop(2);
            curTdelta.setNum(ba.toDouble(),'g',3);
            curTdelta.append(" мс");
            curTfreq.setNum((1/ba.toDouble())*1000,'g',3);
            curTfreq.append(" Гц");
        }else if (ba.right(2)=="us") {
            ba.chop(2);
            curTdelta.setNum(ba.toDouble(),'g',3);
            curTdelta.append(" мкс");
            curTfreq.setNum((1/ba.toDouble())*1000,'g',3);
            curTfreq.append(" кГц");
        }else if (ba.right(2)=="ns") {
            ba.chop(2);
            curTdelta.setNum(ba.toDouble(),'g',3);
            curTdelta.append(" нс");
            curTfreq.setNum((1/ba.toDouble())*1000,'g',3);
            curTfreq.append(" МГц");
        }
    }

    LRNbufferSplitSplit=LRNbufferSplit[34].split(' ');
    ba  =   LRNbufferSplitSplit[2];
    if(ba.right(2)=="mV"){
        ba.chop(2);
        curVdelta=ba;
        curVdelta.append(" мВ");
    }
    else {
        ba.chop(2);
        curVdelta=ba;
        curVdelta.append(" В");
    }

    SetCursors();
}

QString BackEndEngine::getMax1()
{
    return vmax1;
}

QString BackEndEngine::getMin1()
{
    return vmin1;
}

QString BackEndEngine::getVpp1()
{
    return vpp1;
}

QString BackEndEngine::getFreq1()
{
    return freq1;
}

QString BackEndEngine::getPer1()
{
    return per1;
}

QString BackEndEngine::getMax2()
{
    return vmax2;
}

QString BackEndEngine::getMin2()
{
    return vmin2;
}

QString BackEndEngine::getVpp2()
{
    return vpp2;
}

QString BackEndEngine::getFreq2()
{
    return freq2;
}

QString BackEndEngine::getPer2()
{
    return per2;
}

QString BackEndEngine::getT1()
{
    return curT1;
}

QString BackEndEngine::getT2()
{
    return curT2;
}

QString BackEndEngine::getTdelta()
{
    return curTdelta;
}

QString BackEndEngine::getTfreq()
{
    return curTfreq;
}

QString BackEndEngine::getV1()
{
    return curV1;
}

QString BackEndEngine::getV2()
{
    return curV2;
}

QString BackEndEngine::getVdelta()
{
    return curVdelta;
}

QString BackEndEngine::getScaleChannel1()
{
    return scale1string;
}

QString BackEndEngine::getScaleChannel2()
{
    return scale2string;
}

QString BackEndEngine::getTimeScale()
{
    return timescalestring;
}

QString BackEndEngine::getErrorString()
{
    return errorstring;
}
