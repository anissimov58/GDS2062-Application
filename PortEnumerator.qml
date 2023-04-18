import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.12
Item {
    id: portenumeratorelement

    ListView{
        id:listviewport
        anchors.bottomMargin: 50
        anchors.fill: parent
        flickableDirection: Flickable.VerticalFlick
        boundsBehavior: Flickable.StopAtBounds
        model: portmodel
        interactive: true
        highlight: highlight
        highlightFollowsCurrentItem: false
        onCurrentItemChanged: {
            console.log("current Item"+currentIndex)
        }
        delegate: portmodelcomponent
        spacing: 10
        focus: true
    }
    Component{
        id: highlight
        Rectangle{
            width: parent.width
            height: 140
            color: "lightsteelblue"
            y: listviewport.currentItem.y
        }
    }
    Rectangle {
        id: buttonConnect
        height: 30
        color: "#15ae37"
        width: parent.width/2

        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.right: parent.right
        anchors.rightMargin: 0
        Text {
            id: buttonConnectLable
            text: qsTr("Подключить")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                bee.closePort();
                bee.changePort(listviewport.currentIndex);
                if (bee.getStatus()===0){
                    setupwindow.visible=false;
                    console.log("setupwindow.visible=false");
                }
                else{
                    setupwindow.visible=true;
                    console.log("setupwindow.visible=true;");
                }
            }
        }
    }

    Rectangle {
        id: buttonClose
        height: 30
        color: "#ce3808"
        width: parent.width/2
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 0
        anchors.left: parent.left
        anchors.leftMargin: 0
        Text {
            id: buttonCloseLable
            text: qsTr("Отключиться")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            anchors.fill: parent
        }
        MouseArea{
            anchors.fill: parent
            onClicked: {
                bee.closePort();
                changeportmodel();
            }
        }
    }

    Component{
        id: portmodelcomponent
        PortModel{
            mport: port
            mlocation:location
            mdescription:description
            mmanufacturer:manufacturer
            mserialnumber:serialnumber
            mvendorID:vendorID
            mproductID:productID
            mbusy:busy
        }

    }
    ListModel{
        id:portmodel
    }


    function changeportmodel(){
        portmodel.clear();
        console.log("portscount:"+bee.getPortsNumber())
        for(var i=0;i<bee.getPortsNumber();i++){
            portmodel.append({
                                 "port":bee.getPortName(i),
                                 "location":bee.getPortLocation(i),
                                 "description":bee.getPortdescription(i),
                                 "manufacturer":bee.getPortManufacturer(i),
                                 "serialnumber":bee.getPortSerialNumber(i),
                                 "vendorID":bee.getPortVendorID(i),
                                 "productID":bee.getPortProductID(i),
                                 "busy":bee.getPortBusy(i)
                             })
        };
    }
}























/*##^## Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
 ##^##*/
