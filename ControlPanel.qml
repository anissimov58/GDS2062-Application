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
        color: "#292929"
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
        Layout.minimumHeight: 50
        Layout.minimumWidth: 50

        Rectangle {
            id: connect
            x: 0
            width: 200
            height: 200
            color: "#00fb6f"
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
                    bee.setUp("RH220032");
                    console.log("status:"+bee.getStatus())
                    bee.sendCommand(0);//"*idn?\n"
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
                    else(bee.setUp("lolkek"))
                }
            }
        }


        Rectangle {
            id: refresh
            x: 0
            y: 0
            width: 200
            height: 200
            color: "#ff3f09"
            Layout.fillHeight: true
            Layout.fillWidth: true

            Text {
                id: element1
                text: qsTr("Обновить")
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
                    rootbase.timerChangeFromMain();
                }
            }
        }
    }
}
