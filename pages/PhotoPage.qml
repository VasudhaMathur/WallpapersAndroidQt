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
            spacing: 0
            anchors {
                fill: parent
                rightMargin: 5
            }

            TopButton {
                source: Qt.resolvedUrl("../images/back.svg")
                onClicked: stackView.pop()
            }

            Label {
                id: titleLabel
                text: qsTr("Photo")
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

    Flickable {
        anchors.fill: parent
        anchors.margins: 2

        Column {
            width: parent.width
            spacing: 5

            Image {
                id: photo
                visible: photo.status == Image.Ready
                width: parent.width
                height: photoDetails.height/(photoDetails.width/width)
                sourceSize.width: width
                sourceSize.height: height
                anchors.horizontalCenter: parent.horizontalCenter
                clip: true
                source: photoDetails.url_image
                smooth: true
                fillMode: Image.PreserveAspectFit
            }
        }
    }
}
