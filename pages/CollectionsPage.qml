import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0
import Qt.labs.settings 1.0

import "../components"
import "../js/scripts.js" as Scripts

Page {
    id: collectionsPage

    header: ToolBar {
        Material.foreground: "white"

        RowLayout {
            spacing: 0
            anchors {
                fill: parent
                rightMargin: 5
            }

            TopButton {
                source: Qt.resolvedUrl("../images/drawer.svg")
                onClicked: drawer.open()
            }

            Label {
                id: titleLabel
                text: "Collections"
                font.pixelSize: 20
                elide: Label.ElideRight
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }

            TopButton {
                source: Qt.resolvedUrl("../images/crop.svg")
                onClicked: {

                }
                width: 40
                height: 40
            }

            TopButton {
                source: Qt.resolvedUrl("../images/filters.svg")
                onClicked: {

                }
                width: 40
                height: 40
            }

            TopButton {
                source: Qt.resolvedUrl("../images/search.svg")
                onClicked: {
                    stackView.push("qrc:/pages/SearchPage.qml")
                }
                width: 40
                height: 40
            }
        }
    }
}
