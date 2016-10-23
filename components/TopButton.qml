import QtQuick 2.6
import QtQuick.Controls 2.0

Item {
    id: root_clicky

    property var source
    property color color: "#ffffff"

    signal clicked()

    width: 48
    height: 48

    TopButtonItem {
        id: img

        width: parent.width/2
        height: width
        anchors.centerIn: parent
        source: root_clicky.source
        color: root_clicky.color
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root_clicky.clicked()
    }

}
