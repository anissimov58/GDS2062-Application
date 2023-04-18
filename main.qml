import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Dialogs 1.2
//import Bee 1.0
Item {
    id: rootbase
    width: 800
    height: 600

    property string scaleChannel1: '-'
    property string scaleChannel2: '-'
    property string timescale: '-'

    Rectangle{
        id:backgroundcolor
        color: "#393939"
        anchors.fill: parent
    }
    antialiasing : true
    Connections{
        target: bee
        onIdnReady: updateStatusText();
        onDeviceReady: {
            console.log("device Ready")
            setupwindow.visible = false
            mainScopeView.starttimer()
        }
        onDeviceFraud: {
            console.log("device Fraud")
        }
        onVmaxminfound:{
            sidePanel.vmaxValue1 = bee.getMax1();
            sidePanel.vminValue1 = bee.getMin1();
            sidePanel.vppValue1 = bee.getVpp1();
            sidePanel.freqValue1 = bee.getFreq1();
            sidePanel.perValue1 = bee.getPer1();

            sidePanel.vmaxValue2 = bee.getMax2();
            sidePanel.vminValue2 = bee.getMin2();
            sidePanel.vppValue2 = bee.getVpp2();
            sidePanel.freqValue2 = bee.getFreq2();
            sidePanel.perValue2 = bee.getPer2();

            sidePanel.cursorT1value = bee.getT1();
            sidePanel.cursorT2value = bee.getT2();
            sidePanel.cursorTdeltavalue = bee.getTdelta();
            sidePanel.cursorTFreqvalue = bee.getTfreq();

            sidePanel.cursorV1value = bee.getV1();
            sidePanel.cursorV2value = bee.getV2();
            sidePanel.cursorVdeltavalue = bee.getVdelta();

            scaleChannel1 = bee.getScaleChannel1();
            scaleChannel2 = bee.getScaleChannel2();

            timescale = bee.getTimeScale();
        }
        onErroroccured:{
            console.log("ERRRROOORRRRRRR");
            mainScopeView.stoptimer();
        }

    }
    ControlPanelTop{
        id: mainControlPanel
        height: 25
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.left: parent.left
    }

    ScopeView{
        id:mainScopeView
        anchors.rightMargin: 146
        //        anchors.rightMargin: 250
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 55
    }

    Item {
        id: element
        x: 203
        y: 576
        width: 365
        height: 24
        anchors.horizontalCenter: mainScopeView.horizontalCenter
        anchors.bottom: mainScopeView.bottom
        anchors.bottomMargin: 16

        Item {
            id: element2
            anchors.fill: parent
            anchors.rightMargin: parent.width/2

            Text {
                id: element1
                x: 30
                y: 8
                color: "#fff200"
                text: qsTr("Канал 1")
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 30
                font.pixelSize: 20
            }

            Rectangle {
                id: rectangle
                x: 4
                y: 4
                width: 16
                height: 16
                color: "#fff200"
                anchors.left: parent.left
                anchors.leftMargin: 4
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 4
            }

            Text {
                id: element3
                x: 21
                y: 8
                color: "#fff200"
                text: scaleChannel1
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.pixelSize: 20
                anchors.leftMargin: 128
            }
        }

        Item {
            id: element4
            x: 7
            y: 5
            anchors.fill: parent
            anchors.leftMargin: parent.width/2
            Text {
                id: element5
                x: 30
                y: 8
                color: "#00fff6"
                text: qsTr("Канал 2")
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                font.pixelSize: 20
                anchors.leftMargin: 30
            }

            Rectangle {
                id: rectangle1
                x: 4
                y: 4
                width: 16
                height: 16
                color: "#00fff6"
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 4
                anchors.leftMargin: 4
                anchors.bottomMargin: 4
            }

            Text {
                id: element6
                x: 21
                y: 8
                color: "#00fff6"
                text: scaleChannel2
                anchors.verticalCenterOffset: 0
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                anchors.leftMargin: 128
                font.pixelSize: 20
            }
        }
    }

    Item {
        id: element7
        x: 144
        y: 560
        anchors.fill: parent
        anchors.rightMargin: parent.width/2
        Text {
            id: element8
            x: 30
            y: 8
            color: "#fff200"
            text: timescale
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            font.pixelSize: 20
            anchors.leftMargin: 30
            anchors.bottomMargin: 16
        }
    }

    Window{
        id: setupwindow
        visible: false
        width: 640
        height: 480

        PortEnumerator{
            id: pEnumerator
            anchors.fill: parent
        }
    }

    SidePanel{
        id: sidePanel
        //        width: 146
        anchors.top: parent.top
        anchors.topMargin: 55
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.leftMargin: mainScopeView.width
        anchors.right: parent.right


    }


    //    MessageDialog{
    //        id: deviceWarning
    //        title:"Ошибка подключения"
    //        text:"Ошибка подключения. Проверьте устройство \n и порт подключения и попробуйте снова"
    //        icon: 	StandardIcon.Critical
    //        onAccepted: {
    //            deviceWarning.close()
    //        }
    //        Component.onCompleted: visible.false
    //    }
    //    Window{
    //        id: warningWrongDeviceWindow
    //        visible: false
    //        width: 320
    //        height: 240
    ////        x: 50
    ////        y: 50
    //        Rectangle {
    //            anchors.fill: parent
    //            color: "darkred"
    //            Text {
    //                id: warningWrongDeviceWindowText
    //                text: qsTr("Ошибка подключения. Проверьте устройство \n и порт подключения и попробуйте снова")
    //                anchors.centerIn: parent
    //            }
    //        }
    //    }

    function openSetUpPortWindow(){
        setupwindow.visible = true;
    }
    function closeSetUpPortWindow(){
        setupwindow.visible = false;
    }

    function timerChangeFromMain(){
        mainScopeView.timerchange();
    }

    function updateStatusText(){
        mainControlPanel.updateStatusFromMain();
    }

    function updateChannel1FromMain(){
        mainScopeView.updateChannel1FromScopeView();
    }
}



















/*##^## Designer {
    D{i:7;anchors_x:30;anchors_y:8}D{i:8;anchors_height:200}D{i:9;anchors_x:30;anchors_y:8}
D{i:6;anchors_height:200;anchors_width:200;anchors_x:94;anchors_y:0}D{i:11;anchors_x:30;anchors_y:8}
D{i:12;anchors_height:200}D{i:13;anchors_x:30;anchors_y:8}D{i:10;anchors_height:200;anchors_width:200;anchors_x:94;anchors_y:0}
D{i:5;anchors_width:200;anchors_x:203}D{i:15;anchors_x:30;anchors_y:8}D{i:14;anchors_height:200;anchors_width:200;anchors_x:94;anchors_y:0}
}
 ##^##*/
