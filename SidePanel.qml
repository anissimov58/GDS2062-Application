import QtQuick 2.0
import QtQuick.Controls 2.5
Item {
    id: element
    anchors.fill: parent

    property string freqValue1: '-'
    property string perValue1: '-'
    property string vppValue1: '-'
    property string vmaxValue1: '-'
    property string vminValue1: '-'

    property string freqValue2: '-'
    property string perValue2: '-'
    property string vppValue2: '-'
    property string vmaxValue2: '-'
    property string vminValue2: '-'

    property string cursorT1value: '-'
    property string cursorT2value: '-'
    property string cursorTdeltavalue: '-'
    property string cursorTFreqvalue: '-'

    property string cursorV1value: '-'
    property string cursorV2value: '-'
    property string cursorVdeltavalue: '-'

    Rectangle{
        id: rectangle
        color: "#191919"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.top: parent.top
        anchors.topMargin: 0
        anchors.right: parent.right
        anchors.left: parent.left

        Item {
            id: element1
            height: 501
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.right: parent.right
            anchors.rightMargin: 0
            anchors.left: parent.left
            anchors.leftMargin: 0

            Rectangle {
                id: rectangle2
                x: 256
                y: 160
                width: 128
                height: 64
                color: "#464646"
                radius: 3
                border.width: 2
                border.color: "#969696"
                anchors.horizontalCenterOffset: 0
                anchors.top: rectangle1.bottom
                anchors.topMargin: 8
                Text {
                    id: element9
                    x: 75
                    color: "#ffffff"
                    text: qsTr("Vmin")
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    renderType: Text.NativeRendering
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: element12
                    width: 16
                    color: "#ffffff"
                    text: qsTr("1:")
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 29
                }

                Text {
                    id: element13
                    x: 2
                    y: 27
                    width: 16
                    color: "#ffffff"
                    text: qsTr("2:")
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 10
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.bottomMargin: 4
                }

                Text {
                    id: value9
                    color: "#ffffff"
                    text: vminValue1
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignLeft
                    anchors.leftMargin: 35
                    anchors.bottomMargin: 29
                }

                Text {
                    id: value18
                    y: 184
                    color: "#ffffff"
                    text: vminValue2
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.leftMargin: 35
                    anchors.bottomMargin: 4
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: rectangle1
                x: 256
                y: 88
                width: 128
                height: 64
                color: "#464646"
                radius: 3
                border.color: "#969696"
                antialiasing: true
                border.width: 2
                anchors.top: parent.top
                anchors.topMargin: 8
                anchors.horizontalCenter: parent.horizontalCenter

                Text {
                    id: element3
                    x: 75
                    color: "#ffffff"
                    text: qsTr("Vmax")
                    renderType: Text.NativeRendering
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    anchors.horizontalCenter: parent.horizontalCenter
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                }

                Text {
                    id: element4
                    width: 16
                    color: "#ffffff"
                    text: qsTr("1:")
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 29
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: element5
                    x: 2
                    y: 27
                    width: 16
                    color: "#ffffff"
                    text: qsTr("2:")
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 4
                }

                Text {
                    id: value6
                    color: "#ffffff"
                    text: vmaxValue1
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 29
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.left: parent.left
                    anchors.leftMargin: 35
                    font.pixelSize: 16
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Text {
                    id: value15
                    y: 184
                    color: "#ffffff"
                    text: vmaxValue2
                    anchors.left: parent.left
                    anchors.leftMargin: 35
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 4
                    font.pixelSize: 16
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                }
            }

            Rectangle {
                id: rectangle3
                x: 256
                y: 232
                width: 128
                height: 64
                color: "#464646"
                radius: 3
                border.width: 2
                border.color: "#969696"
                anchors.top: rectangle2.bottom
                anchors.topMargin: 8
                anchors.horizontalCenterOffset: 0
                Text {
                    id: element14
                    x: 75
                    color: "#ffffff"
                    text: qsTr("Vp-p")
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    renderType: Text.NativeRendering
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: element18
                    width: 16
                    color: "#ffffff"
                    text: qsTr("1:")
                    renderType: Text.NativeRendering
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.leftMargin: 10
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.bottomMargin: 29
                }

                Text {
                    id: element19
                    x: 2
                    y: 27
                    width: 16
                    color: "#ffffff"
                    text: qsTr("2:")
                    renderType: Text.NativeRendering
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 4
                }

                Text {
                    id: value12
                    color: "#ffffff"
                    text: vppValue1
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.leftMargin: 35
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 16
                    anchors.bottomMargin: 29
                }

                Text {
                    id: value19
                    y: 184
                    color: "#ffffff"
                    text: vppValue2
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 35
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.bottomMargin: 4
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: rectangle4
                x: 256
                y: 304
                width: 128
                height: 64
                color: "#464646"
                radius: 3
                border.width: 2
                border.color: "#969696"
                anchors.horizontalCenterOffset: 0
                anchors.top: rectangle3.bottom
                anchors.topMargin: 8
                Text {
                    id: element20
                    x: 75
                    color: "#ffffff"
                    text: qsTr("Частота")
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    renderType: Text.NativeRendering
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: element21
                    width: 16
                    color: "#ffffff"
                    text: qsTr("1:")
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 29
                }

                Text {
                    id: element22
                    x: 2
                    y: 27
                    width: 16
                    color: "#ffffff"
                    text: qsTr("2:")
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 10
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.bottomMargin: 4
                }

                Text {
                    id: value13
                    color: "#ffffff"
                    text: freqValue1
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignLeft
                    anchors.leftMargin: 28
                    anchors.bottomMargin: 29
                }

                Text {
                    id: value20
                    y: 184
                    color: "#ffffff"
                    text: freqValue2
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.leftMargin: 28
                    anchors.bottomMargin: 4
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: rectangle5
                x: 256
                y: 376
                width: 128
                height: 64
                color: "#464646"
                radius: 3
                border.width: 2
                border.color: "#969696"
                anchors.horizontalCenterOffset: 0
                anchors.top: rectangle4.bottom
                anchors.topMargin: 8
                Text {
                    id: element23
                    x: 75
                    color: "#ffffff"
                    text: qsTr("Период")
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    renderType: Text.NativeRendering
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: element24
                    width: 16
                    color: "#ffffff"
                    text: qsTr("1:")
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.leftMargin: 10
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.bottomMargin: 29
                }

                Text {
                    id: element25
                    x: 2
                    y: 27
                    width: 16
                    color: "#ffffff"
                    text: qsTr("2:")
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.leftMargin: 10
                    anchors.bottomMargin: 4
                }

                Text {
                    id: value14
                    color: "#ffffff"
                    text: perValue1
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.leftMargin: 28
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 16
                    anchors.bottomMargin: 29
                }

                Text {
                    id: value21
                    y: 184
                    color: "#ffffff"
                    text: perValue2
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom
                    verticalAlignment: Text.AlignVCenter
                    anchors.leftMargin: 28
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.bottomMargin: 4
                }
                anchors.horizontalCenter: parent.horizontalCenter
            }

            Rectangle {
                id: rectangle6
                x: 256
                y: 448
                width: 128
                height: 128
                color: "#045617"
                radius: 1
                anchors.horizontalCenterOffset: 0
                anchors.top: rectangle5.bottom
                anchors.topMargin: 8
                Text {
                    id: element26
                    x: 75
                    color: "#ffffff"
                    text: qsTr("Курсор T")
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    renderType: Text.NativeRendering
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: element27
                    width: 16
                    color: "#ffffff"
                    text: "T1:"
                    lineHeight: 1
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.leftMargin: 10
                }

                Text {
                    id: element28
                    width: 16
                    color: "#ffffff"
                    text: qsTr("T2:")
                    anchors.left: parent.left
                    anchors.leftMargin: 10
                    anchors.top: element27.bottom
                    anchors.topMargin: 0
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: value16
                    color: "#ffffff"
                    text: cursorT1value
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignLeft
                    anchors.leftMargin: 30
                }

                Text {
                    id: value22
                    color: "#ffffff"
                    text: cursorT2value
                    anchors.top: value16.bottom
                    anchors.topMargin: 0
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.leftMargin: 30
                }

                Text {
                    id: element29
                    x: -1
                    width: 16
                    color: "#ffffff"
                    text: "\u0394"+":"
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: element28.bottom
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.leftMargin: 10
                }

                Text {
                    id: value23
                    x: -4
                    color: "#ffffff"
                    text: cursorTdeltavalue
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: value22.bottom
                    anchors.topMargin: 0
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.leftMargin: 30
                }

                Text {
                    id: element30
                    x: -1
                    width: 16
                    color: "#ffffff"
                    text: "f:"
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: element29.bottom
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.leftMargin: 10
                }

                Text {
                    id: value24
                    x: -4
                    color: "#ffffff"
                    text: cursorTFreqvalue
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: value23.bottom
                    anchors.topMargin: 0
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.leftMargin: 30
                }
                anchors.horizontalCenter: parent.horizontalCenter
                border.color: "#969696"
                border.width: 2
            }

            Rectangle {
                id: rectangle7
                x: 251
                width: 128
                height: 103
                color: "#4e0303"
                radius: 1
                anchors.horizontalCenterOffset: 0
                anchors.top: rectangle6.bottom
                anchors.topMargin: 8
                Text {
                    id: element31
                    x: 75
                    color: "#ffffff"
                    text: qsTr("Курсор V")
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    renderType: Text.NativeRendering
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Text {
                    id: element32
                    width: 16
                    color: "#ffffff"
                    text: "V1:"
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.leftMargin: 10
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    lineHeight: 1
                }

                Text {
                    id: element33
                    width: 16
                    color: "#ffffff"
                    text: qsTr("V2:")
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: element32.bottom
                    anchors.topMargin: 0
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                    anchors.leftMargin: 10
                }

                Text {
                    id: value17
                    color: "#ffffff"
                    text: cursorV1value
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: parent.top
                    anchors.topMargin: 30
                    anchors.leftMargin: 30
                    horizontalAlignment: Text.AlignLeft
                    font.pixelSize: 16
                }

                Text {
                    id: value25
                    color: "#ffffff"
                    text: cursorV2value
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: value17.bottom
                    anchors.topMargin: 0
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                    anchors.leftMargin: 30
                }

                Text {
                    id: element34
                    x: -1
                    width: 16
                    color: "#ffffff"
                    text: "\u0394"+":"
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: element33.bottom
                    anchors.topMargin: 0
                    anchors.leftMargin: 10
                    font.pixelSize: 16
                    horizontalAlignment: Text.AlignHCenter
                }

                Text {
                    id: value26
                    x: -4
                    color: "#ffffff"
                    text: cursorVdeltavalue
                    anchors.left: parent.left
                    verticalAlignment: Text.AlignVCenter
                    anchors.top: value25.bottom
                    anchors.topMargin: 0
                    anchors.leftMargin: 30
                    horizontalAlignment: Text.AlignHCenter
                    font.pixelSize: 16
                }
                anchors.horizontalCenter: parent.horizontalCenter
                border.color: "#969696"
                border.width: 2
            }
        }
    }
}
