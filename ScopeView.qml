import QtQuick 2.12
import QtCharts 2.3

ChartView {
    id: chartView
    animationOptions: ChartView.NoAnimation
//    theme: ChartView.ChartThemeDark
    theme: ChartView.ChartThemeLight
//    theme: ChartView.ChartThemeBlueIcy
    antialiasing : true
    property bool openGL: true
    property bool openGLSupported: true
    backgroundColor: "Black"
    legend.visible: false
    onOpenGLChanged: {
        if (openGLSupported) {
            series("signal 1").useOpenGL = openGL;
            series("signal 2").useOpenGL = openGL;
        }
    }
    Component.onCompleted: {
        if (!series("signal 1").useOpenGL) {
            openGLSupported = false
            openGL = false
        }
        bee.getSeriesFromQML(chartView.series(0),
                             chartView.series(1),
                             chartView.series(2),
                             chartView.series(3),
                             chartView.series(4),
                             chartView.series(5)
                             );
    }
    onHeightChanged: {
        if (parent.height<480){
            axisX.minorGridVisible = false
            axisX2.minorGridVisible = false
            axisY.minorGridVisible = false
            axisY2.minorGridVisible = false
        }
        else{
            axisX.minorGridVisible = true
            axisX2.minorGridVisible = true
            axisY.minorGridVisible = true
            axisY2.minorGridVisible = true
        }
    }
    onWidthChanged: {
        if (parent.width<640){
            axisX.minorGridVisible = false
            axisX2.minorGridVisible = false
            axisY.minorGridVisible = false
            axisY2.minorGridVisible = false
        }
        else{
            axisX.minorGridVisible = true
            axisX2.minorGridVisible = true
            axisY.minorGridVisible = true
            axisY2.minorGridVisible = true
        }
    }
    ValueAxis {
        id: axisY
        min: -4
        max: 4
        tickCount: 9
        labelsColor: "#909090"
        gridLineColor: "#555555"
        labelsVisible: false
        minorTickCount: 4
        minorGridLineColor: "#353535"
    }


    ValueAxis {
        id: axisY2
        min: -4
        max: 4
        tickCount: 9
        labelsColor: "#909090"
        gridLineColor: "#555555"
        labelsVisible: false
        minorTickCount: 4
        minorGridLineColor: "#353535"
    }

    ValueAxis {
        id: axisX
        min: 125
        max: 375
        tickCount: 11
        minorTickCount: 4
        minorGridLineColor: "#353535"
        labelsVisible: false
        gridLineColor: "#555555"
    }
    ValueAxis {
        id: axisX2
        min: 125
        max: 375
        tickCount: 11
        minorTickCount: 4
        minorGridLineColor: "#353535"
        labelsVisible: false
        gridLineColor: "#555555"
    }

    LineSeries {
        id: lineSeries1
        name: "signal 1"
        axisXTop: axisX2
        axisYRight: axisY
        useOpenGL: chartView.openGL
        color: "#fff200"

    }

    LineSeries {
        id: lineSeries2
        name: "signal 2"

        axisX: axisX
        axisY: axisY2
        useOpenGL: chartView.openGL
        color: "#00fff6"
    }

    LineSeries {
        id: cursorX1
        name: "cursor X1"
        axisXTop: axisX2
        axisYRight: axisY
        useOpenGL: chartView.openGL
        color: "#0dff0d"

    }

    LineSeries {
        id: cursorX2
        name: "cursor X2"
        axisXTop: axisX2
        axisYRight: axisY
        useOpenGL: chartView.openGL
        color: "#0dff0d"

    }

    LineSeries {
        id: cursorY1
        name: "cursor Y1"
        axisXTop: axisX2
        axisYRight: axisY
        useOpenGL: chartView.openGL
        color: "#FF0000"

    }

    LineSeries {
        id: cursorY2
        name: "cursor Y2"
        axisXTop: axisX2
        axisYRight: axisY
        useOpenGL: chartView.openGL
        color: "#FF0000"

    }
    Timer{
        id:updatetimer2
//        interval: 1000
        interval: 2*1000
//        interval: 2 * 1000 // 1 Гц
//        interval: 1/5 * 1000 // 1 Гц
        repeat: true
        running: false
        onTriggered: {
            bee.getSeriesFromQML(chartView.series(0),
                                 chartView.series(1),
                                 chartView.series(2),
                                 chartView.series(3),
                                 chartView.series(4),
                                 chartView.series(5)
                                 );
            bee.sendCommand(12);
        }
        onRunningChanged: {
            if (running)
                mainControlPanel.setStart()
            else
                mainControlPanel.setStop()
        }
    }

    Rectangle {
        id: yaxis
        y: 181
        height: 1
        color: "#898989"
        anchors.verticalCenterOffset: 0
        anchors.left: parent.left
        anchors.leftMargin: 45
        anchors.right: parent.right
        anchors.rightMargin: 45
        anchors.verticalCenter: parent.verticalCenter
    }

    Rectangle {
        id: xaxis
        x: 44
        width: 1
        color: "#898989"
        anchors.horizontalCenterOffset: 0
        anchors.top: parent.top
        anchors.topMargin: 45
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 45
        anchors.horizontalCenter: parent.horizontalCenter
    }

    function starttimer(){
        updatetimer2.start()
    }

    function stoptimer(){
        updatetimer2.stop()
    }
    function timerchange(){
        if (updatetimer2.running == true)
            updatetimer2.running = false
        else
            updatetimer2.running = true
    }

    function updateChannel1FromScopeView(){
        bee.sendCommand(3);//        ":chan1:offs?\n" это запустит цепную реакцию получения данных
    }
}
