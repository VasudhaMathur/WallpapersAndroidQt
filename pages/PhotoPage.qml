import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

import "../components"
import "../js/scripts.js" as Scripts

Page {
    id: photoPage

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 20
            anchors.fill: parent

            ToolButton {
                contentItem: Image {
                    fillMode: Image.Pad
                    horizontalAlignment: Image.AlignHCenter
                    verticalAlignment: Image.AlignVCenter
                    source: "qrc:/images/arrow-left.png"
                }
                onClicked: {
                    stackView.pop();
                }
            }

            Label {
                id: titleLabel
                text: "Photo"
                font.pixelSize: 20
                elide: Label.ElideRight
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }
    }

    property var photoDetails

    BusyIndicator {
        id: busyIndicator
        visible: photo.status == Image.Loading
        anchors.fill: parent
    }

    Image {
        id: photo
        visible: photo.status == Image.Ready
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 2
        width: parent.width
        height: photoDetails.height/(photoDetails.width/width)
        sourceSize.width: width
        sourceSize.height: height
        clip: true
        source: photoDetails.url_image
        smooth: true
        fillMode: Image.PreserveAspectFit
    }
}
