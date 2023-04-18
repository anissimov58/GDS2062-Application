import QtQuick 2.12
import QtCharts 2.3

ChartView {
    id: chartView
    animationOptions: ChartView.NoAnimation
    theme: ChartView.ChartThemeDark
    antialiasing : true
    property bool openGL: true
    property bool openGLSupported: true
    backgroundColor: "Black"
    legend.visible: false
//    legend: false
//    animationOptions: ChartView.SeriesAnimations
//    animationEasingCurve: Easing.OutElastic;
//    animationDuration: 10000
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
        bee.getSeriesFromQML(chartView.series(0),chartView.series(1));
//        bee.updateChannel2(chartView.series(1));
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
//        minorGridLinePen:
    }

//    Pen{

//    }

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
        min: 126
        max: 375
        tickCount: 11
        minorTickCount: 4
        minorGridLineColor: "#353535"
        labelsVisible: false
        gridLineColor: "#555555"
    }
    ValueAxis {
        id: axisX2
        min: 126
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
//        axisX: axisX
        axisXTop: axisX2
//        axisY: axisY
        axisYRight: axisY
        useOpenGL: chartView.openGL
        color: "#fff200"

    }
//    ScatterSeries {
//        id: lineSeries1
//        name: "signal 1"
//        axisX: axisX
//        axisY: axisY1
//        useOpenGL: chartView.openGL

//    }
    LineSeries {
        id: lineSeries2
        name: "signal 2"

        axisX: axisX
//        axisXTop: axisX2
        axisY: axisY2
//        axisYRight: axisY2
        useOpenGL: chartView.openGL
        color: "#00fff6"
    }
    Timer{
        id:updatetimer2
        interval: 1 * 1000 // 1 Гц
        repeat: true
        running: false
        onTriggered: {
            bee.getSeriesFromQML(chartView.series(0),chartView.series(1));
            rootbase.updateChannel1FromMain();
        }
        onRunningChanged: {
            if (running)
                mainControlPanel.setStart()
            else
                mainControlPanel.setStop()
        }
    }

    Rectangle {
        id: rectangle
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
        id: rectangle1
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

    function timerchange(){
        if (updatetimer2.running == true)
            updatetimer2.running = false
        else
            updatetimer2.running = true
    }

//    function getTimerstatus(){
//        return updatetimer2.running
//    }

    function updateChannel1FromScopeView(){
        bee.sendCommand(3);//        ":chan1:offs?\n" это запустит цепную реакцию получения данных
        // сначала смещение потом масштаб и потом сами данные и они будут отображены
//        bee.updateChannel1(chartView.series(0));
    }
//    function updateChannel2FromScopeView(){
////        bee.updateChannel2(chartView.series(1));
//    }

}





























/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
