import QtQuick 2.0

Item {
    Rectangle {
        id: getPortDataBackground
        color: "#ffffff"
        anchors.bottomMargin: parent.height/2
        anchors.fill: parent

        MouseArea {
            id: getPortDataMouseArea
            anchors.fill: parent
            onClicked: {
                bee.getComData()
            }
        }

        Text {
            id: getPortDataText
            text: qsTr("Собрать данные о портах")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
            font.pixelSize: 12
        }
    }

    Rectangle {
        id: recallPortDataBackground
        x: 6
        y: 8
        color: "#ffffff"
        anchors.topMargin: parent.height/2
        MouseArea {
            id: recallPortDataMouseArea
            anchors.fill: parent
            onClicked: {
                bee.recallPortData()
            }
        }

        Text {
            id: recallPortDataText
            text: qsTr("Вспомнить данные о портах")
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.fill: parent
            font.pixelSize: 12
        }
        anchors.fill: parent
    }
}
