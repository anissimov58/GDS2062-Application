import QtQuick 2.0
import QtQuick.Layouts 1.3

Item {
    id: rootPortModel
    height: 140
    antialiasing: true
    width: parent.width
    property string mport: "0"
    property string mlocation:"2"
    property string mdescription:"3"
    property string mmanufacturer:"4"
    property string mserialnumber:"5"
    property string mvendorID:"6"
    property string mproductID:"7"
    property string mbusy:"8"

    MouseArea{
        id:rootPortModelMouseArea
        anchors.fill: parent
        onClicked: {
            listviewport.currentIndex = index
        }
    }
    ColumnLayout {
        id: columnLayout
        height: 128
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        anchors.fill: parent

        Item {
            id: port
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.fillWidth: true

            Item {
                id: portlabel
                anchors.rightMargin: 3*parent.width/4
                anchors.fill: parent

                Text {
                    id: element1
                    text: qsTr("Порт:")
                    anchors.rightMargin: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                    anchors.fill: parent
                    font.pixelSize: 12
                }
            }

            Item {
                id: portdata
                anchors.leftMargin: port.width/4
                anchors.fill: parent

                Text {
                    id: element
                    text: mport
                    anchors.leftMargin: 10
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                    anchors.fill: parent
                    font.pixelSize: 12
                }
            }
        }

        Item {
            id: location
            width: 200
            height: 200
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

            Item {
                id: portlabel1
                Text {
                    id: element2
                    text: qsTr("Путь:")
                    anchors.rightMargin: 10
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.rightMargin: 3*parent.width/4
                anchors.fill: parent
            }

            Item {
                id: portdata1
                x: 8
                y: 8
                Text {
                    id: element3
                    text: mlocation
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.leftMargin: port.width/4
                anchors.fill: parent
            }
        }

        Item {
            id: description
            width: 200
            height: 200
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: true

            Item {
                id: portlabel2
                Text {
                    id: element4
                    text: qsTr("Описание:")
                    anchors.rightMargin: 10
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.rightMargin: 3*parent.width/4
                anchors.fill: parent
            }

            Item {
                id: portdata2
                x: -8
                y: -8
                Text {
                    id: element5
                    text: mdescription
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.leftMargin: port.width/4
                anchors.fill: parent
            }
        }

        Item {
            id: manufacturer
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true

            Item {
                id: portlabel3
                Text {
                    id: element6
                    text: qsTr("Производитель:")
                    anchors.rightMargin: 10
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.rightMargin: 3*parent.width/4
                anchors.fill: parent
            }

            Item {
                id: portdata3
                x: -6
                y: -6
                Text {
                    id: element7
                    text: mmanufacturer
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.leftMargin: port.width/4
                anchors.fill: parent
            }
        }

        Item {
            id: serialnumber
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true

            Item {
                id: portlabel4
                Text {
                    id: element8
                    text: qsTr("Серийный Номер:")
                    anchors.rightMargin: 10
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.rightMargin: 3*parent.width/4
                anchors.fill: parent
            }

            Item {
                id: portdata4
                x: 6
                y: 6
                Text {
                    id: element9
                    text: mserialnumber
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.leftMargin: port.width/4
                anchors.fill: parent
            }
        }

        Item {
            id: vendorID
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true

            Item {
                id: portlabel5
                Text {
                    id: element10
                    text: qsTr("ID Поставщика:")
                    anchors.rightMargin: 10
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.rightMargin: 3*parent.width/4
                anchors.fill: parent
            }

            Item {
                id: portdata5
                x: -7
                y: -7
                Text {
                    id: element11
                    text: mvendorID
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.leftMargin: port.width/4
                anchors.fill: parent
            }
        }

        Item {
            id: productID
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true

            Item {
                id: portlabel6
                Text {
                    id: element12
                    text: qsTr("ID Продукта:")
                    anchors.rightMargin: 10
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.rightMargin: 3*parent.width/4
                anchors.fill: parent
            }

            Item {
                id: portdata6
                x: 2
                y: 2
                Text {
                    id: element13
                    text: mproductID
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.leftMargin: port.width/4
                anchors.fill: parent
            }
        }

        Item {
            id: busy
            width: 200
            height: 200
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.fillWidth: true

            Item {
                id: portlabel7
                Text {
                    id: element14
                    text: qsTr("Занят?:")
                    anchors.rightMargin: 10
                    horizontalAlignment: Text.AlignRight
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.rightMargin: 3*parent.width/4
                anchors.fill: parent
            }

            Item {
                id: portdata7
                x: 5
                y: 5
                Text {
                    id: element15
                    text: mbusy
                    anchors.leftMargin: 10
                    horizontalAlignment: Text.AlignLeft
                    verticalAlignment: Text.AlignVCenter
                    anchors.fill: parent
                    font.pixelSize: 12
                }
                anchors.leftMargin: port.width/4
                anchors.fill: parent
            }
        }

    }

    Rectangle {
        id: rectangle
        color: "#00000000"
        z: -2
        anchors.fill: parent
    }

    Rectangle {
        id: rectangle1
        color: "#00000000"
        anchors.rightMargin: 5
        anchors.leftMargin: 5
        anchors.bottomMargin: 5
        anchors.topMargin: 5
        z: -1
        anchors.fill: parent
    }


}
