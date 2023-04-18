import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 1.6
import QtQuick.Controls.Styles.Desktop 1.0
import QtCharts 2.3
import QtTest 1.2

ColumnLayout {
    id: columnLayout
    spacing: 0
    Layout.minimumHeight: 25
    Layout.maximumHeight: 25
    function updateStatusFromMain(){
        statusData.text = bee.getIDN();
    }
    Rectangle {
        id: rectangle
        width: 200
        height: 25
        color: "#393939"
        Layout.fillHeight: false
        Layout.fillWidth: true

        Text {
            id: statusData
            color: "#ffffff"
            text: qsTr("Не подключен")
            anchors.leftMargin: 55
            styleColor: "#ffffff"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            anchors.fill: parent
            font.pixelSize: 12
        }

        Text {
            id: statusLabel
            width: 50
            color: "#ffffff"
            text: qsTr("Статус:")
            styleColor: "#ffffff"
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: parent.top
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignRight
            font.pixelSize: 12
        }
    }

    RowLayout{
        id: base
        spacing: 0
        Layout.minimumHeight: 30
        Layout.minimumWidth: 50

        Rectangle {
            id: connect
            x: 0
            width: 200
            height: 200
            color: "#15ae37"
            Layout.fillHeight: true
            Layout.fillWidth: true

            Text {
                id: element
                text: qsTr("Подкл.")
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                anchors.topMargin: 0
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.NoWrap
                anchors.fill: parent
                font.pixelSize: 12
            }

            MouseArea {
                id: mouseArea
                anchors.topMargin: 0
                anchors.fill: parent
                onClicked: {
                    bee.loadSettings()
                    console.log("status:"+bee.getStatus())
                }
            }

            ToolButton {
                id: toolButton
                x: 0
                height:30
                width: 30
                iconName: qsTr("")
                iconSource: "gear_icon.png"
                anchors.top: parent.top
                anchors.topMargin: 0
                anchors.right: parent.right
                anchors.rightMargin: 0
                onClicked: {
                    if (setupwindow.visible===true)
                        setupwindow.visible=false
                    else{
                        bee.getComData()
                        pEnumerator.changeportmodel();
                        setupwindow.visible=true
                    }
                }
            }
        }

        Rectangle {
            id: autosetupbase
            width: 200
            height: 200
            color: "#048de4"
            Layout.fillHeight: true
            Layout.fillWidth: true

            Text {
                id: autosetuptext
                text: qsTr("Автоуст")
                font.pixelSize: 12
                font.kerning: true
                style: Text.Normal
                font.weight: Font.Normal
                font.capitalization: Font.MixedCase
                font.strikeout: false
                font.underline: false
                font.bold: false
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                anchors.topMargin: 5
                anchors.fill: parent
                fontSizeMode: Text.HorizontalFit
                renderType: Text.NativeRendering
                textFormat: Text.RichText
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                wrapMode: Text.WordWrap
            }

            MouseArea {
                id: autosetupmouseArea
                anchors.rightMargin: 0
                anchors.fill: parent
                onClicked: {
                    console.log("clicked on: autosetupbase");
                    if(bee.getStatus()!== -1)
                        bee.sendCommand(1);//":AUToset\n"
                    else(bee.loadSettings())
                }
            }
        }


        Rectangle {
            id: refresh
            x: 0
            y: 0
            width: 200
            height: 200
            color: "#ce3808"
            Layout.fillHeight: true
            Layout.fillWidth: true

            Text {
                id: element1
                text: qsTr("Остановлено")
                anchors.rightMargin: 5
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                anchors.topMargin: 5
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
                anchors.fill: parent
                font.pixelSize: 12
            }

            MouseArea {
                id: mouseArea1
                anchors.fill: parent
                onClicked: {
                    console.log("clicked on: refresh");
                    if (bee.getStatus()===0){
                        rootbase.timerChangeFromMain();
                    }
                    else{
                        bee.loadSettings();
                    }
                }
            }
        }
    }

    function setStart(){
        refresh.color = "#15ae37";
        element1.text = "Запущено";
    }
    function setStop(){
        refresh.color = "#ce3808";
        element1.text = "Остановлено";
    }
}
